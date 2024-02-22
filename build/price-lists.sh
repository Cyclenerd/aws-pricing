#!/usr/bin/env bash

# Copyright 2024 Nils Knieling. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Download and import Amazon EC2 and EBS price lists
#

MY_DATABASE="ec2.db"

mkdir -p "./import" || exit 9

# Get price lists via API URLs
#MY_REGION="eu-central-1"
#MY_DATE_TIME=$(date "+%Y-%m-%d %H:%M")
#MY_PRICE_LISTS_CSV="price-lists.csv"
#MY_PRICE_LIST_URLS_CSV="price-list-urls.csv"
#aws pricing list-price-lists \
#	--service-code AmazonEC2 \
#	--currency-code USD \
#	--effective-date "$MY_DATE_TIME" \
#	--region eu-central-1 \
#	--output json > price-lists.json || exit 9
#
# Convert JSON to CSV
#jq -r ".PriceLists[] | [.RegionCode, .PriceListArn] | @csv" price-lists.json > "$MY_PRICE_LISTS_CSV" || exit 9
#
# Get price list URLs
#echo -n > "$MY_PRICE_LIST_URLS_CSV" || exit 9
#while IFS="," read -r REGION_CODE PRICE_LIST_ARN
#do
#	REGION_CODE="${REGION_CODE//\"/}"
#	PRICE_LIST_ARN="${PRICE_LIST_ARN//\"/}"
#	echo "URL: $REGION_CODE"
#	echo -n "$REGION_CODE," >> "$MY_PRICE_LIST_URLS_CSV"
#	aws pricing get-price-list-file-url \
#		--price-list-arn "$PRICE_LIST_ARN" \
#		--file-format csv \
#		--region "$MY_REGION" | jq -r '.Url' >> "$MY_PRICE_LIST_URLS_CSV"
#done < "$MY_PRICE_LISTS_CSV"
#
# Download price lists
#while IFS="," read -r REGION_CODE PRICE_LIST_URL
#do
#	curl "$PRICE_LIST_URL" -o "./import/download.csv" || exit 9
#	tail -n +6 "./import/download.csv" > "./import/$REGION_CODE.csv" || exit 9
#done < "$MY_PRICE_LIST_URLS_CSV"

# Get price lists via public URLs
jq -r ".[].code" "locations.json" > locations.txt || exit 9

# Download price lists
echo "Download:"
while read -r REGION_CODE; do
	echo "$REGION_CODE"
	if curl --fail "https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonEC2/current/$REGION_CODE/index.csv" -o "./import/download.csv"; then
		tail -n +6 "./import/download.csv" > "./import/$REGION_CODE.csv" || exit 9
	fi
	rm -f "./import/download.csv"
done < "locations.txt"

# Import price lists
echo "Import:"
while read -r REGION_CODE; do
	echo "$REGION_CODE"
	# Skip empty files
	if [ -s "./import/$REGION_CODE.csv" ]; then
		# Patch missing PurchaseOption and OfferingClass for local zones
		if ! grep "PurchaseOption" "./import/$REGION_CODE.csv" > /dev/null; then
			perl -i -pe's|"serviceCode"|"serviceCode","PurchaseOption"|g' "./import/$REGION_CODE.csv" || exit 9
			perl -i -pe's|"AmazonEC2"|"AmazonEC2",""|g' "./import/$REGION_CODE.csv" || exit 9
		fi
		if ! grep "OfferingClass" "./import/$REGION_CODE.csv" > /dev/null; then
			perl -i -pe's|"serviceCode"|"serviceCode","OfferingClass"|g' "./import/$REGION_CODE.csv" || exit 9
			perl -i -pe's|"AmazonEC2"|"AmazonEC2","standard"|g' "./import/$REGION_CODE.csv" || exit 9
		fi
		# Patch missing "Volume API Name" and Group
		if ! grep "Volume API Name" "./import/$REGION_CODE.csv" > /dev/null; then
			perl -i -pe's|"serviceCode"|"serviceCode","Volume API Name"|g' "./import/$REGION_CODE.csv" || exit 9
			perl -i -pe's|"AmazonEC2"|"AmazonEC2",""|g' "./import/$REGION_CODE.csv" || exit 9
		fi
		if ! grep "Group" "./import/$REGION_CODE.csv" > /dev/null; then
			perl -i -pe's|"serviceCode"|"serviceCode","Group"|g' "./import/$REGION_CODE.csv" || exit 9
			perl -i -pe's|"AmazonEC2"|"AmazonEC2",""|g' "./import/$REGION_CODE.csv" || exit 9
		fi
		sqlite3 "$MY_DATABASE" "DROP TABLE IF EXISTS \"$REGION_CODE\";" || exit 9
		sqlite3 "$MY_DATABASE" ".import --csv ./import/$REGION_CODE.csv $REGION_CODE" || exit 9
		sqlite3 "$MY_DATABASE" "CREATE INDEX IF NOT EXISTS \"$REGION_CODE-instance-index\" ON \"$REGION_CODE\"('Instance Type', TermType, Tenancy, 'License Model', CapacityStatus, 'Operating System', 'Pre Installed S/W', OfferingClass, Unit, PurchaseOption COLLATE NOCASE)" || exit 9
		sqlite3 "$MY_DATABASE" "CREATE INDEX IF NOT EXISTS \"$REGION_CODE-storage-index\" ON \"$REGION_CODE\"('Volume API Name', 'Product Family', 'Group', Unit COLLATE NOCASE)" || exit 9
		# Calculate prices
		cp "./instance-shared-prices.sql" "./import/$REGION_CODE-shared-prices.sql" || exit 9
		perl -i -pe"s|us-east-1|$REGION_CODE|g" "./import/$REGION_CODE-shared-prices.sql" || exit 9
		sqlite3 "$MY_DATABASE" < "./import/$REGION_CODE-shared-prices.sql" || exit 9
		cp "./instance-host-prices.sql" "./import/$REGION_CODE-host-prices.sql" || exit 9
		perl -i -pe"s|us-east-1|$REGION_CODE|g" "./import/$REGION_CODE-host-prices.sql" || exit 9
		sqlite3 "$MY_DATABASE" < "./import/$REGION_CODE-host-prices.sql" || exit 9
		cp "./storage-prices.sql" "./import/$REGION_CODE-storage-prices.sql" || exit 9
		perl -i -pe"s|us-east-1|$REGION_CODE|g" "./import/$REGION_CODE-storage-prices.sql" || exit 9
		sqlite3 "$MY_DATABASE" < "./import/$REGION_CODE-storage-prices.sql" || exit 9
	fi
done < "locations.txt"

echo
echo "Apply Amazon EC2 Mac instances fix"
sqlite3 "$MY_DATABASE" < "mac-on-demand-fix.sql" || exit 9

echo
echo "DONE"