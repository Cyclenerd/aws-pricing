/*
 * Create SQLite3 database for AWS EC2 instance type informations
 */

DROP TABLE IF EXISTS "locations";
CREATE TABLE "locations" (
	"location" TEXT NOT NULL DEFAULT "", /* Location/Region Code, i.e.: us-east-1, eu-central-1-ham-1 */
	"locationName" TEXT NOT NULL DEFAULT "", /* Location Name, i.e.: US East (N. Virginia), Germany (Hamburg) */
	"locationType" TEXT NOT NULL DEFAULT "", /* Location Type, i.e.: AWS Region, AWS Local Zone */
	"locationContinent" TEXT NOT NULL DEFAULT "", /* Location Type, i.e.: North America, Europe */
	"publicIpv4Addr" INTEGER NOT NULL DEFAULT "0", /* Public IPv4 addresses */
	PRIMARY KEY("location")
);


DROP TABLE IF EXISTS "instance-types";
CREATE TABLE "instance-types" (
	"instanceType" TEXT NOT NULL DEFAULT "", /* Instance Type, i.e.: t3.medium */
	"instanceFamily" TEXT NOT NULL DEFAULT "", /* Instance Family, i.e.: t3, c7g */
	"instanceFamilyName" TEXT NOT NULL DEFAULT "", /* Instance Family Name [price-list], i.e.: General purpose, Compute optimized */
	"currentGeneration" INTEGER NOT NULL DEFAULT "0", /* 1 = Current generation instance, 0 = Previous generation instances */
	"freeTierEligible" INTEGER NOT NULL DEFAULT "0", /* 1 = AWS Free Tier (https://aws.amazon.com/free/) */
	"supportedUsageClasses" TEXT NOT NULL DEFAULT "", /* on-demand, spot, capacity-block */
	"supportedRootDeviceTypes" TEXT NOT NULL DEFAULT "", /* ebs, instance-store */
	"supportedVirtualizationTypes" TEXT  NOT NULL DEFAULT "", /* hvm, paravirtual */
	"bareMetal" INTEGER NOT NULL DEFAULT "0", /* 1 = Bare metal instance */
	"hypervisor" TEXT NOT NULL DEFAULT "", /* nitro, xen */
	"processorArchitectures" TEXT NOT NULL DEFAULT "", /* CPU Architecture: arm64, arm64_mac, arm64_mac, i386, x86_64, x86_64_mac */
	"processorClockSpeedInGhz" REAL NOT NULL DEFAULT "0.0", /* CPU Clock Speed (GHz) */
	"processorManufacturer" TEXT NOT NULL DEFAULT "", /* CPU Manufacturer: AMD, AWS, Apple, Intel */
	"processor" TEXT NOT NULL DEFAULT "", /* Physical Processor [price-list], i.e. Intel Xeon Platinum 8175 (Skylake) */
	"processorFeatures" TEXT NOT NULL DEFAULT "", /* Physical Features [price-list], i.e: Intel AVX; Intel AVX2; Intel AVX512; Intel Deep Learning Boost; Intel Turbo */
	"vCpus" INTEGER NOT NULL DEFAULT "0", /* vCPUs */
	"vCpuCores" INTEGER NOT NULL DEFAULT "0", /* CPU Cores */
	"vCpuThreadsPerCore" INTEGER NOT NULL DEFAULT "0", /* Threads per Core */
	"memorySizeInMiB" REAL NOT NULL DEFAULT "0.0", /* Memory (MiB) */
	"storage" TEXT NOT NULL DEFAULT "", /* Storage [price-list], i.e.: EBS only, 6 x 3750 NVMe SSD */
	"storageSupported" INTEGER NOT NULL DEFAULT "0",
	"storageTotalSizeInGB" INTEGER NOT NULL DEFAULT "0",
	"storageNvmeSupport" TEXT NOT NULL DEFAULT "", /* required, unsupported */
	"storageEncryptionSupport" TEXT NOT NULL DEFAULT "", /* required, unsupported */
	"ebsOptimizedSupport" TEXT NOT NULL DEFAULT "", /* default, supported, unsupported */
	"ebsEncryptionSupport" TEXT NOT NULL DEFAULT "", /* supported */
	"ebsOptimizedBaselineBandwidthInMbps" INTEGER NOT NULL DEFAULT "0",
	"ebsOptimizedBaselineThroughputInMBps" REAL NOT NULL DEFAULT "0.0",
	"ebsOptimizedBaselineIops" INTEGER NOT NULL DEFAULT "0",
	"ebsOptimizedMaxBandwidthInMbps" INTEGER NOT NULL DEFAULT "0",
	"ebsOptimizedMaxThroughputInMBps" REAL NOT NULL DEFAULT "0.0",
	"ebsOptimizedMaxIops" INTEGER NOT NULL DEFAULT "0",
	"ebsNvmeSupport" TEXT NOT NULL DEFAULT "", /* required, supported, unsupported */
	"networkPerformance" TEXT NOT NULL DEFAULT "", /* I.e. 8x 100 Gigabit, Low to Moderate */
	"maxNetworkInterfaces" INTEGER NOT NULL DEFAULT "0",
	"maxNetworkCards" INTEGER NOT NULL DEFAULT "0",
	"ipv4AddrPerInterface" INTEGER NOT NULL DEFAULT "0",
	"ipv6AddrPerInterface" INTEGER NOT NULL DEFAULT "0",
	"ipv6Supported" INTEGER NOT NULL DEFAULT "0", /* 1 = Yes, 0 = No */
	"enaSupport" TEXT NOT NULL DEFAULT "", /* Elastic Network Adapter (ENA): required, supported, unsupported */
	"efaSupported" INTEGER NOT NULL DEFAULT "0", /* Elastic Fabric Adapter (EFA): 1 = Yes, 0 = No */
	"encryptionInTransitSupported" INTEGER NOT NULL DEFAULT "0", /* 1 = Yes, 0 = No */
	"enaSrdSupported" INTEGER NOT NULL DEFAULT "0", /* ENA Express powered by AWS Scalable Reliable Datagram (SRD): 1 = Yes, 0 = No */
	"gpuTotalGpuMemoryInMiB" INTEGER NOT NULL DEFAULT "0", /* Video Memory (MiB) */
	"placementGroupSupportedStrategies" TEXT NOT NULL DEFAULT "", /* Placement group (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html): cluster, partition, spread */
	"hibernationSupported" INTEGER NOT NULL DEFAULT "0", /* 1 = Yes, 0 = No */
	"burstablePerformanceSupported" INTEGER NOT NULL DEFAULT "0", /* 1 = Yes, 0 = No */
	"dedicatedHostsSupported" INTEGER NOT NULL DEFAULT "0", /* 1 = Yes, 0 = No */
	"autoRecoverySupported" INTEGER NOT NULL DEFAULT "0", /* 1 = Yes, 0 = No */
	"supportedBootModes" TEXT NOT NULL DEFAULT "", /* legacy-bios, uefi */
	"nitroEnclavesSupport" TEXT NOT NULL DEFAULT "", /* supported, unsupported */
	"nitroTpmSupport" TEXT NOT NULL DEFAULT "", /* supported, unsupported */
	"nitroTpmSupportedVersions" TEXT NOT NULL DEFAULT "", /* 2.0 */
	"sapSupported" INTEGER NOT NULL DEFAULT "0", /* 1 = Yes, 0 = No */
	"sapHanaSupported" INTEGER NOT NULL DEFAULT "0", /* 1 = Yes, 0 = No */
	"sapSaps" INTEGER NOT NULL DEFAULT "0", /* SAP Application Performance Standard (SAPS) benchmark score */
	PRIMARY KEY("instanceType")
);

