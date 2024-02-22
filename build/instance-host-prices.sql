INSERT INTO "instance-host-prices" (
	"instanceFamily",
	"location",
	/* On demand */
	"onDemandLinuxHr",
	/* Reserved 1Y no upfront */
	"reserved1yNoUpfrontLinuxHr",
	/* Reserved 3Y no upfront */
	"reserved3yNoUpfrontLinuxHr",
	/* Reserved 1Y partial upfront */
	"reserved1yPartialUpfrontLinuxQuantity",
	"reserved1yPartialUpfrontLinuxHr",
	/* Reserved 3Y partial upfront */
	"reserved3yPartialUpfrontLinuxQuantity",
	"reserved3yPartialUpfrontLinuxHr",
	/* Reserved 1Y all upfront */
	"reserved1yAllUpfrontLinuxQuantity",
	/* Reserved 3Y all upfront */
	"reserved3yAllUpfrontLinuxQuantity"
)
SELECT
	"Instance Type" AS "instanceFamily",
	LOWER("us-east-1") AS "location",
	/* On demand */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "OnDemand"
		AND "Tenancy" = "Host"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "AllocatedHost"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "Unit" = "Hrs"
	) AS "onDemandLinuxHr",
	/* Reserved 1Y no upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Reserved"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "AllocatedHost"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yNoUpfrontLinuxHr",
	/* Reserved 3Y no upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Reserved"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "AllocatedHost"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "No%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yNoUpfrontLinuxHr",
	/* Reserved 1Y partial upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Reserved"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "AllocatedHost"
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
		AND "Tenancy" = "Reserved"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "AllocatedHost"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved1yPartialUpfrontLinuxHr",
	/* Reserved 3Y partial upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Reserved"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "AllocatedHost"
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
		AND "Tenancy" = "Reserved"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "AllocatedHost"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "Partial%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Hrs"
	) AS "reserved3yPartialUpfrontLinuxHr",
	/* Reserved 1Y all upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Reserved"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "AllocatedHost"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "1%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved1yAllUpfrontLinuxQuantity",
	/* Reserved 3Y all upfront */
	(
		SELECT "PricePerUnit"
		FROM "us-east-1"
		WHERE "Instance Type" = I."Instance Type"
		AND "TermType" = "Reserved"
		AND "Tenancy" = "Reserved"
		AND "License Model" = "No License required"
		AND "CapacityStatus" = "AllocatedHost"
		AND "Operating System" = "Linux"
		AND "Pre Installed S/W" = "NA"
		AND "LeaseContractLength" LIKE "3%"
		AND "PurchaseOption" LIKE "All%"
		AND "OfferingClass" = "standard"
		AND "Unit" = "Quantity"
	) AS "reserved3yAllUpfrontLinuxQuantity"
FROM "us-east-1" I
WHERE ("Tenancy" = "Host" OR "Tenancy" = "Reserved")
AND ("TermType" = "OnDemand" OR "TermType" = "Reserved")
AND "CapacityStatus" LIKE "AllocatedHost"
GROUP BY "Instance Type"
ORDER BY "Instance Type";