#!/usr/bin/env bash

MY_DATABASE="ec2.db"
CSV_EXPORT="aws-instances-locations.csv"
SQL_EXPORT="aws-instances-locations.sql"

echo "Export"
echo -e "\tSQL"
echo > "$SQL_EXPORT" || exit 9
MY_TABLES=(
	"instance-disks"
	"instance-gpus"
	"instance-host-prices"
	"instance-network-cards"
	"instance-shared-prices"
	"instance-types"
	"locations"
	"storage-prices"
	"storage-types"
)
for MY_TABLE in "${MY_TABLES[@]}"; do
	{
		echo "DROP TABLE IF EXISTS \"$MY_TABLE\";"
		sqlite3 "$MY_DATABASE" ".dump $MY_TABLE"
	} >> "$SQL_EXPORT" || exit 9
done
gzip -fk "$SQL_EXPORT" || exit 9

echo -e "\tCSV"
sqlite3 -header -csv "$MY_DATABASE" < "./select/all-instances-regions.sql" > "$CSV_EXPORT" || exit 9