DROP TABLE IF EXISTS "instance-disks";
CREATE TABLE "instance-disks" (
	"instanceType" TEXT NOT NULL DEFAULT "",
	"count" INTEGER NOT NULL DEFAULT "0",
	"sizeInGB" INTEGER NOT NULL DEFAULT "0",
	"type" TEXT NOT NULL DEFAULT "",
	PRIMARY KEY("instanceType")
);

DROP TABLE IF EXISTS "instance-network-cards";
CREATE TABLE "instance-network-cards" (
	"instanceType" TEXT NOT NULL DEFAULT "",
	"networkCardIndex" INTEGER NOT NULL DEFAULT "0",
	"networkPerformance" TEXT NOT NULL DEFAULT "",
	"maximumNetworkInterfaces" INTEGER NOT NULL DEFAULT "0",
	"baselineBandwidthInGbps" REAL NOT NULL DEFAULT "0.0",
	"peakBandwidthInGbps" REAL NOT NULL DEFAULT "0.0",
	PRIMARY KEY("instanceType", "networkCardIndex")
);

DROP TABLE IF EXISTS "instance-gpus";
CREATE TABLE "instance-gpus" (
	"instanceType" TEXT NOT NULL DEFAULT "",
	"name" TEXT NOT NULL DEFAULT "",
	"manufacturer" TEXT NOT NULL DEFAULT "",
	"count" INTEGER NOT NULL DEFAULT "0",
	"memorySizeInMiB" INTEGER NOT NULL DEFAULT "0",
	PRIMARY KEY("instanceType")
);

