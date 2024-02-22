INSERT INTO "storage-types" (
	"storage",
	"storageType",
	"storageMedia",
	"maxVolumeSize",
	"maxThroughput",
	"maxIops"
)
SELECT
	"Volume API Name" AS "storage",
	"Volume Type" AS "storageType",
	"Storage Media" AS "storageMedia",
	"Max Volume Size" AS "maxVolumeSize" ,
	"Max throughput/volume" AS "maxThroughput",
	"Max IOPS/volume" AS "maxIops"
FROM "us-east-1" S
WHERE "Product Family" = 'Storage'
GROUP BY "Volume API Name";