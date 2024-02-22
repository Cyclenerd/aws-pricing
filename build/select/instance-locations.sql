SELECT
I."instanceType",
I."instanceFamily",
I."instanceFamilyName",
L."location",
L."locationName",
L."locationType",
L."locationContinent",
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
G."count" AS "gpuCount",
G."manufacturer" AS "gpuManufacturer",
G."name" AS "gpuName",
G."memorySizeInMiB" AS "gpuMemorySizeInMiB",
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
	SELECT ROUND("onDemandLinuxHr", 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "onDemandLinuxHr" > "0.000001"
) AS "onDemandLinuxHostHr",
(
	SELECT ROUND("onDemandLinuxHr"*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "onDemandLinuxHr" > "0.000001"
) AS "onDemandLinuxHostMonth",
/* Host - Reserved 1Y no upfront */
(
	SELECT ROUND("reserved1yNoUpfrontLinuxHr", 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "reserved1yNoUpfrontLinuxHr" > "0.000001"
) AS "reserved1yNoUpfrontLinuxHostHr",
(
	SELECT ROUND("reserved1yNoUpfrontLinuxHr"*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "reserved1yNoUpfrontLinuxHr" > "0.000001"
) AS "reserved1yNoUpfrontLinuxHostMonth",
/* Host - Reserved 3Y no upfront*/
(
	SELECT ROUND("reserved3yNoUpfrontLinuxHr", 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "reserved3yNoUpfrontLinuxHr" > "0.000001"
) AS "reserved3yNoUpfrontLinuxHostHr",
(
	SELECT ROUND("reserved3yNoUpfrontLinuxHr"*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "reserved3yNoUpfrontLinuxHr" > "0.000001"
) AS "reserved3yNoUpfrontLinuxHostMonth",
/* Host - Reserved 1Y all upfront */
(
	SELECT ROUND("reserved1yAllUpfrontLinuxHr", 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "reserved1yAllUpfrontLinuxHr" > "0.000001"
) AS "reserved1yAllUpfrontLinuxHostHr",
(
	SELECT ROUND("reserved1yAllUpfrontLinuxHr"*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "reserved1yAllUpfrontLinuxHr" > "0.000001"
) AS "reserved1yAllUpfrontLinuxHostMonth",
/* Host - Reserved 3Y all upfront */
(
	SELECT ROUND("reserved3yAllUpfrontLinuxHr", 4)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "reserved3yAllUpfrontLinuxHr" > "0.000001"
) AS "reserved3yAllUpfrontLinuxHostHr",
(
	SELECT ROUND("reserved3yAllUpfrontLinuxHr"*730, 2)
	FROM "instance-host-prices"
	WHERE "instanceFamily" = I."instanceFamily"
	AND "location" = P."location"
	AND "reserved3yAllUpfrontLinuxHr" > "0.000001"
) AS "reserved3yAllUpfrontLinuxHostMonth",
/* On demand */
ROUND(P."onDemandLinuxHr", 4)       AS "onDemandLinuxHr",
ROUND(P."onDemandLinuxHr"*730, 2)   AS "onDemandLinuxMonth",
ROUND(P."onDemandSuseHr", 4)        AS "onDemandSuseHr",
ROUND(P."onDemandSuseHr"*730, 2)    AS "onDemandSuseMonth",
ROUND(P."onDemandRhelHr", 4)        AS "onDemandRhelHr",
ROUND(P."onDemandRhelHr"*730, 2)    AS "onDemandRhelMonth",
ROUND(P."onDemandWindowsHr", 4)     AS "onDemandWindowsHr",
ROUND(P."onDemandWindowsHr"*730, 2) AS "onDemandWindowsMonth",
/* Spot */
ROUND(P."spotLinuxHr", 4)       AS "spotLinuxHr",
ROUND(P."spotLinuxHr"*730, 2)   AS "spotLinuxMonth",
ROUND(P."spotWindowsHr", 4)     AS "spotWindowsHr",
ROUND(P."spotWindowsHr"*730, 2) AS "spotWindowsMonth",
/* Reserved 1Y no upfront */
ROUND(P."reserved1yNoUpfrontLinuxHr", 4)       AS "reserved1yNoUpfrontLinuxHr",
ROUND(P."reserved1yNoUpfrontLinuxHr"*730, 2)   AS "reserved1yNoUpfrontLinuxMonth",
ROUND(P."reserved1yNoUpfrontSuseHr", 4)        AS "reserved1yNoUpfrontSuseHr",
ROUND(P."reserved1yNoUpfrontSuseHr"*730, 2)    AS "reserved1yNoUpfrontSuseMonth",
ROUND(P."reserved1yNoUpfrontRhelHr", 4)        AS "reserved1yNoUpfrontRhelHr",
ROUND(P."reserved1yNoUpfrontRhelHr"*730, 2)    AS "reserved1yNoUpfrontRhelMonth",
ROUND(P."reserved1yNoUpfrontWindowsHr", 4)     AS "reserved1yNoUpfrontWindowsHr",
ROUND(P."reserved1yNoUpfrontWindowsHr"*730, 2) AS "reserved1yNoUpfrontWindowsMonth",
/* Reserved 3Y no upfront */
ROUND(P."reserved3yNoUpfrontLinuxHr", 4)       AS "reserved3yNoUpfrontLinuxHr",
ROUND(P."reserved3yNoUpfrontLinuxHr"*730, 2)   AS "reserved3yNoUpfrontLinuxMonth",
ROUND(P."reserved3yNoUpfrontSuseHr", 4)        AS "reserved3yNoUpfrontSuseHr",
ROUND(P."reserved3yNoUpfrontSuseHr"*730, 2)    AS "reserved3yNoUpfrontSuseMonth",
ROUND(P."reserved3yNoUpfrontRhelHr", 4)        AS "reserved3yNoUpfrontRhelHr",
ROUND(P."reserved3yNoUpfrontRhelHr"*730, 2)    AS "reserved3yNoUpfrontRhelMonth",
ROUND(P."reserved3yNoUpfrontWindowsHr", 4)     AS "reserved3yNoUpfrontWindowsHr",
ROUND(P."reserved3yNoUpfrontWindowsHr"*730, 2) AS "reserved3yNoUpfrontWindowsMonth",
/* Convertible reserved 1Y no upfront */
ROUND(P."convertible1yNoUpfrontLinuxHr", 4)        AS "convertible1yNoUpfrontLinuxHr",
ROUND(P."convertible1yNoUpfrontLinuxHr"*730, 2)   AS "convertible1yNoUpfrontLinuxMonth",
ROUND(P."convertible1yNoUpfrontSuseHr", 4)         AS "convertible1yNoUpfrontSuseHr",
ROUND(P."convertible1yNoUpfrontSuseHr"*730, 2)    AS "convertible1yNoUpfrontSuseMonth",
ROUND(P."convertible1yNoUpfrontRhelHr", 4)         AS "convertible1yNoUpfrontRhelHr",
ROUND(P."convertible1yNoUpfrontRhelHr"*730, 2)    AS "convertible1yNoUpfrontRhelMonth",
ROUND(P."convertible1yNoUpfrontWindowsHr", 4)      AS "convertible1yNoUpfrontWindowsHr",
ROUND(P."convertible1yNoUpfrontWindowsHr"*730, 2) AS "convertible1yNoUpfrontWindowsMonth",
/* Convertible reserved 3Y no upfront */
ROUND(P."convertible3yNoUpfrontLinuxHr", 4)       AS "convertible3yNoUpfrontLinuxHr",
ROUND(P."convertible3yNoUpfrontLinuxHr"*730, 2)   AS "convertible3yNoUpfrontLinuxMonth",
ROUND(P."convertible3yNoUpfrontSuseHr", 4)        AS "convertible3yNoUpfrontSuseHr",
ROUND(P."convertible3yNoUpfrontSuseHr"*730, 2)    AS "convertible3yNoUpfrontSuseMonth",
ROUND(P."convertible3yNoUpfrontRhelHr", 4)        AS "convertible3yNoUpfrontRhelHr",
ROUND(P."convertible3yNoUpfrontRhelHr"*730, 2)    AS "convertible3yNoUpfrontRhelMonth",
ROUND(P."convertible3yNoUpfrontWindowsHr", 4)     AS "convertible3yNoUpfrontWindowsHr",
ROUND(P."convertible3yNoUpfrontWindowsHr"*730, 2) AS "convertible3yNoUpfrontWindowsMonth",
/* Reserved 1Y partial upfront */
ROUND(P."reserved1yPartialUpfrontLinuxQuantity", 2)   AS "reserved1yPartialUpfrontLinuxQuantity",
ROUND(P."reserved1yPartialUpfrontLinuxHr", 4)         AS "reserved1yPartialUpfrontLinuxHr",
ROUND(P."reserved1yPartialUpfrontSuseQuantity", 2)    AS "reserved1yPartialUpfrontSuseQuantity",
ROUND(P."reserved1yPartialUpfrontSuseHr", 4)          AS "reserved1yPartialUpfrontSuseHr",
ROUND(P."reserved1yPartialUpfrontRhelQuantity", 2)    AS "reserved1yPartialUpfrontRhelQuantity",
ROUND(P."reserved1yPartialUpfrontRhelHr", 4)          AS "reserved1yPartialUpfrontRhelHr",
ROUND(P."reserved1yPartialUpfrontWindowsQuantity", 2) AS "reserved1yPartialUpfrontWindowsQuantity",
ROUND(P."reserved1yPartialUpfrontWindowsHr", 4)       AS "reserved1yPartialUpfrontWindowsHr",
ROUND((P."reserved1yPartialUpfrontLinuxQuantity"/12)   + (P."reserved1yPartialUpfrontLinuxHr"*730), 2)   AS "reserved1yPartialUpfrontLinuxMonth",
ROUND((P."reserved1yPartialUpfrontSuseQuantity"/12)    + (P."reserved1yPartialUpfrontSuseHr"*730), 2)    AS "reserved1yPartialUpfrontSuseMonth",
ROUND((P."reserved1yPartialUpfrontRhelQuantity"/12)    + (P."reserved1yPartialUpfrontRhelHr"*730), 2)    AS "reserved1yPartialUpfrontRhelMonth",
ROUND((P."reserved1yPartialUpfrontWindowsQuantity"/12) + (P."reserved1yPartialUpfrontWindowsHr"*730), 2) AS "reserved1yPartialUpfrontWindowsMonth",
/* Reserved 3Y partial upfront */
ROUND(P."reserved3yPartialUpfrontLinuxQuantity", 2)   AS "reserved3yPartialUpfrontLinuxQuantity",
ROUND(P."reserved3yPartialUpfrontLinuxHr", 4)         AS "reserved3yPartialUpfrontLinuxHr",
ROUND(P."reserved3yPartialUpfrontSuseQuantity", 2)    AS "reserved3yPartialUpfrontSuseQuantity",
ROUND(P."reserved3yPartialUpfrontSuseHr", 4)          AS "reserved3yPartialUpfrontSuseHr",
ROUND(P."reserved3yPartialUpfrontRhelQuantity", 2)    AS "reserved3yPartialUpfrontRhelQuantity",
ROUND(P."reserved3yPartialUpfrontRhelHr", 4)          AS "reserved3yPartialUpfrontRhelHr",
ROUND(P."reserved3yPartialUpfrontWindowsQuantity", 2) AS "reserved3yPartialUpfrontWindowsQuantity",
ROUND(P."reserved3yPartialUpfrontWindowsHr", 4)       AS "reserved3yPartialUpfrontWindowsHr",
ROUND((P."reserved3yPartialUpfrontLinuxQuantity"/36)   + (P."reserved3yPartialUpfrontLinuxHr"*730), 2)   AS "reserved3yPartialUpfrontLinuxMonth",
ROUND((P."reserved3yPartialUpfrontSuseQuantity"/36)    + (P."reserved3yPartialUpfrontSuseHr"*730), 2)    AS "reserved3yPartialUpfrontSuseMonth",
ROUND((P."reserved3yPartialUpfrontRhelQuantity"/36)    + (P."reserved3yPartialUpfrontRhelHr"*730), 2)    AS "reserved3yPartialUpfrontRhelMonth",
ROUND((P."reserved3yPartialUpfrontWindowsQuantity"/36) + (P."reserved3yPartialUpfrontWindowsHr"*730), 2) AS "reserved3yPartialUpfrontWindowsMonth",
/* Convertible reserved 1Y partial upfront */
ROUND(P."convertible1yPartialUpfrontLinuxQuantity", 2)   AS "convertible1yPartialUpfrontLinuxQuantity",
ROUND(P."convertible1yPartialUpfrontLinuxHr", 4)         AS "convertible1yPartialUpfrontLinuxHr",
ROUND(P."convertible1yPartialUpfrontSuseQuantity", 2)    AS "convertible1yPartialUpfrontSuseQuantity",
ROUND(P."convertible1yPartialUpfrontSuseHr", 4)          AS "convertible1yPartialUpfrontSuseHr",
ROUND(P."convertible1yPartialUpfrontRhelQuantity", 2)    AS "convertible1yPartialUpfrontRhelQuantity",
ROUND(P."convertible1yPartialUpfrontRhelHr", 4)          AS "convertible1yPartialUpfrontRhelHr",
ROUND(P."convertible1yPartialUpfrontWindowsQuantity", 2) AS "convertible1yPartialUpfrontWindowsQuantity",
ROUND(P."convertible1yPartialUpfrontWindowsHr", 4)       AS "convertible1yPartialUpfrontWindowsHr",
ROUND((P."convertible1yPartialUpfrontLinuxQuantity"/12)   + (P."convertible1yPartialUpfrontLinuxHr"*730), 2)   AS "convertible1yPartialUpfrontLinuxMonth",
ROUND((P."convertible1yPartialUpfrontSuseQuantity"/12)    + (P."convertible1yPartialUpfrontSuseHr"*730), 2)    AS "convertible1yPartialUpfrontSuseMonth",
ROUND((P."convertible1yPartialUpfrontRhelQuantity"/12)    + (P."convertible1yPartialUpfrontRhelHr"*730), 2)    AS "convertible1yPartialUpfrontRhelMonth",
ROUND((P."convertible1yPartialUpfrontWindowsQuantity"/12) + (P."convertible1yPartialUpfrontWindowsHr"*730), 2) AS "convertible1yPartialUpfrontWindowsMonth",
/* Convertible reserved 3Y partial upfront */
ROUND(P."convertible3yPartialUpfrontLinuxQuantity", 2)   AS "convertible3yPartialUpfrontLinuxQuantity",
ROUND(P."convertible3yPartialUpfrontLinuxHr", 4)         AS "convertible3yPartialUpfrontLinuxHr",
ROUND(P."convertible3yPartialUpfrontSuseQuantity", 2)    AS "convertible3yPartialUpfrontSuseQuantity",
ROUND(P."convertible3yPartialUpfrontSuseHr", 4)          AS "convertible3yPartialUpfrontSuseHr",
ROUND(P."convertible3yPartialUpfrontRhelQuantity", 2)    AS "convertible3yPartialUpfrontRhelQuantity",
ROUND(P."convertible3yPartialUpfrontRhelHr", 4)          AS "convertible3yPartialUpfrontRhelHr",
ROUND(P."convertible3yPartialUpfrontWindowsQuantity", 2) AS "convertible3yPartialUpfrontWindowsQuantity",
ROUND(P."convertible3yPartialUpfrontWindowsHr", 4)       AS "convertible3yPartialUpfrontWindowsHr",
ROUND((P."convertible3yPartialUpfrontLinuxQuantity"/36)   + (P."convertible3yPartialUpfrontLinuxHr"*730), 2)   AS "convertible3yPartialUpfrontLinuxMonth",
ROUND((P."convertible3yPartialUpfrontSuseQuantity"/36)    + (P."convertible3yPartialUpfrontSuseHr"*730), 2)    AS "convertible3yPartialUpfrontSuseMonth",
ROUND((P."convertible3yPartialUpfrontRhelQuantity"/36)    + (P."convertible3yPartialUpfrontRhelHr"*730), 2)    AS "convertible3yPartialUpfrontRhelMonth",
ROUND((P."convertible3yPartialUpfrontWindowsQuantity"/36) + (P."convertible3yPartialUpfrontWindowsHr"*730), 2) AS "convertible3yPartialUpfrontWindowsMonth",
/* Reserved 1Y all upfront */
ROUND(P."reserved1yAllUpfrontLinuxQuantity", 2)      AS "reserved1yAllUpfrontLinuxQuantity",
ROUND(P."reserved1yAllUpfrontLinuxQuantity"/12, 2)   AS "reserved1yAllUpfrontLinuxMonth",
ROUND(P."reserved1yAllUpfrontSuseQuantity", 2)       AS "reserved1yAllUpfrontSuseQuantity",
ROUND(P."reserved1yAllUpfrontSuseQuantity"/12, 2)    AS "reserved1yAllUpfrontSuseMonth",
ROUND(P."reserved1yAllUpfrontRhelQuantity", 2)       AS "reserved1yAllUpfrontRhelQuantity",
ROUND(P."reserved1yAllUpfrontRhelQuantity"/12, 2)    AS "reserved1yAllUpfrontRhelMonth",
ROUND(P."reserved1yAllUpfrontWindowsQuantity", 2)    AS "reserved1yAllUpfrontWindowsQuantity",
ROUND(P."reserved1yAllUpfrontWindowsQuantity"/12, 2) AS "reserved1yAllUpfrontWindowsMonth",
/* Reserved 3Y all upfront */
ROUND(P."reserved3yAllUpfrontLinuxQuantity", 2)      AS "reserved3yAllUpfrontLinuxQuantity",
ROUND(P."reserved3yAllUpfrontLinuxQuantity"/36, 2)   AS "reserved3yAllUpfrontLinuxMonth",
ROUND(P."reserved3yAllUpfrontSuseQuantity", 2)       AS "reserved3yAllUpfrontSuseQuantity",
ROUND(P."reserved3yAllUpfrontSuseQuantity"/36, 2)    AS "reserved3yAllUpfrontSuseMonth",
ROUND(P."reserved3yAllUpfrontRhelQuantity", 2)       AS "reserved3yAllUpfrontRhelQuantity",
ROUND(P."reserved3yAllUpfrontRhelQuantity"/36, 2)    AS "reserved3yAllUpfrontRhelMonth",
ROUND(P."reserved3yAllUpfrontWindowsQuantity", 2)    AS "reserved3yAllUpfrontWindowsQuantity",
ROUND(P."reserved3yAllUpfrontWindowsQuantity"/36, 2) AS "reserved3yAllUpfrontWindowsMonth",
/* Convertible reserved 1Y all upfront */
ROUND(P."convertible1yAllUpfrontLinuxQuantity", 2)      AS "convertible1yAllUpfrontLinuxQuantity",
ROUND(P."convertible1yAllUpfrontLinuxQuantity"/12, 2)   AS "convertible1yAllUpfrontLinuxMonth",
ROUND(P."convertible1yAllUpfrontSuseQuantity", 2)       AS "convertible1yAllUpfrontSuseQuantity",
ROUND(P."convertible1yAllUpfrontSuseQuantity"/12, 2)    AS "convertible1yAllUpfrontSuseMonth",
ROUND(P."convertible1yAllUpfrontRhelQuantity", 2)       AS "convertible1yAllUpfrontRhelQuantity",
ROUND(P."convertible1yAllUpfrontRhelQuantity"/12, 2)    AS "convertible1yAllUpfrontRhelMonth",
ROUND(P."convertible1yAllUpfrontWindowsQuantity", 2)    AS "convertible1yAllUpfrontWindowsQuantity",
ROUND(P."convertible1yAllUpfrontWindowsQuantity"/12, 2) AS "convertible1yAllUpfrontWindowsMonth",
/* Convertible reserved 3Y all upfront */
ROUND(P."convertible3yAllUpfrontLinuxQuantity", 2)      AS "convertible3yAllUpfrontLinuxQuantity",
ROUND(P."convertible3yAllUpfrontLinuxQuantity"/36, 2)   AS "convertible3yAllUpfrontLinuxMonth",
ROUND(P."convertible3yAllUpfrontSuseQuantity", 2)       AS "convertible3yAllUpfrontSuseQuantity",
ROUND(P."convertible3yAllUpfrontSuseQuantity"/36, 2)    AS "convertible3yAllUpfrontSuseMonth",
ROUND(P."convertible3yAllUpfrontRhelQuantity", 2)       AS "convertible3yAllUpfrontRhelQuantity",
ROUND(P."convertible3yAllUpfrontRhelQuantity"/36, 2)    AS "convertible3yAllUpfrontRhelMonth",
ROUND(P."convertible3yAllUpfrontWindowsQuantity", 2)    AS "convertible3yAllUpfrontWindowsQuantity",
ROUND(P."convertible3yAllUpfrontWindowsQuantity"/36, 2) AS "convertible3yAllUpfrontWindowsMonth"
FROM "instance-shared-prices" P
INNER JOIN "instance-types" I ON P."instanceType" = I."instanceType"
INNER JOIN "locations" L      ON P."location"     = L."location"
LEFT  JOIN "instance-gpus" G  ON G."instanceType" = I."instanceType"
WHERE P."instanceType" = "t3.medium"
GROUP BY P."location"
ORDER BY P."onDemandLinuxHr";