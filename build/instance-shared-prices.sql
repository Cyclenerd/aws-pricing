INSERT INTO "instance-shared-prices" (
	"instanceType",
	"location",
	/* On demand */
	"onDemandLinuxHr",
	"onDemandSuseHr",
	"onDemandRhelHr",
	"onDemandUbuntuProHr",
	"onDemandWindowsHr",
	/* Reserved 1Y no upfront */
	"reserved1yNoUpfrontLinuxHr",
	"reserved1yNoUpfrontSuseHr",
	"reserved1yNoUpfrontRhelHr",
	"reserved1yNoUpfrontWindowsHr",
	/* Reserved 3Y no upfront */
	"reserved3yNoUpfrontLinuxHr",
	"reserved3yNoUpfrontSuseHr",
	"reserved3yNoUpfrontRhelHr",
	"reserved3yNoUpfrontWindowsHr",
	/* Convertible reserved 1Y no upfront */
	"convertible1yNoUpfrontLinuxHr",
	"convertible1yNoUpfrontSuseHr",
	"convertible1yNoUpfrontRhelHr",
	"convertible1yNoUpfrontWindowsHr",
	/* Convertible reserved 3Y no upfront */
	"convertible3yNoUpfrontLinuxHr",
	"convertible3yNoUpfrontSuseHr",
	"convertible3yNoUpfrontRhelHr",
	"convertible3yNoUpfrontWindowsHr",
	/* Reserved 1Y partial upfront */
	"reserved1yPartialUpfrontLinuxQuantity",
	"reserved1yPartialUpfrontLinuxHr",
	"reserved1yPartialUpfrontSuseQuantity",
	"reserved1yPartialUpfrontSuseHr",
	"reserved1yPartialUpfrontRhelQuantity",
	"reserved1yPartialUpfrontRhelHr",
	"reserved1yPartialUpfrontWindowsQuantity",
	"reserved1yPartialUpfrontWindowsHr",
	/* Reserved 3Y partial upfront */
	"reserved3yPartialUpfrontLinuxQuantity",
	"reserved3yPartialUpfrontLinuxHr",
	"reserved3yPartialUpfrontSuseQuantity",
	"reserved3yPartialUpfrontSuseHr",
	"reserved3yPartialUpfrontRhelQuantity",
	"reserved3yPartialUpfrontRhelHr",
	"reserved3yPartialUpfrontWindowsQuantity",
	"reserved3yPartialUpfrontWindowsHr",
	/* Convertible reserved 1Y partial upfront */
	"convertible1yPartialUpfrontLinuxQuantity",
	"convertible1yPartialUpfrontLinuxHr",
	"convertible1yPartialUpfrontSuseQuantity",
	"convertible1yPartialUpfrontSuseHr",
	"convertible1yPartialUpfrontRhelQuantity",
	"convertible1yPartialUpfrontRhelHr",
	"convertible1yPartialUpfrontWindowsQuantity",
	"convertible1yPartialUpfrontWindowsHr",
	/* Convertible reserved 3Y partial upfront */
	"convertible3yPartialUpfrontLinuxQuantity",
	"convertible3yPartialUpfrontLinuxHr",
	"convertible3yPartialUpfrontSuseQuantity",
	"convertible3yPartialUpfrontSuseHr",
	"convertible3yPartialUpfrontRhelQuantity",
	"convertible3yPartialUpfrontRhelHr",
	"convertible3yPartialUpfrontWindowsQuantity",
	"convertible3yPartialUpfrontWindowsHr",
	/* Reserved 1Y all upfront */
	"reserved1yAllUpfrontLinuxQuantity",
	"reserved1yAllUpfrontSuseQuantity",
	"reserved1yAllUpfrontRhelQuantity",
	"reserved1yAllUpfrontWindowsQuantity",
	/* Reserved 3Y all upfront */
	"reserved3yAllUpfrontLinuxQuantity",
	"reserved3yAllUpfrontSuseQuantity",
	"reserved3yAllUpfrontRhelQuantity",
	"reserved3yAllUpfrontWindowsQuantity",
	/* Convertible reserved 1Y all upfront */
	"convertible1yAllUpfrontLinuxQuantity",
	"convertible1yAllUpfrontSuseQuantity",
	"convertible1yAllUpfrontRhelQuantity",
	"convertible1yAllUpfrontWindowsQuantity",
	/* Convertible reserved 3Y all upfront */
	"convertible3yAllUpfrontLinuxQuantity",
	"convertible3yAllUpfrontSuseQuantity",
	"convertible3yAllUpfrontRhelQuantity",
	"convertible3yAllUpfrontWindowsQuantity"
)
SELECT
	"Instance Type" AS "instanceType",
	LOWER("us-east-1") AS "location",
	/* On demand */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "OnDemand"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "Unit" = "Hrs"
	) AS "onDemandLinuxHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "OnDemand"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "Unit" = "Hrs"
	) AS "onDemandSuseHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "OnDemand"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "Unit" = "Hrs"
	) AS "onDemandRhelHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "OnDemand"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Ubuntu Pro"
		AND "Pre Installed S/W" = "NA"
		AND "Unit" = "Hrs"
	) AS "onDemandUbuntuProHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "OnDemand"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "Unit" = "Hrs"
	) AS "onDemandWindowsHr",
	/* Reserved 1Y no upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yNoUpfrontLinuxHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yNoUpfrontSuseHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yNoUpfrontRhelHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yNoUpfrontWindowsHr",
	/* Reserved 3Y no upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yNoUpfrontLinuxHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yNoUpfrontSuseHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yNoUpfrontRhelHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yNoUpfrontWindowsHr",
	/* Convertible reserved 1Y no upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible1yNoUpfrontLinuxHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible1yNoUpfrontSuseHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible1yNoUpfrontRhelHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible1yNoUpfrontWindowsHr",
	/* Convertible reserved 3Y no upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible3yNoUpfrontLinuxHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible3yNoUpfrontSuseHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible3yNoUpfrontRhelHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible3yNoUpfrontWindowsHr",
	/* Reserved 1Y partial upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved1yPartialUpfrontLinuxQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yPartialUpfrontLinuxHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved1yPartialUpfrontSuseQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yPartialUpfrontSuseHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved1yPartialUpfrontRhelQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yPartialUpfrontRhelHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved1yPartialUpfrontWindowsQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yPartialUpfrontWindowsHr",
	/* Reserved 3Y partial upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved3yPartialUpfrontLinuxQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yPartialUpfrontLinuxHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved3yPartialUpfrontSuseQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yPartialUpfrontSuseHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved3yPartialUpfrontRhelQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yPartialUpfrontRhelHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved3yPartialUpfrontWindowsQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yPartialUpfrontWindowsHr",
	/* Convertible reserved 1Y partial upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible1yPartialUpfrontLinuxQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible1yPartialUpfrontLinuxHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible1yPartialUpfrontSuseQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible1yPartialUpfrontSuseHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible1yPartialUpfrontRhelQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible1yPartialUpfrontRhelHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible1yPartialUpfrontWindowsQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible1yPartialUpfrontWindowsHr",
	/* Convertible reserved 3Y partial upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible3yPartialUpfrontLinuxQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible3yPartialUpfrontLinuxHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible3yPartialUpfrontSuseQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible3yPartialUpfrontSuseHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible3yPartialUpfrontRhelQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible3yPartialUpfrontRhelHr",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible3yPartialUpfrontWindowsQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Hrs"
	) AS "convertible3yPartialUpfrontWindowsHr",
	/* Reserved 1Y all upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved1yAllUpfrontLinuxQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved1yAllUpfrontSuseQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved1yAllUpfrontRhelQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved1yAllUpfrontWindowsQuantity",
	/* Reserved 3Y all upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved3yAllUpfrontLinuxQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved3yAllUpfrontSuseQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved3yAllUpfrontRhelQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved3yAllUpfrontWindowsQuantity",
	/* Convertible reserved 1Y partial upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible1yAllUpfrontLinuxQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible1yAllUpfrontSuseQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible1yAllUpfrontRhelQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible1yAllUpfrontWindowsQuantity",
	/* Convertible reserved 3Y all upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible3yAllUpfrontLinuxQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "SUSE"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible3yAllUpfrontSuseQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "RHEL"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible3yAllUpfrontRhelQuantity",
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Shared"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "Used"
		AND "Operating System" = "Windows"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "convertible"
		AND "Unit" = "Quantity"
	) AS "convertible3yAllUpfrontWindowsQuantity"
FROM "us-east-1" I
WHERE ("Tenancy" = "Shared" OR "Tenancy" = "Host")
AND ("TermType" = "OnDemand" OR "TermType" = "Reserved")
AND "CapacityStatus" = "Used"
GROUP BY "Instance Type"
ORDER BY "Instance Type";