DROP TABLE IF EXISTS "instance-shared-prices";
CREATE TABLE "instance-shared-prices" (
	"instanceType" TEXT NOT NULL DEFAULT "",
	"location" TEXT NOT NULL DEFAULT "",
	/* On demand */
	"onDemandLinuxHr" REAL DEFAULT "0.0",
	"onDemandSuseHr" REAL DEFAULT "0.0",
	"onDemandRhelHr" REAL DEFAULT "0.0",
	"onDemandUbuntuProHr" REAL DEFAULT "0.0",
	"onDemandWindowsHr" REAL DEFAULT "0.0",
	/* Spot [spot.pl] */
	"spotLinuxHr" REAL DEFAULT "0.0",
	"spotWindowsHr" REAL DEFAULT "0.0",
	/* Reserved 1Y no upfront */
	"reserved1yNoUpfrontLinuxHr" REAL DEFAULT "0.0",
	"reserved1yNoUpfrontSuseHr" REAL DEFAULT "0.0",
	"reserved1yNoUpfrontRhelHr" REAL DEFAULT "0.0",
	"reserved1yNoUpfrontWindowsHr" REAL DEFAULT "0.0",
	/* Reserved 3Y no upfront */
	"reserved3yNoUpfrontLinuxHr" REAL DEFAULT "0.0",
	"reserved3yNoUpfrontSuseHr" REAL DEFAULT "0.0",
	"reserved3yNoUpfrontRhelHr" REAL DEFAULT "0.0",
	"reserved3yNoUpfrontWindowsHr" REAL DEFAULT "0.0",
	/* Convertible reserved 1Y no upfront */
	"convertible1yNoUpfrontLinuxHr" REAL DEFAULT "0.0",
	"convertible1yNoUpfrontSuseHr" REAL DEFAULT "0.0",
	"convertible1yNoUpfrontRhelHr" REAL DEFAULT "0.0",
	"convertible1yNoUpfrontWindowsHr" REAL DEFAULT "0.0",
	/* Convertible reserved 3Y no upfront */
	"convertible3yNoUpfrontLinuxHr" REAL DEFAULT "0.0",
	"convertible3yNoUpfrontSuseHr" REAL DEFAULT "0.0",
	"convertible3yNoUpfrontRhelHr" REAL DEFAULT "0.0",
	"convertible3yNoUpfrontWindowsHr" REAL DEFAULT "0.0",
	/* Reserved 1Y partial upfront */
	"reserved1yPartialUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"reserved1yPartialUpfrontLinuxHr" REAL DEFAULT "0.0",
	"reserved1yPartialUpfrontSuseQuantity" REAL DEFAULT "0.0",
	"reserved1yPartialUpfrontSuseHr" REAL DEFAULT "0.0",
	"reserved1yPartialUpfrontRhelQuantity" REAL DEFAULT "0.0",
	"reserved1yPartialUpfrontRhelHr" REAL DEFAULT "0.0",
	"reserved1yPartialUpfrontWindowsQuantity" REAL DEFAULT "0.0",
	"reserved1yPartialUpfrontWindowsHr" REAL DEFAULT "0.0",
	/* Reserved 3Y partial upfront */
	"reserved3yPartialUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"reserved3yPartialUpfrontLinuxHr" REAL DEFAULT "0.0",
	"reserved3yPartialUpfrontSuseQuantity" REAL DEFAULT "0.0",
	"reserved3yPartialUpfrontSuseHr" REAL DEFAULT "0.0",
	"reserved3yPartialUpfrontRhelQuantity" REAL DEFAULT "0.0",
	"reserved3yPartialUpfrontRhelHr" REAL DEFAULT "0.0",
	"reserved3yPartialUpfrontWindowsQuantity" REAL DEFAULT "0.0",
	"reserved3yPartialUpfrontWindowsHr" REAL DEFAULT "0.0",
	/* Convertible reserved 1Y partial upfront */
	"convertible1yPartialUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"convertible1yPartialUpfrontLinuxHr" REAL DEFAULT "0.0",
	"convertible1yPartialUpfrontSuseQuantity" REAL DEFAULT "0.0",
	"convertible1yPartialUpfrontSuseHr" REAL DEFAULT "0.0",
	"convertible1yPartialUpfrontRhelQuantity" REAL DEFAULT "0.0",
	"convertible1yPartialUpfrontRhelHr" REAL DEFAULT "0.0",
	"convertible1yPartialUpfrontWindowsQuantity" REAL DEFAULT "0.0",
	"convertible1yPartialUpfrontWindowsHr" REAL DEFAULT "0.0",
	/* Convertible reserved 3Y partial upfront */
	"convertible3yPartialUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"convertible3yPartialUpfrontLinuxHr" REAL DEFAULT "0.0",
	"convertible3yPartialUpfrontSuseQuantity" REAL DEFAULT "0.0",
	"convertible3yPartialUpfrontSuseHr" REAL DEFAULT "0.0",
	"convertible3yPartialUpfrontRhelQuantity" REAL DEFAULT "0.0",
	"convertible3yPartialUpfrontRhelHr" REAL DEFAULT "0.0",
	"convertible3yPartialUpfrontWindowsQuantity" REAL DEFAULT "0.0",
	"convertible3yPartialUpfrontWindowsHr" REAL DEFAULT "0.0",
	/* Reserved 1Y all upfront */
	"reserved1yAllUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"reserved1yAllUpfrontSuseQuantity" REAL DEFAULT "0.0",
	"reserved1yAllUpfrontRhelQuantity" REAL DEFAULT "0.0",
	"reserved1yAllUpfrontWindowsQuantity" REAL DEFAULT "0.0",
	/* Reserved 3Y all upfront */
	"reserved3yAllUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"reserved3yAllUpfrontSuseQuantity" REAL DEFAULT "0.0",
	"reserved3yAllUpfrontRhelQuantity" REAL DEFAULT "0.0",
	"reserved3yAllUpfrontWindowsQuantity" REAL DEFAULT "0.0",
	/* Convertible reserved 1Y all upfront */
	"convertible1yAllUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"convertible1yAllUpfrontSuseQuantity" REAL DEFAULT "0.0",
	"convertible1yAllUpfrontRhelQuantity" REAL DEFAULT "0.0",
	"convertible1yAllUpfrontWindowsQuantity" REAL DEFAULT "0.0",
	/* Convertible reserved 3Y all upfront */
	"convertible3yAllUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"convertible3yAllUpfrontSuseQuantity" REAL DEFAULT "0.0",
	"convertible3yAllUpfrontRhelQuantity" REAL DEFAULT "0.0",
	"convertible3yAllUpfrontWindowsQuantity" REAL DEFAULT "0.0",
	PRIMARY KEY("instanceType", "location")
);

