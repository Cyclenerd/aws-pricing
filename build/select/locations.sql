SELECT
L."location",
L."locationName",
L."locationType",
L."locationContinent",
L."publicIpv4Addr",
/* Stats */
COUNT(P."instanceType") AS "instanceTypesInLocationCount",
/* Instance Family */
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.instanceFamilyName LIKE "General%"
	GROUP BY SP."location"
), "0") AS "instanceFamilyGeneralInLocationCount",
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.instanceFamilyName LIKE "Compute%"
	GROUP BY SP."location"
), "0") AS "instanceFamilyComputeInLocationCount",
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.instanceFamilyName LIKE "Memory%"
	GROUP BY SP."location"
), "0") AS "instanceFamilyMemoryInLocationCount",
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.instanceFamilyName LIKE "GPU%"
	GROUP BY SP."location"
), "0") AS "instanceFamilyGpuInLocationCount",
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.instanceFamilyName LIKE "Storage%"
	GROUP BY SP."location"
), "0") AS "instanceFamilyStorageInLocationCount",
/* Processor Manufacturer */
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.processorManufacturer = "Intel"
	GROUP BY SP."location"
), "0") AS "instanceTypesWithIntelCpuInLocationCount",
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.processorManufacturer = "AMD"
	GROUP BY SP."location"
), "0") AS "instanceTypesWithAmdCpuInLocationCount",
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.processorManufacturer = "AWS"
	GROUP BY SP."location"
), "0") AS "instanceTypesWithAwsCpuInLocationCount",
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.processorManufacturer = "Apple"
	GROUP BY SP."location"
), "0") AS "instanceTypesWithAppleCpuInLocationCount",
/* SAP */
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.sapSupported = "1"
	GROUP BY SP."location"
), "0") AS "instanceTypesWithSapSupportInLocationCount",
IFNULL((
	SELECT
		COUNT(SP."instanceType")
	FROM "instance-shared-prices" SP
	LEFT JOIN "instance-types" IT ON
		SP."instanceType" = IT."instanceType"
	WHERE SP."location" = L."location"
	AND IT.sapHanaSupported = "1"
	GROUP BY SP."location"
), "0") AS "instanceTypesWithSapHanaSupportInLocationCount",
/* Storage */
IFNULL((
	SELECT COUNT("storage")
	FROM "storage-prices"
	WHERE "location" = L."location"
	GROUP BY "location"
), "0") AS "storageTypesInLocationCount",
IFNULL((
	SELECT ROUND("onDemandLinuxHr", 4)
	FROM "instance-shared-prices"
	WHERE "instanceType" = "t3.medium"
	AND "location" = L."location"
), "") AS "onDemandT3MediumLinuxHr",
IFNULL((
	SELECT ROUND("onDemandLinuxHr"*730, 2)
	FROM "instance-shared-prices"
	WHERE "instanceType" = "t3.medium"
	AND "location" = L."location"
), "") AS "onDemandT3MediumLinuxMonth"
FROM "locations" L
INNER JOIN "instance-shared-prices" P ON L."location" = P."location"
GROUP BY L."location";