SELECT
I."instanceType",
I."instanceFamily",
I."instanceFamilyName",
I."currentGeneration",
I."freeTierEligible",
I."supportedUsageClasses",
I."supportedRootDeviceTypes",
I."supportedVirtualizationTypes",
I."bareMetal",
I."hypervisor",
I."processorArchitectures",
I."processorClockSpeedInGhz",
I."processorManufacturer",
I."processor",
I."processorFeatures",
I."vCpus",
I."vCpuCores",
I."vCpuThreadsPerCore",
I."memorySizeInMiB",
ROUND(I."memorySizeInMiB"/1024, 2) AS "memorySizeInGiB",
I."storage",
I."storageSupported",
I."storageTotalSizeInGB",
I."storageNvmeSupport",
I."storageEncryptionSupport",
I."ebsOptimizedSupport",
I."ebsEncryptionSupport",
I."ebsOptimizedBaselineBandwidthInMbps",
I."ebsOptimizedBaselineThroughputInMBps",
I."ebsOptimizedBaselineIops",
I."ebsOptimizedMaxBandwidthInMbps",
I."ebsOptimizedMaxThroughputInMBps",
I."ebsOptimizedMaxIops",
I."ebsNvmeSupport",
I."networkPerformance",
I."maxNetworkInterfaces",
I."maxNetworkCards",
I."ipv4AddrPerInterface",
I."ipv6AddrPerInterface",
I."ipv6Supported",
I."enaSupport",
I."efaSupported",
I."encryptionInTransitSupported",
I."enaSrdSupported",
I."gpuTotalGpuMemoryInMiB",
ROUND(I."gpuTotalGpuMemoryInMiB"/1024, 2) AS "gpuTotalGpuMemoryInGiB",
MAX(G."count") AS "gpuCount",
MAX(G."manufacturer") AS "gpuManufacturer",
MAX(G."name") AS "gpuName",
MAX(G."memorySizeInMiB") AS "gpuMemorySizeInMiB",
I."placementGroupSupportedStrategies",
I."hibernationSupported",
I."burstablePerformanceSupported",
I."dedicatedHostsSupported",
I."autoRecoverySupported",
I."supportedBootModes",
I."nitroEnclavesSupport",
I."nitroTpmSupport",
I."nitroTpmSupportedVersions",
I."sapSupported",
I."sapHanaSupported",
I."sapSaps",
/* Stats */
COUNT(I."instanceType") AS "locationsWithInstanceTypeCount",
/* Host */
(
	SELECT ROUND(MIN("onDemandLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "onDemandLinuxHr" > "0.000001"
) AS "minOnDemandLinuxHostHr",
(
	SELECT ROUND(MIN("onDemandLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "onDemandLinuxHr" > "0.000001"
) AS "minOnDemandLinuxHostMonth",
(
	SELECT ROUND(AVG("onDemandLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "onDemandLinuxHr" > "0.000001"
) AS "avgOnDemandLinuxHostHr",
(
	SELECT ROUND(AVG("onDemandLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "onDemandLinuxHr" > "0.000001"
) AS "avgOnDemandLinuxHostMonth",
(
	SELECT ROUND(MAX("onDemandLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "onDemandLinuxHr" > "0.000001"
) AS "maxOnDemandLinuxHostHr",
(
	SELECT ROUND(MAX("onDemandLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "onDemandLinuxHr" > "0.000001"
) AS "maxOnDemandLinuxHostMonth",
/* Host - Reserved 1Y no upfront */
(
	SELECT ROUND(MIN("reserved1yNoUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yNoUpfrontLinuxHr" > "0.000001"
) AS "minReserved1yNoUpfrontLinuxHostHr",
(
	SELECT ROUND(MIN("reserved1yNoUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yNoUpfrontLinuxHr" > "0.000001"
) AS "minReserved1yNoUpfrontLinuxHostMonth",
(
	SELECT ROUND(AVG("reserved1yNoUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yNoUpfrontLinuxHr" > "0.000001"
) AS "avgReserved1yNoUpfrontLinuxHostHr",
(
	SELECT ROUND(AVG("reserved1yNoUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yNoUpfrontLinuxHr" > "0.000001"
) AS "avgReserved1yNoUpfrontLinuxHostMonth",
(
	SELECT ROUND(MAX("reserved1yNoUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yNoUpfrontLinuxHr" > "0.000001"
) AS "maxReserved1yNoUpfrontLinuxHostHr",
(
	SELECT ROUND(MAX("reserved1yNoUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yNoUpfrontLinuxHr" > "0.000001"
) AS "maxReserved1yNoUpfrontLinuxHostMonth",
/* Host - Reserved 3Y no upfront*/
(
	SELECT ROUND(MIN("reserved3yNoUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yNoUpfrontLinuxHr" > "0.000001"
) AS "minReserved3yNoUpfrontLinuxHostHr",
(
	SELECT ROUND(MIN("reserved3yNoUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yNoUpfrontLinuxHr" > "0.000001"
) AS "minReserved3yNoUpfrontLinuxHostMonth",
(
	SELECT ROUND(AVG("reserved3yNoUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yNoUpfrontLinuxHr" > "0.000001"
) AS "avgReserved3yNoUpfrontLinuxHostHr",
(
	SELECT ROUND(AVG("reserved3yNoUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yNoUpfrontLinuxHr" > "0.000001"
) AS "avgReserved3yNoUpfrontLinuxHostMonth",
(
	SELECT ROUND(MAX("reserved3yNoUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yNoUpfrontLinuxHr" > "0.000001"
) AS "maxReserved3yNoUpfrontLinuxHostHr",
(
	SELECT ROUND(MAX("reserved3yNoUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yNoUpfrontLinuxHr" > "0.000001"
) AS "maxReserved3yNoUpfrontLinuxHostMonth",
/* Host - Reserved 1Y all upfront */
(
	SELECT ROUND(MIN("reserved1yAllUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yAllUpfrontLinuxHr" > "0.000001"
) AS "minReserved1yAllUpfrontLinuxHostHr",
(
	SELECT ROUND(MIN("reserved1yAllUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yAllUpfrontLinuxHr" > "0.000001"
) AS "minReserved1yAllUpfrontLinuxHostMonth",
(
	SELECT ROUND(AVG("reserved1yAllUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yAllUpfrontLinuxHr" > "0.000001"
) AS "avgReserved1yAllUpfrontLinuxHostHr",
(
	SELECT ROUND(AVG("reserved1yAllUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yAllUpfrontLinuxHr" > "0.000001"
) AS "avgReserved1yAllUpfrontLinuxHostMonth",
(
	SELECT ROUND(MAX("reserved1yAllUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yAllUpfrontLinuxHr" > "0.000001"
) AS "maxReserved1yAllUpfrontLinuxHostHr",
(
	SELECT ROUND(MAX("reserved1yAllUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved1yAllUpfrontLinuxHr" > "0.000001"
) AS "maxReserved1yAllUpfrontLinuxHostMonth",
/* Host - Reserved 3Y all upfront */
(
	SELECT ROUND(MIN("reserved3yAllUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yAllUpfrontLinuxHr" > "0.000001"
) AS "minReserved3yAllUpfrontLinuxHostHr",
(
	SELECT ROUND(MIN("reserved3yAllUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yAllUpfrontLinuxHr" > "0.000001"
) AS "minReserved3yAllUpfrontLinuxHostMonth",
(
	SELECT ROUND(AVG("reserved3yAllUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yAllUpfrontLinuxHr" > "0.000001"
) AS "avgReserved3yAllUpfrontLinuxHostHr",
(
	SELECT ROUND(AVG("reserved3yAllUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yAllUpfrontLinuxHr" > "0.000001"
) AS "avgReserved3yAllUpfrontLinuxHostMonth",
(
	SELECT ROUND(MAX("reserved3yAllUpfrontLinuxHr"), 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yAllUpfrontLinuxHr" > "0.000001"
) AS "maxReserved3yAllUpfrontLinuxHostHr",
(
	SELECT ROUND(MAX("reserved3yAllUpfrontLinuxHr")*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "reserved3yAllUpfrontLinuxHr" > "0.000001"
) AS "maxReserved3yAllUpfrontLinuxHostMonth",
/* On demand */
(SELECT ROUND(MIN("onDemandLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "onDemandLinuxHr" > "0.000001") AS "minOnDemandLinuxHr",
(SELECT ROUND(MIN("onDemandLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "onDemandLinuxHr" > "0.000001") AS "minOnDemandLinuxMonth",
(SELECT ROUND(AVG("onDemandLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "onDemandLinuxHr" > "0.000001") AS "avgOnDemandLinuxHr",
(SELECT ROUND(AVG("onDemandLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "onDemandLinuxHr" > "0.000001") AS "avgOnDemandLinuxMonth",
ROUND(MAX(P."onDemandLinuxHr"), 4)     AS "maxOnDemandLinuxHr",
ROUND(MAX(P."onDemandLinuxHr")*730, 2) AS "maxOnDemandLinuxMonth",
/* Spot */
(SELECT ROUND(MIN("spotLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "spotLinuxHr" > "0.000001") AS "minSpotLinuxHr",
(SELECT ROUND(MIN("spotLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "spotLinuxHr" > "0.000001") AS "minSpotLinuxMonth",
(SELECT ROUND(AVG("spotLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "spotLinuxHr" > "0.000001") AS "avgSpotLinuxHr",
(SELECT ROUND(AVG("spotLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "spotLinuxHr" > "0.000001") AS "avgSpotLinuxMonth",
ROUND(MAX(P."spotLinuxHr"), 4)     AS "maxSpotLinuxHr",
ROUND(MAX(P."spotLinuxHr")*730, 2) AS "maxSpotLinuxMonth",
/* Reserved 1Y no upfront */
(SELECT ROUND(MIN("reserved1yNoUpfrontLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yNoUpfrontLinuxHr" > "0.000001") AS "minReserved1yNoUpfrontLinuxHr",
(SELECT ROUND(MIN("reserved1yNoUpfrontLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yNoUpfrontLinuxHr" > "0.000001") AS "minReserved1yNoUpfrontLinuxMonth",
(SELECT ROUND(AVG("reserved1yNoUpfrontLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yNoUpfrontLinuxHr" > "0.000001") AS "avgReserved1yNoUpfrontLinuxHr",
(SELECT ROUND(AVG("reserved1yNoUpfrontLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yNoUpfrontLinuxHr" > "0.000001") AS "avgReserved1yNoUpfrontLinuxMonth",
ROUND(MAX(P."reserved1yNoUpfrontLinuxHr"), 4)     AS "maxReserved1yNoUpfrontLinuxHr",
ROUND(MAX(P."reserved1yNoUpfrontLinuxHr")*730, 2) AS "maxReserved1yNoUpfrontLinuxMonth",
/* Reserved 3Y no upfront */
(SELECT ROUND(MIN("reserved3yNoUpfrontLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yNoUpfrontLinuxHr" > "0.000001") AS "minReserved3yNoUpfrontLinuxHr",
(SELECT ROUND(MIN("reserved3yNoUpfrontLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yNoUpfrontLinuxHr" > "0.000001") AS "minReserved3yNoUpfrontLinuxMonth",
(SELECT ROUND(AVG("reserved3yNoUpfrontLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yNoUpfrontLinuxHr" > "0.000001") AS "avgReserved3yNoUpfrontLinuxHr",
(SELECT ROUND(AVG("reserved3yNoUpfrontLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yNoUpfrontLinuxHr" > "0.000001") AS "avgReserved3yNoUpfrontLinuxMonth",
ROUND(MAX(P."reserved3yNoUpfrontLinuxHr"), 4)     AS "maxReserved3yNoUpfrontLinuxHr",
ROUND(MAX(P."reserved3yNoUpfrontLinuxHr")*730, 2) AS "maxReserved3yNoUpfrontLinuxMonth",
/* Reserved 1Y partial upfront */
(SELECT ROUND(MIN("reserved1yPartialUpfrontLinuxQuantity"), 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yPartialUpfrontLinuxQuantity" > "0.000001") AS "minReserved1yPartialUpfrontLinuxQuantity",
(SELECT ROUND(MIN("reserved1yPartialUpfrontLinuxHr"), 4)       FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yPartialUpfrontLinuxHr" > "0.000001") AS "minReserved1yPartialUpfrontLinuxHr",
(
	SELECT ROUND((MIN("reserved1yPartialUpfrontLinuxQuantity")/12) + (MIN("reserved1yPartialUpfrontLinuxHr")*730), 2)
	FROM "instance-shared-prices"
	WHERE "instanceType" = I."instanceType"
	AND "reserved1yPartialUpfrontLinuxQuantity" > "0.000001"
	AND "reserved1yPartialUpfrontLinuxHr" > "0.000001"
) AS "minReserved1yPartialUpfrontLinuxMonth",
(SELECT ROUND(AVG("reserved1yPartialUpfrontLinuxQuantity"), 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yPartialUpfrontLinuxQuantity" > "0.000001") AS "avgReserved1yPartialUpfrontLinuxQuantity",
(SELECT ROUND(AVG("reserved1yPartialUpfrontLinuxHr"), 4)       FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yPartialUpfrontLinuxHr" > "0.000001") AS "avgReserved1yPartialUpfrontLinuxHr",
(
	SELECT ROUND((AVG("reserved1yPartialUpfrontLinuxQuantity")/12) + (AVG("reserved1yPartialUpfrontLinuxHr")*730), 2)
	FROM "instance-shared-prices"
	WHERE "instanceType" = I."instanceType"
	AND "reserved1yPartialUpfrontLinuxQuantity" > "0.000001"
	AND "reserved1yPartialUpfrontLinuxHr" > "0.000001"
) AS "avgReserved1yPartialUpfrontLinuxMonth",
ROUND(MAX(P."reserved1yPartialUpfrontLinuxQuantity"), 2) AS "maxReserved1yPartialUpfrontLinuxQuantity",
ROUND(MAX(P."reserved1yPartialUpfrontLinuxHr"), 4)       AS "maxReserved1yPartialUpfrontLinuxHr",
ROUND((MAX("reserved1yPartialUpfrontLinuxQuantity")/12) + (MAX("reserved1yPartialUpfrontLinuxHr")*730), 2) AS "maxReserved1yPartialUpfrontLinuxMonth",
/* Reserved 3Y partial upfront */
(SELECT ROUND(MIN("reserved3yPartialUpfrontLinuxQuantity"), 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yPartialUpfrontLinuxQuantity" > "0.000001") AS "minReserved3yPartialUpfrontLinuxQuantity",
(SELECT ROUND(MIN("reserved3yPartialUpfrontLinuxHr"), 4)       FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yPartialUpfrontLinuxHr" > "0.000001") AS "minReserved3yPartialUpfrontLinuxHr",
(
	SELECT ROUND((MIN("reserved3yPartialUpfrontLinuxQuantity")/36) + (MIN("reserved3yPartialUpfrontLinuxHr")*730), 2)
	FROM "instance-shared-prices"
	WHERE "instanceType" = I."instanceType"
	AND "reserved3yPartialUpfrontLinuxQuantity" > "0.000001"
	AND "reserved3yPartialUpfrontLinuxHr" > "0.000001"
) AS "minReserved3yPartialUpfrontLinuxMonth",
(SELECT ROUND(AVG("reserved3yPartialUpfrontLinuxQuantity"), 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yPartialUpfrontLinuxQuantity" > "0.000001") AS "avgReserved3yPartialUpfrontLinuxQuantity",
(SELECT ROUND(AVG("reserved3yPartialUpfrontLinuxHr"), 4)       FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yPartialUpfrontLinuxHr" > "0.000001") AS "avgReserved3yPartialUpfrontLinuxHr",
(
	SELECT ROUND((AVG("reserved3yPartialUpfrontLinuxQuantity")/36) + (AVG("reserved3yPartialUpfrontLinuxHr")*730), 2)
	FROM "instance-shared-prices"
	WHERE "instanceType" = I."instanceType"
	AND "reserved3yPartialUpfrontLinuxQuantity" > "0.000001"
	AND "reserved3yPartialUpfrontLinuxHr" > "0.000001"
) AS "avgReserved3yPartialUpfrontLinuxMonth",
ROUND(MAX(P."reserved3yPartialUpfrontLinuxQuantity"), 2) AS "maxReserved3yPartialUpfrontLinuxQuantity",
ROUND(MAX(P."reserved3yPartialUpfrontLinuxHr"), 4)       AS "maxReserved3yPartialUpfrontLinuxHr",
ROUND((MAX("reserved3yPartialUpfrontLinuxQuantity")/36) + (MAX("reserved3yPartialUpfrontLinuxHr")*730), 2) AS "maxReserved3yPartialUpfrontLinuxMonth",
/* Reserved 1Y all upfront */
(SELECT ROUND(MIN("reserved1yAllUpfrontLinuxQuantity"), 2)    FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yAllUpfrontLinuxQuantity" > "0.000001") AS "minReserved1yAllUpfrontLinuxQuantity",
(SELECT ROUND(MIN("reserved1yAllUpfrontLinuxQuantity")/12, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yAllUpfrontLinuxQuantity" > "0.000001") AS "minReserved1yAllUpfrontLinuxMonth",
(SELECT ROUND(AVG("reserved1yAllUpfrontLinuxQuantity"), 2)    FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yAllUpfrontLinuxQuantity" > "0.000001") AS "avgReserved1yAllUpfrontLinuxQuantity",
(SELECT ROUND(AVG("reserved1yAllUpfrontLinuxQuantity")/12, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved1yAllUpfrontLinuxQuantity" > "0.000001") AS "avgReserved1yAllUpfrontLinuxMonth",
ROUND(MAX(P."reserved1yAllUpfrontLinuxQuantity"), 2)    AS "maxReserved1yAllUpfrontLinuxQuantity",
ROUND(MAX(P."reserved1yAllUpfrontLinuxQuantity")/12, 2) AS "maxReserved1yAllUpfrontLinuxMonth",
/* Reserved 3Y all upfront */
(SELECT ROUND(MIN("reserved3yAllUpfrontLinuxQuantity"), 2)    FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yAllUpfrontLinuxQuantity" > "0.000001") AS "minReserved3yAllUpfrontLinuxQuantity",
(SELECT ROUND(MIN("reserved3yAllUpfrontLinuxQuantity")/36, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yAllUpfrontLinuxQuantity" > "0.000001") AS "minReserved3yAllUpfrontLinuxMonth",
(SELECT ROUND(AVG("reserved3yAllUpfrontLinuxQuantity"), 2)    FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yAllUpfrontLinuxQuantity" > "0.000001") AS "avgReserved3yAllUpfrontLinuxQuantity",
(SELECT ROUND(AVG("reserved3yAllUpfrontLinuxQuantity")/36, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "reserved3yAllUpfrontLinuxQuantity" > "0.000001") AS "avgReserved3yAllUpfrontLinuxMonth",
ROUND(MAX(P."reserved3yAllUpfrontLinuxQuantity"), 2)    AS "maxReserved3yAllUpfrontLinuxQuantity",
ROUND(MAX(P."reserved3yAllUpfrontLinuxQuantity")/36, 2) AS "maxReserved3yAllUpfrontLinuxMonth",
/* Convertible Reserved 1Y no upfront */
(SELECT ROUND(MIN("convertible1yNoUpfrontLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yNoUpfrontLinuxHr" > "0.000001") AS "minConvertible1yNoUpfrontLinuxHr",
(SELECT ROUND(MIN("convertible1yNoUpfrontLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yNoUpfrontLinuxHr" > "0.000001") AS "minConvertible1yNoUpfrontLinuxMonth",
(SELECT ROUND(AVG("convertible1yNoUpfrontLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yNoUpfrontLinuxHr" > "0.000001") AS "avgConvertible1yNoUpfrontLinuxHr",
(SELECT ROUND(AVG("convertible1yNoUpfrontLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yNoUpfrontLinuxHr" > "0.000001") AS "avgConvertible1yNoUpfrontLinuxMonth",
ROUND(MAX(P."convertible1yNoUpfrontLinuxHr"), 4)     AS "maxConvertible1yNoUpfrontLinuxHr",
ROUND(MAX(P."convertible1yNoUpfrontLinuxHr")*730, 2) AS "maxConvertible1yNoUpfrontLinuxMonth",
/* Convertible Reserved 3Y no upfront */
(SELECT ROUND(MIN("convertible3yNoUpfrontLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yNoUpfrontLinuxHr" > "0.000001") AS "minConvertible3yNoUpfrontLinuxHr",
(SELECT ROUND(MIN("convertible3yNoUpfrontLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yNoUpfrontLinuxHr" > "0.000001") AS "minConvertible3yNoUpfrontLinuxMonth",
(SELECT ROUND(AVG("convertible3yNoUpfrontLinuxHr"), 4)     FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yNoUpfrontLinuxHr" > "0.000001") AS "avgConvertible3yNoUpfrontLinuxHr",
(SELECT ROUND(AVG("convertible3yNoUpfrontLinuxHr")*730, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yNoUpfrontLinuxHr" > "0.000001") AS "avgConvertible3yNoUpfrontLinuxMonth",
ROUND(MAX(P."convertible3yNoUpfrontLinuxHr"), 4)     AS "maxConvertible3yNoUpfrontLinuxHr",
ROUND(MAX(P."convertible3yNoUpfrontLinuxHr")*730, 2) AS "maxConvertible3yNoUpfrontLinuxMonth",
/* Convertible Reserved 1Y partial upfront */
(SELECT ROUND(MIN("convertible1yPartialUpfrontLinuxQuantity"), 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yPartialUpfrontLinuxQuantity" > "0.000001") AS "minConvertible1yPartialUpfrontLinuxQuantity",
(SELECT ROUND(MIN("convertible1yPartialUpfrontLinuxHr"), 4)       FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yPartialUpfrontLinuxHr" > "0.000001") AS "minConvertible1yPartialUpfrontLinuxHr",
(
	SELECT ROUND((MIN("convertible1yPartialUpfrontLinuxQuantity")/12) + (MIN("convertible1yPartialUpfrontLinuxHr")*730), 2)
	FROM "instance-shared-prices"
	WHERE "instanceType" = I."instanceType"
	AND "convertible1yPartialUpfrontLinuxQuantity" > "0.000001"
	AND "convertible1yPartialUpfrontLinuxHr" > "0.000001"
) AS "minConvertible1yPartialUpfrontLinuxMonth",
(SELECT ROUND(AVG("convertible1yPartialUpfrontLinuxQuantity"), 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yPartialUpfrontLinuxQuantity" > "0.000001") AS "avgConvertible1yPartialUpfrontLinuxQuantity",
(SELECT ROUND(AVG("convertible1yPartialUpfrontLinuxHr"), 4)       FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yPartialUpfrontLinuxHr" > "0.000001") AS "avgConvertible1yPartialUpfrontLinuxHr",
(
	SELECT ROUND((AVG("convertible1yPartialUpfrontLinuxQuantity")/12) + (AVG("convertible1yPartialUpfrontLinuxHr")*730), 2)
	FROM "instance-shared-prices"
	WHERE "instanceType" = I."instanceType"
	AND "convertible1yPartialUpfrontLinuxQuantity" > "0.000001"
	AND "convertible1yPartialUpfrontLinuxHr" > "0.000001"
) AS "avgConvertible1yPartialUpfrontLinuxMonth",
ROUND(MAX(P."convertible1yPartialUpfrontLinuxQuantity"), 2) AS "maxConvertible1yPartialUpfrontLinuxQuantity",
ROUND(MAX(P."convertible1yPartialUpfrontLinuxHr"), 4)       AS "maxConvertible1yPartialUpfrontLinuxHr",
ROUND((MAX("convertible1yPartialUpfrontLinuxQuantity")/12) + (MAX("convertible1yPartialUpfrontLinuxHr")*730), 2) AS "maxConvertible1yPartialUpfrontLinuxMonth",
/* Convertible Reserved 3Y partial upfront */
(SELECT ROUND(MIN("convertible3yPartialUpfrontLinuxQuantity"), 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yPartialUpfrontLinuxQuantity" > "0.000001") AS "minConvertible3yPartialUpfrontLinuxQuantity",
(SELECT ROUND(MIN("convertible3yPartialUpfrontLinuxHr"), 4)       FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yPartialUpfrontLinuxHr" > "0.000001") AS "minConvertible3yPartialUpfrontLinuxHr",
(
	SELECT ROUND((MIN("convertible3yPartialUpfrontLinuxQuantity")/36) + (MIN("convertible3yPartialUpfrontLinuxHr")*730), 2)
	FROM "instance-shared-prices"
	WHERE "instanceType" = I."instanceType"
	AND "convertible3yPartialUpfrontLinuxQuantity" > "0.000001"
	AND "convertible3yPartialUpfrontLinuxHr" > "0.000001"
) AS "minConvertible3yPartialUpfrontLinuxMonth",
(SELECT ROUND(AVG("convertible3yPartialUpfrontLinuxQuantity"), 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yPartialUpfrontLinuxQuantity" > "0.000001") AS "avgConvertible3yPartialUpfrontLinuxQuantity",
(SELECT ROUND(AVG("convertible3yPartialUpfrontLinuxHr"), 4)       FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yPartialUpfrontLinuxHr" > "0.000001") AS "avgConvertible3yPartialUpfrontLinuxHr",
(
	SELECT ROUND((AVG("convertible3yPartialUpfrontLinuxQuantity")/36) + (AVG("convertible3yPartialUpfrontLinuxHr")*730), 2)
	FROM "instance-shared-prices"
	WHERE "instanceType" = I."instanceType"
	AND "convertible3yPartialUpfrontLinuxQuantity" > "0.000001"
	AND "convertible3yPartialUpfrontLinuxHr" > "0.000001"
) AS "avgConvertible3yPartialUpfrontLinuxMonth",
ROUND(MAX(P."convertible3yPartialUpfrontLinuxQuantity"), 2) AS "maxConvertible3yPartialUpfrontLinuxQuantity",
ROUND(MAX(P."convertible3yPartialUpfrontLinuxHr"), 4)       AS "maxConvertible3yPartialUpfrontLinuxHr",
ROUND((MAX("convertible3yPartialUpfrontLinuxQuantity")/36) + (MAX("convertible3yPartialUpfrontLinuxHr")*730), 2) AS "maxConvertible3yPartialUpfrontLinuxMonth",
/* Convertible Reserved 1Y all upfront */
(SELECT ROUND(MIN("convertible1yAllUpfrontLinuxQuantity"), 2)    FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yAllUpfrontLinuxQuantity" > "0.000001") AS "minConvertible1yAllUpfrontLinuxQuantity",
(SELECT ROUND(MIN("convertible1yAllUpfrontLinuxQuantity")/12, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yAllUpfrontLinuxQuantity" > "0.000001") AS "minConvertible1yAllUpfrontLinuxMonth",
(SELECT ROUND(AVG("convertible1yAllUpfrontLinuxQuantity"), 2)    FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yAllUpfrontLinuxQuantity" > "0.000001") AS "avgConvertible1yAllUpfrontLinuxQuantity",
(SELECT ROUND(AVG("convertible1yAllUpfrontLinuxQuantity")/12, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible1yAllUpfrontLinuxQuantity" > "0.000001") AS "avgConvertible1yAllUpfrontLinuxMonth",
ROUND(MAX(P."convertible1yAllUpfrontLinuxQuantity"), 2)    AS "maxConvertible1yAllUpfrontLinuxQuantity",
ROUND(MAX(P."convertible1yAllUpfrontLinuxQuantity")/12, 2) AS "maxConvertible1yAllUpfrontLinuxMonth",
/* Convertible Reserved 3Y all upfront */
(SELECT ROUND(MIN("convertible3yAllUpfrontLinuxQuantity"), 2)    FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yAllUpfrontLinuxQuantity" > "0.000001") AS "minConvertible3yAllUpfrontLinuxQuantity",
(SELECT ROUND(MIN("convertible3yAllUpfrontLinuxQuantity")/36, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yAllUpfrontLinuxQuantity" > "0.000001") AS "minConvertible3yAllUpfrontLinuxMonth",
(SELECT ROUND(AVG("convertible3yAllUpfrontLinuxQuantity"), 2)    FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yAllUpfrontLinuxQuantity" > "0.000001") AS "avgConvertible3yAllUpfrontLinuxQuantity",
(SELECT ROUND(AVG("convertible3yAllUpfrontLinuxQuantity")/36, 2) FROM "instance-shared-prices" WHERE "instanceType" = I."instanceType" AND "convertible3yAllUpfrontLinuxQuantity" > "0.000001") AS "avgConvertible3yAllUpfrontLinuxMonth",
ROUND(MAX(P."convertible3yAllUpfrontLinuxQuantity"), 2)    AS "maxConvertible3yAllUpfrontLinuxQuantity",
ROUND(MAX(P."convertible3yAllUpfrontLinuxQuantity")/36, 2) AS "maxConvertible3yAllUpfrontLinuxMonth"
FROM "instance-shared-prices" P
INNER JOIN "instance-types" I ON P."instanceType" = I."instanceType"
LEFT  JOIN "instance-gpus"  G ON G."instanceType" = I."instanceType"
GROUP BY P."instanceType"
ORDER BY I."vCpus", I."memorySizeInMiB";