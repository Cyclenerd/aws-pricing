/*
 * Copyright 2024 Nils Knieling. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * FILTERS
 */

const filterParamsNumber = {
	filterOptions: ['equals', 'greaterThan', 'greaterThanOrEqual', 'lessThan', 'lessThanOrEqual'],
	defaultOption: 'greaterThanOrEqual',
	debounceMs: 100,
};
const filterLowerParamsNumber = {
	filterOptions: ['equals', 'greaterThan', 'greaterThanOrEqual', 'lessThan', 'lessThanOrEqual'],
	defaultOption: 'lessThanOrEqual',
	debounceMs: 100,
};
const filterParamsText = {
	filterOptions: ['equals', 'notEqual', 'contains', 'notContains', 'startsWith', 'endsWith'],
	defaultOption: 'contains',
	debounceMs: 100,
};
const filterParamsBoolean = {
	filterOptions: ['equals'],
	defaultOption: 'equals',
	maxNumConditions: 1,
	debounceMs: 0,
};

/*
 * FORMATTERS
 */

function booleanFormatter(params) {
	return (params.value >= 1) ? '✅ (1)' : '❌ (0)';
}

function processorClockFormatter(params) {
	return (params.value) ? params.value : '?';
}

function pricingFormatter(params) {
	return (params.value >= 0.000001) ? params.value : 'N/A';
}

/*
 * GRID
 */

