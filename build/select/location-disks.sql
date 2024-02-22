SELECT
P."storage",
S."storageType",
S."storageMedia",
S."maxVolumeSize",
S."maxIops",
S."maxThroughput",
ROUND(P."priceGb", 4) AS "priceGb",
ROUND(P."priceIops", 4) AS "priceIops",
ROUND(P."priceThroughput", 4) AS "priceThroughput"
FROM "storage-prices" P
INNER JOIN "storage-types" S ON P."storage" = S."storage"
WHERE P."location" = "us-east-1"
ORDER BY P."storage";