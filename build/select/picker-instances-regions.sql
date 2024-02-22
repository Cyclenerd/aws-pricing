/* SQL for Instance Picker JSON export */
SELECT
I."instanceType",
I."instanceFamily",
I."instanceFamilyName",
L."location",
L."locationName",
L."locationType",
L."locationContinent",
I."currentGeneration",
I."supportedUsageClasses",
I."supportedRootDeviceTypes",
I."supportedVirtualizationTypes",
I."bareMetal",
I."hypervisor",
I."processorArchitectures",
ROUND(I."processorClockSpeedInGhz", 1) AS "processorClockSpeedInGhz",
I."processorManufacturer",
I."processor",
I."processorFeatures",
ROUND(I."vCpus", 0) AS "vCpus",
ROUND(I."vCpuCores", 0) AS "vCpuCores",
ROUND(I."vCpuThreadsPerCore", 0) AS "vCpuThreadsPerCore",
ROUND(I."memorySizeInMiB", 0) AS "memorySizeInMiB",
ROUND(I."memorySizeInMiB"/1024, 2) AS "memorySizeInGiB",
I."storage",
I."storageSupported",
ROUND(I."storageTotalSizeInGB", 0) AS "storageTotalSizeInGB",
I."storageNvmeSupport",
I."storageEncryptionSupport",
I."ebsOptimizedSupport",
I."ebsEncryptionSupport",
ROUND(I."ebsOptimizedBaselineBandwidthInMbps", 0) AS "ebsOptimizedBaselineBandwidthInMbps",
ROUND(I."ebsOptimizedBaselineThroughputInMBps", 0) AS "ebsOptimizedBaselineThroughputInMBps",
ROUND(I."ebsOptimizedBaselineIops", 0) AS "ebsOptimizedBaselineIops",
ROUND(I."ebsOptimizedMaxBandwidthInMbps", 0) AS "ebsOptimizedMaxBandwidthInMbps",
ROUND(I."ebsOptimizedMaxThroughputInMBps", 0) AS "ebsOptimizedMaxThroughputInMBps",
ROUND(I."ebsOptimizedMaxIops", 0) AS "ebsOptimizedMaxIops",
I."ebsNvmeSupport",
I."networkPerformance",
ROUND(I."maxNetworkInterfaces", 0) AS "maxNetworkInterfaces",
ROUND(I."maxNetworkCards", 0) AS "maxNetworkCards",
ROUND(I."ipv4AddrPerInterface", 0) AS "ipv4AddrPerInterface",
ROUND(I."ipv6AddrPerInterface", 0) AS "ipv6AddrPerInterface",
I."ipv6Supported",
I."enaSupport",
I."efaSupported",
I."encryptionInTransitSupported",
I."enaSrdSupported",
ROUND(I."gpuTotalGpuMemoryInMiB", 0) AS "gpuTotalGpuMemoryInMiB",
ROUND(I."gpuTotalGpuMemoryInMiB"/1024, 2) AS "gpuTotalGpuMemoryInGiB",
IFNULL(ROUND(G."count", 0), 0) AS "gpuCount",
G."manufacturer" AS "gpuManufacturer",
G."name" AS "gpuName",
ROUND(G."memorySizeInMiB", 0) AS "gpuMemorySizeInMiB",
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
ROUND(I."sapSaps", 0) AS "sapSaps",
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
ROUND(P."spotLinuxHr", 4)     AS "spotLinuxHr",
ROUND(P."spotLinuxHr"*730, 2) AS "spotLinuxMonth",
/* Reserved 1Y no upfront */
ROUND(P."reserved1yNoUpfrontLinuxHr"*730, 2) AS "reserved1yNoUpfrontLinuxMonth",
/* Reserved 1Y partial upfront */
ROUND((P."reserved1yPartialUpfrontLinuxQuantity"/12) + (P."reserved1yPartialUpfrontLinuxHr"*730), 2) AS "reserved1yPartialUpfrontLinuxMonth",
/* Reserved 1Y all upfront */
ROUND(P."reserved1yAllUpfrontLinuxQuantity"/12, 2) AS "reserved1yAllUpfrontLinuxMonth",
/* Reserved 3Y no upfront */
ROUND(P."reserved3yNoUpfrontLinuxHr"*730, 2) AS "reserved3yNoUpfrontLinuxMonth",
/* Reserved 3Y all upfront */
ROUND(P."reserved3yAllUpfrontLinuxQuantity"/36, 2) AS "reserved3yAllUpfrontLinuxMonth",
/* Reserved 3Y partial upfront */
ROUND((P."reserved3yPartialUpfrontLinuxQuantity"/36) + (P."reserved3yPartialUpfrontLinuxHr"*730), 2) AS "reserved3yPartialUpfrontLinuxMonth",
/* Convertible reserved 1Y no upfront */
ROUND(P."convertible1yNoUpfrontLinuxHr"*730, 2) AS "convertible1yNoUpfrontLinuxMonth",
/* Convertible reserved 1Y partial upfront */
ROUND((P."convertible1yPartialUpfrontLinuxQuantity"/12) + (P."convertible1yPartialUpfrontLinuxHr"*730), 2) AS "convertible1yPartialUpfrontLinuxMonth",
/* Convertible reserved 1Y all upfront */
ROUND(P."convertible1yAllUpfrontLinuxQuantity"/12, 2) AS "convertible1yAllUpfrontLinuxMonth",
/* Convertible reserved 3Y no upfront */
ROUND(P."convertible3yNoUpfrontLinuxHr"*730, 2) AS "convertible3yNoUpfrontLinuxMonth",
/* Convertible reserved 3Y partial upfront */
ROUND((P."convertible3yPartialUpfrontLinuxQuantity"/36) + (P."convertible3yPartialUpfrontLinuxHr"*730), 2) AS "convertible3yPartialUpfrontLinuxMonth",
/* Convertible reserved 3Y all upfront */
ROUND(P."convertible3yAllUpfrontLinuxQuantity"/36, 2) AS "convertible3yAllUpfrontLinuxMonth"
FROM "instance-shared-prices" P
INNER JOIN "instance-types" I ON P."instanceType" = I."instanceType"
INNER JOIN "locations" L      ON P."location"     = L."location"
LEFT  JOIN "instance-gpus" G  ON G."instanceType" = I."instanceType"
GROUP BY P."instanceType", P."location"
ORDER BY I."vCpus", I."memorySizeInMiB";