const gridOptions = {
	columnDefs: [
		// groupId: 0
		{
			headerName: 'Instance Type',
			children: [
				{
					headerName: 'Name',
					headerTooltip: 'Instance Type',
					field: "instanceType",
					cellRenderer: params => {
						return '<a href="./' + params.value +'.html">'+ params.value + '</a>';
					},
					tooltipValueGetter: params => {
						return 'AWS EC2 instance type '+ params.value +' in location '+ params.data.location;
					},
					pinned: 'left',
					//rowDrag: true,
					checkboxSelection: true,
					width: 180,
				}
			]
		},
		// groupId: 1
		{
			headerName: 'Generation',
			children: [
				{
					headerName: 'Curr.',
					headerTooltip: 'Current Generation',
					field: "currentGeneration",
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90,
				}
			]
		},
		// groupId: 2
		{
			headerName: 'Location',
			children: [
				{
					headerName: 'Code',
					headerTooltip: 'Location Code',
					field: "location",
					tooltipField: 'location',
					width: 160,
				},
				{
					headerName: 'Name',
					field: "locationName",
					headerTooltip: 'Location Name',
					columnGroupShow: 'open',
					tooltipField: 'locationName',
					width: 180
				},
				{
					headerName: 'Type',
					field: "locationType",
					headerTooltip: 'Location Type',
					columnGroupShow: 'open',
					tooltipField: 'locationType',
					width: 120
				},
				{
					headerName: 'Continent',
					headerTooltip: 'Location Continent',
					field: "locationContinent",
					columnGroupShow: 'open',
					tooltipField: 'locationContinent',
					width: 120
				}
			]
		},
		// groupId: 3
		{
			headerName: 'Prozessor',
			children: [
				{ 
					headerName: 'vCPUs',
					headerTooltip: 'vCPUs',
					field: "vCpus",
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 90,
					// Default sorting on the vCPUs column
					sort: 'asc',
				},
				{ 
					headerName: 'Clock',
					headerTooltip: 'Processor Clock Speed',
					field: "processorClockSpeedInGhz",
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: processorClockFormatter,
					width: 120,
					cellClass: 'ghz',
				},
				{
					headerName: 'Burst.',
					headerTooltip: 'Burstable Performance Supported',
					field: 'burstablePerformanceSupported',
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90
				},
				{ 
					headerName: 'Cores',
					headerTooltip: 'Cores',
					field: "vCpuCores",
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					columnGroupShow: 'open',
					width: 90,
				},
				{ 
					headerName: 'Threads',
					headerTooltip: 'Threads per Core',
					field: "vCpuThreadsPerCore",
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					columnGroupShow: 'open',
					width: 90,
				},
				{
					headerName: 'Manufacturer',
					headerTooltip: 'Processor Manufacturer',
					field: 'processorManufacturer',
					columnGroupShow: 'open',
					width: 160
				},
				{
					headerName: 'Processor',
					headerTooltip: 'Processor',
					field: 'processor',
					columnGroupShow: 'open',
					tooltipField: 'processor',
					width: 180
				},
				{
					headerName: 'Features',
					headerTooltip: 'Processor Features',
					field: 'processorFeatures',
					columnGroupShow: 'open',
					tooltipField: 'processorFeatures',
					width: 120
				},
				{
					headerName: 'Architectures',
					headerTooltip: 'Processor Architectures',
					field: 'processorArchitectures',
					columnGroupShow: 'open',
					tooltipField: 'processorArchitectures',
					width: 160
				},
			]
		},
		// groupId: 4
		{
			headerName: 'Memory',
			children: [
				{
					headerName: 'RAM',
					headerTooltip: 'Random-access memory',
					field: "memorySizeInGiB",
					cellClass: 'gb',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 120,
				},
			]
		},
		// groupId: 5
		{
			headerName: 'Network',
			children: [
				{
					headerName: 'Performance',
					headerTooltip: 'Network Performance',
					field: 'networkPerformance',
					tooltipField: 'networkPerformance',
					width: 120
				},
				{
					headerName: 'Max. Interfaces',
					headerTooltip: 'Maximum Network Interfaces',
					field: 'maxNetworkInterfaces',
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 160
				},
				{
					headerName: 'Max. Cards',
					headerTooltip: 'Maximum Network Cards',
					field: 'maxNetworkCards',
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 120
				},
				{
					headerName: 'IPv6',
					headerTooltip: 'IPv6 Supported',
					field: 'ipv6Supported',
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90
				},
				{
					headerName: 'IPv4 Addr. per NIC',
					headerTooltip: 'IPv4 Addresses per Interface',
					field: 'ipv4AddrPerInterface',
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 160
				},
				{
					headerName: 'IPv6 Addr. per NIC',
					headerTooltip: 'IPv6 Addresses per Interface',
					field: 'ipv6AddrPerInterface',
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 160
				},
				{
					headerName: 'ENA',
					headerTooltip: 'Elastic Network Adapter (ENA) Supported',
					field: 'enaSupport',
					columnGroupShow: 'open',
					width: 120
				},
				{
					headerName: 'ENA Exp.',
					headerTooltip: 'ENA Express powered by AWS Scalable Reliable Datagram (SRD) Supported',
					field: 'enaSrdSupported',
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 120
				},
				{
					headerName: 'EFA',
					headerTooltip: 'Elastic Fabric Adapter (EFA) Supported',
					field: 'efaSupported',
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90
				},
				{
					headerName: 'ENC',
					headerTooltip: 'Network Encryption in Transit Supported',
					field: 'encryptionInTransitSupported',
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90
				},
			]
		},
		// groupId: 6
		{
			headerName: '$ Hour',
			children: [
				{
					headerName: 'On-Demand',
					headerTooltip: 'On-Demand Instance',
					field: "onDemandLinuxHr",
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'Spot',
					headerTooltip: 'Spot Instance',
					field: "spotLinuxHr",
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'SUSE',
					headerTooltip: 'On-Demand Instance with SUSE Linux Enterprise Server (SLES)',
					field: "onDemandSuseHr",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'RHEL',
					headerTooltip: 'On-Demand Instance with Red Hat Enterprise Linux (RHEL)',
					field: "onDemandRhelHr",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'Windows',
					headerTooltip: 'On-Demand Instance with Windows Server',
					field: "onDemandWindowsHr",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
			]
		},
		// groupId: 7
		{
			headerName: '$ Month',
			children: [
				{
					headerName: 'On-Demand',
					headerTooltip: 'On-Demand Instance',
					field: "onDemandLinuxMonth",
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'Spot',
					headerTooltip: 'Spot Instance',
					field: "spotLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'RI 1Y (No)',
					headerTooltip: 'Reserved Instance one-year term no upfront',
					field: "reserved1yNoUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'RI 1Y (Part)',
					headerTooltip: 'Reserved Instance one-year term partial upfront',
					field: "reserved1yPartialUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'RI 1Y (All)',
					headerTooltip: 'Reserved Instance one-year term all upfront',
					field: "reserved1yAllUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'RI 3Y (No)',
					headerTooltip: 'Reserved Instance three-year term no upfront',
					field: "reserved3yNoUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'RI 3Y (Part)',
					headerTooltip: 'Reserved Instance three-year term partial upfront',
					field: "reserved3yPartialUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'RI 3Y (All)',
					headerTooltip: 'Reserved Instance three-year term all upfront',
					field: "reserved3yAllUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'CRI 1Y (No)',
					headerTooltip: 'Convertible Reserved Instance one-year term no upfront',
					field: "convertible1yNoUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'CRI 1Y (Part)',
					headerTooltip: 'Convertible Reserved Instance one-year term partial upfront',
					field: "convertible1yPartialUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'CRI 1Y (All)',
					headerTooltip: 'Convertible Reserved Instance one-year term all upfront',
					field: "convertible1yAllUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'CRI 3Y (No)',
					headerTooltip: 'Convertible Reserved Instance three-year term no upfront',
					field: "convertible3yNoUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'CRI 3Y (Part)',
					headerTooltip: 'Convertible Reserved Instance three-year term partial upfront',
					field: "convertible3yPartialUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'CRI 3Y (All)',
					headerTooltip: 'Convertible Reserved Instance three-year term all upfront',
					field: "convertible3yAllUpfrontLinuxMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'SUSE',
					headerTooltip: 'On-Demand Instance with SUSE Linux Enterprise Server (SLES)',
					field: "onDemandSuseMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'RHEL',
					headerTooltip: 'On-Demand Instance with Red Hat Enterprise Linux (RHEL)',
					field: "onDemandRhelMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
				{
					headerName: 'Windows',
					headerTooltip: 'On-Demand Instance with Windows Server',
					field: "onDemandWindowsMonth",
					columnGroupShow: 'open',
					cellClass: 'usd',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					valueFormatter: pricingFormatter,
					width: 120,
				},
			]
		},
		// groupId: 8
		{
			headerName: 'Storage',
			children: [
				{
					headerName: 'Storage',
					headerTooltip: 'Storage',
					field: "storage",
					tooltipField: 'storage',
					width: 160,
				},
				{
					headerName: 'Root',
					headerTooltip: 'Supported Root Device Types',
					field: "supportedRootDeviceTypes",
					tooltipField: 'supportedRootDeviceTypes',
					columnGroupShow: 'open',
					width: 160,
				},
				{
					headerName: 'EBS Opt.',
					headerTooltip: 'EBS Optimized Support',
					field: "ebsOptimizedSupport",
					columnGroupShow: 'open',
					width: 160,
				},
				{
					headerName: 'EBS ENC',
					headerTooltip: 'EBS Encryption Support',
					field: "ebsEncryptionSupport",
					columnGroupShow: 'open',
					width: 160,
				},
				{
					headerName: 'EBS BW',
					headerTooltip: 'EBS Optimized Baseline Bandwidth',
					field: "ebsOptimizedBaselineBandwidthInMbps",
					columnGroupShow: 'open',
					cellClass: 'mbitps',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 160,
				},
				{
					headerName: 'EBS max. BW',
					headerTooltip: 'EBS Optimized Maximum Bandwidth',
					field: "ebsOptimizedMaxBandwidthInMbps",
					columnGroupShow: 'open',
					cellClass: 'mbitps',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 160,
				},
				{
					headerName: 'EBS THP',
					headerTooltip: 'EBS Optimized Baseline Throughput',
					field: "ebsOptimizedBaselineThroughputInMBps",
					columnGroupShow: 'open',
					cellClass: 'mbyteps',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 160,
				},
				{
					headerName: 'EBS max. THP',
					headerTooltip: 'EBS Optimized Maximum Throughput',
					field: "ebsOptimizedMaxThroughputInMBps",
					columnGroupShow: 'open',
					cellClass: 'mbyteps',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 160,
				},
				{
					headerName: 'EBS IOPS',
					headerTooltip: 'EBS Optimized Baseline IOPS',
					field: "ebsOptimizedBaselineIops",
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 160,
				},
				{
					headerName: 'EBS max. IOPS',
					headerTooltip: 'EBS Optimized Maximum IOPS',
					field: "ebsOptimizedMaxIops",
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 160,
				},
				{
					headerName: 'Instance Store',
					headerTooltip: 'Instance Store Total Size',
					field: "storageTotalSizeInGB",
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					columnGroupShow: 'open',
					width: 160,
				},
				{
					headerName: 'IS NVME',
					headerTooltip: 'Instance Store NVME Support',
					field: "storageNvmeSupport",
					columnGroupShow: 'open',
					width: 160,
				},
				{
					headerName: 'IS ENC',
					headerTooltip: 'Instance Store Encryption Support',
					field: "storageEncryptionSupport",
					columnGroupShow: 'open',
					width: 160,
				},
			]
		},
		// groupId: 9
		{
			headerName: 'Accelerator',
			children: [
				{
					headerName: 'GPUs',
					headerTooltip: 'GPUs',
					field: "gpuCount",
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 120,
				},
				{
					headerName: 'Memory',
					headerTooltip: 'GPU Total Memory',
					field: "gpuTotalGpuMemoryInGiB",
					cellClass: 'gb',
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					width: 120,
				},
				{
					headerName: 'Manufacturer',
					headerTooltip: 'GPU Manufacturer',
					field: "gpuManufacturer",
					tooltipField: 'gpuManufacturer',
					columnGroupShow: 'open',
					width: 160,
				},
				{
					headerName: 'Name',
					headerTooltip: 'GPU Name',
					field: "gpuName",
					tooltipField: 'gpuName',
					columnGroupShow: 'open',
					width: 190,
				},
			]
		},
		// groupId: 10
		{
			headerName: 'More... (SAP)',
			children: [
				{
					headerName: 'Family',
					headerTooltip: 'Instance Family Name',
					field: "instanceFamilyName",
					tooltipField: 'instanceFamilyName',
					width: 160,
				},
				{
					headerName: 'SAP',
					headerTooltip: 'SAP Supported',
					field: "sapSupported",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 120,
				},
				{
					headerName: 'HANA',
					headerTooltip: 'SAP HANA Supported',
					field: "sapHanaSupported",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 120,
				},
				{
					headerName: 'SAPS',
					headerTooltip: 'SAP Standard Benchmark (SAPS)',
					field: "sapSaps",
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					columnGroupShow: 'open',
					width: 120,
				},
				{
					headerName: 'Hypervisor',
					headerTooltip: 'Hypervisor',
					field: "hypervisor",
					tooltipField: 'hypervisor',
					columnGroupShow: 'open',
					width: 120,
				},
				{
					headerName: 'Metal',
					headerTooltip: 'Bare Metal Instance',
					field: "bareMetal",
					tooltipField: 'bareMetal',
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90,
				},
				{
					headerName: 'Classes',
					headerTooltip: 'Supported Usage Classes',
					field: "supportedUsageClasses",
					tooltipField: 'supportedUsageClasses',
					columnGroupShow: 'open',
					width: 160,
				},
				{
					headerName: 'Virt. Types',
					headerTooltip: 'Supported Virtualization Types',
					field: "supportedVirtualizationTypes",
					tooltipField: 'supportedVirtualizationTypes',
					columnGroupShow: 'open',
					width: 160,
				},
				{
					headerName: 'Placement',
					headerTooltip: 'Placement Group Supported Strategies',
					field: "placementGroupSupportedStrategies",
					tooltipField: 'placementGroupSupportedStrategies',
					columnGroupShow: 'open',
					width: 190,
				},
				{
					headerName: 'Hibernation',
					headerTooltip: 'Hibernation Supported',
					field: "hibernationSupported",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 120,
				},
				{
					headerName: 'Host',
					headerTooltip: 'Dedicated Hosts Supported',
					field: "dedicatedHostsSupported",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90,
				},
				{
					headerName: 'Recovery',
					headerTooltip: 'Auto Recovery Supported',
					field: "autoRecoverySupported",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 120,
				},
				{
					headerName: 'Boot',
					headerTooltip: 'Supported Boot Modes',
					field: "supportedBootModes",
					tooltipField: 'supportedBootModes',
					columnGroupShow: 'open',
					width: 160,
				},
				{
					headerName: 'Enclaves',
					headerTooltip: 'Nitro Enclaves Support',
					field: "nitroEnclavesSupport",
					tooltipField: 'nitroEnclavesSupport',
					columnGroupShow: 'open',
					width: 120,
				},
				{
					headerName: 'TPM',
					headerTooltip: 'Nitro TPM Support',
					field: "nitroTpmSupport",
					tooltipField: 'nitroTpmSupport',
					columnGroupShow: 'open',
					width: 120,
				},
				{
					headerName: 'TPM Ver.',
					headerTooltip: 'Nitro TPM Supported Versions',
					field: "nitroTpmSupportedVersions",
					tooltipField: 'nitroTpmSupportedVersions',
					columnGroupShow: 'open',
					width: 120,
				},
			]
		},
	],
	// Defaults
	defaultColDef: {
		resizable: true,
		sortable: true,
		minWidth: 90,
		maxWidth: 400,
		//width: 110,
		filter: 'agTextColumnFilter',
		filterParams: filterParamsText,
		floatingFilter: true,
		//editable: true,
	},
	groupHideOpenParents: true,
	tooltipShowDelay: 0,
	debounceVerticalScrollbar: true,
	ensureDomOrder: true,
	suppressColumnVirtualisation: true,
	rowBuffer: 60,
	rowSelection: 'multiple',
	rowMultiSelectWithClick: true,
	//rowDragManaged: true,
	//rowDragMultiRow: true,
	pagination: true,
	paginationPageSize: 50,
	//domLayout: 'autoHeight',
};

// lookup the container we want the Grid to use
const eGridDiv = document.querySelector('#myGrid');

// create the grid passing in the div to use together with the columns & data we want to use
//new agGrid.Grid(eGridDiv, gridOptions);
const gridApi = agGrid.createGrid(eGridDiv, gridOptions);

// fetch the row data to use and one ready provide it to the Grid via the Grid API
fetch('instances-locations.json?[% timestamp %]')
	.then(response => response.json())
	.then(data => {
		gridApi.setGridOption('rowData', data)
	}
);

/*
 * URL filter
 */

// URL params for initial filter
const queryString = window.location.search;
const urlParams   = new URLSearchParams(queryString);
const urlLocation = urlParams.get('location') || '';
const urlName     = urlParams.get('name')     || '';
const urlCpu      = urlParams.get('cpu')      || '';
const urlGpu      = urlParams.get('gpu')      || '';
const urlSap      = urlParams.get('sap')      || '';
const urlSapHana  = urlParams.get('hana')     || '';

// fist time data is rendered into the grid
gridApi.setGridOption('onFirstDataRendered', function () {
	console.log('firstDataRendered');
	// Initial filter with URL params
	let filterName     = urlName.replace(/[^\w\d\-\.]/g,"");
	let filterLocation = urlLocation.replace(/[^\w\d\-]/g,"");
	let filterCpu      = urlCpu.replace(/[^\w]/g,"");
	let filterGpu      = urlGpu.replace(/[^\d]/g,"");
	let filterSap      = (urlSap >= 1)  ? '1' : '';
	let filterSapHana  = (urlSapHana >= 1)  ? '1' : '';
	// Open groups
	var hardcodedGroupState = [];
	if (filterCpu) {
		hardcodedGroupState.push({ groupId: '3', open: true });
	}
	if (filterGpu) {
		hardcodedGroupState.push({ groupId: '9', open: true });
	}
	if (filterSap || filterSapHana) {
		hardcodedGroupState.push({ groupId: '10', open: true });
	}
	// Set filter
	var hardcodedFilter = {
		instanceType: {
			type: 'equals',
			filter: filterName,
		},
		location: {
			type: 'equals',
			filter: filterLocation,
		},
		processorManufacturer: {
			type: 'contains',
			filter: filterCpu,
		},
		gpuCount: {
			type: 'greaterThanOrEqual',
			filter: filterGpu,
		},
		sapSupported: {
			type: 'equals',
			filter: filterSap,
		},
		sapHanaSupported: {
			type: 'equals',
			filter: filterSapHana,
		},
	};
	// wait 500ms, because maybe the DOM isn't completely ready yet
	setTimeout(function(){
		gridApi.setColumnGroupState(hardcodedGroupState);
		gridApi.setFilterModel(hardcodedFilter);
	}, 500);
});

/*
 * KEYBOARD
 */

document.addEventListener('keydown', function(event) {
	// Copy selected rows with shown column
	if ((event.ctrlKey || event.metaKey) && event.key === 'c') {
		navigator.clipboard.writeText(gridApi.getDataAsCsv({
			skipColumnGroupHeaders: true,
			skipColumnHeaders: true,
			allColumns: false,
			onlySelected: true,
		}));
	}
	// Copy selected rows with all column
	if ((event.ctrlKey || event.metaKey) && event.key === 'x') {
		navigator.clipboard.writeText(gridApi.getDataAsCsv({
			skipColumnGroupHeaders: true,
			skipColumnHeaders: true,
			allColumns: true,
			onlySelected: true,
		}));
	}
	if ((event.ctrlKey || event.metaKey) && event.key === '/') {
		document.querySelector('[aria-label="vCPUs Filter Input"]').focus();
	}
});