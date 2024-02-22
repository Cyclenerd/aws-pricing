INSERT INTO "storage-prices" (
	"storage",
	"location",
	"priceGb",
	"priceIops",
	"priceThroughput"
)
SELECT
	"Volume API Name" AS "storage",
	LOWER("us-east-1") AS "location",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Volume API Name" = S."Volume API Name"
		AND "Product Family" = 'Storage'
		AND "Unit" LIKE "GB%"
	) AS "priceGb",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Volume API Name" = S."Volume API Name"
		AND "Product Family" = 'System Operation'
		AND "Group" = 'EBS IOPS'
		AND "Unit" LIKE "IOPS%"
	) AS "priceIops",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Volume API Name" = S."Volume API Name"
		AND "Product Family" = 'Provisioned Throughput'
		AND "Group" = 'EBS Throughput'
		AND "Unit" LIKE "GiBps%"
	) AS "priceThroughput"
FROM "us-east-1" S
WHERE "Product Family" = 'Storage'
GROUP BY "Volume API Name";