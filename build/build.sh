#!/usr/bin/env bash

MY_DATABASE="ec2.db"

# Create Database
sqlite3 "$MY_DATABASE" < create.sql || exit 9

# Locations
curl -O --fail "https://b0.p.awsstatic.com/locations/1.0/aws/current/locations.json" || exit 9
perl locations.pl < locations.json || exit 9

# IP Ranges
curl -O --fail "https://ip-ranges.amazonaws.com/ip-ranges.json" || exit 9
perl ip-ranges.pl < ip-ranges.json || exit 9

# Prices
bash price-lists.sh || exit 9
# Spot price
curl -O --fail "https://website.spot.ec2.aws.a2z.com/spot.json" || exit 9
perl spot.pl < spot.json || exit 9

# Instace Types (EC2)
aws ec2 describe-instance-types --region us-east-1 --output json > instance-types.json || exit 9
perl instance-types.pl < instance-types.json || exit 9

# Storage Types (EBS)
sqlite3 "$MY_DATABASE" < storage-types.sql || exit 9

# SAP
perl sap.pl || exit 9
perl sap-hana.pl || exit 9

# Export
bash export.sh || exit 9

# Websites
perl web.pl || exit 9

echo "DONE"