DROP TABLE IF EXISTS "instance-host-prices";
CREATE TABLE "instance-host-prices" (
	"instanceFamily" TEXT NOT NULL DEFAULT "",
	"location" TEXT NOT NULL DEFAULT "",
	/* On demand */
	"onDemandLinuxHr" REAL DEFAULT "0.0",
	/* Reserved 1Y no upfront */
	"reserved1yNoUpfrontLinuxHr" REAL DEFAULT "0.0",
	/* Reserved 3Y no upfront */
	"reserved3yNoUpfrontLinuxHr" REAL DEFAULT "0.0",
	/* Reserved 1Y partial upfront */
	"reserved1yPartialUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"reserved1yPartialUpfrontLinuxHr" REAL DEFAULT "0.0",
	/* Reserved 3Y partial upfront */
	"reserved3yPartialUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	"reserved3yPartialUpfrontLinuxHr" REAL DEFAULT "0.0",
	/* Reserved 1Y all upfront */
	"reserved1yAllUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	/* Reserved 3Y all upfront */
	"reserved3yAllUpfrontLinuxQuantity" REAL DEFAULT "0.0",
	PRIMARY KEY("instanceFamily", "location")
);

DROP TABLE IF EXISTS "storage-types";
CREATE TABLE "storage-types" (
	"storage" TEXT NOT NULL DEFAULT "",
	"storageType" TEXT NOT NULL DEFAULT "",
	"storageMedia" TEXT NOT NULL DEFAULT "",
	"maxVolumeSize" TEXT NOT NULL DEFAULT "",
	"maxThroughput" TEXT NOT NULL DEFAULT "",
	"maxIops" TEXT NOT NULL DEFAULT "",
	PRIMARY KEY("storage")
);

DROP TABLE IF EXISTS "storage-prices";
CREATE TABLE "storage-prices" (
	"storage" TEXT NOT NULL DEFAULT "",
	"location" TEXT NOT NULL DEFAULT "",
	"priceGb" REAL DEFAULT "0.0",
	"priceIops" REAL DEFAULT "0.0",
	"priceThroughput" REAL DEFAULT "0.0",
	PRIMARY KEY("storage", "location")
);

/* Index */
CREATE INDEX IF NOT EXISTS "storage-prices-location-index" ON "storage-prices"(location);
CREATE INDEX IF NOT EXISTS "instance-shared-prices-location-index" ON "instance-shared-prices"(location);
CREATE INDEX IF NOT EXISTS "instance-host-prices-location-index" ON "instance-host-prices"(location);