REPLACE INTO "instance-shared-prices" (
	"instanceType",
	"location",
	"onDemandLinuxHr"
)
SELECT
P."instanceType",
P."location",
(
	SELECT ROUND("onDemandLinuxHr", 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "onDemandLinuxHr" > "0.000001"
) AS "onDemandLinuxHr"
FROM "instance-shared-prices" P
INNER JOIN "instance-types" I ON P."instanceType" = I."instanceType"
WHERE P."instanceType" LIKE "mac%";