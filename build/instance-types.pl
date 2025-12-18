#!/usr/bin/env perl

# Copyright 2024 Nils Knieling. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Create instance types from AWS EC2 API JSON and price list
#

use strict;
use DBI;
use JSON::XS;

my $dbFile  = 'ec2.db';

# Open DB
my $db = DBI->connect("dbi:SQLite:dbname=$dbFile","","") or die "ERROR: Cannot connect $DBI::errstr\n";

# Parse JSON
my $json;
while(<>) { $json .= $_ }
my $instances = JSON::XS->new->utf8->decode($json);

foreach my $instance (@{$instances->{'InstanceTypes'}}) {
	my $instanceType = $instance->{'InstanceType'} || '';
	my $instanceFamily;
	if ($instanceType =~ /^([\d\w-]+)\./) {
		$instanceFamily = $1;
	} else {
		die "ERROR: Instance type missing!\n"
	}
	print "$instanceType [$instanceFamily]\n";
	my $currentGeneration = $instance->{'CurrentGeneration'} || '0';
	my $freeTierEligible = $instance->{'FreeTierEligible'} || '0';
	my $supportedUsageClasses = join(', ', @{$instance->{'SupportedUsageClasses'}});
	my $supportedRootDeviceTypes = join(', ', @{$instance->{'SupportedRootDeviceTypes'}});
	my $supportedVirtualizationTypes = join(', ', @{$instance->{'SupportedVirtualizationTypes'}});
	my $bareMetal = $instance->{'BareMetal'} || '0';
	my $hypervisor = $instance->{'Hypervisor'} || '';
	# CPU
	my $processorInfoSupportedArchitectures = join(', ', @{$instance->{'ProcessorInfo'}->{'SupportedArchitectures'}});
	my $processorInfoSustainedClockSpeedInGhz = $instance->{'ProcessorInfo'}->{'SustainedClockSpeedInGhz'} || '0.0';
	my $processorInfoManufacturer = $instance->{'ProcessorInfo'}->{'Manufacturer'} || '?';
	my $vCpuInfoDefaultVCpus = $instance->{'VCpuInfo'}->{'DefaultVCpus'} || '0';
	my $vCpuInfoDefaultCores = $instance->{'VCpuInfo'}->{'DefaultCores'} || '0';
	my $vCpuInfoDefaultThreadsPerCore = $instance->{'VCpuInfo'}->{'DefaultThreadsPerCore'} || '0';
	# RAM
	my $memoryInfoSizeInMiB = $instance->{'MemoryInfo'}->{'SizeInMiB'} || '0';
	# Storage
	my $storageSupported = $instance->{'InstanceStorageSupported'} || '0';
	my $storageInfoTotalSizeInGB = $instance->{'InstanceStorageInfo'}->{'TotalSizeInGB'} || '0';
	foreach my $disk (@{$instance->{'InstanceStorageInfo'}->{'Disks'}}) {
		my $sizeInGB = $disk->{'SizeInGB'};
		my $count = $disk->{'Count'};
		my $type = $disk->{'Type'};
		my $insert = qq ~
		INSERT INTO 'instance-disks' ('instanceType', 'sizeInGB', 'count', 'type')
		VALUES ('$instanceType', '$sizeInGB', '$count', '$type');
		~;
		$db->do($insert) or die "ERROR: Cannot insert disk '$DBI::errstr'\n";
	}
	my $storageInfoNvmeSupport = $instance->{'InstanceStorageInfo'}->{'NvmeSupport'} || '';
	my $storageInfoEncryptionSupport = $instance->{'InstanceStorageInfo'}->{'EncryptionSupport'} || '';
	# EBS
	my $ebsInfoEbsOptimizedSupport = $instance->{'EbsInfo'}->{'EbsOptimizedSupport'} || '';
	my $ebsInfoEncryptionSupport = $instance->{'EbsInfo'}->{'EncryptionSupport'} || '';
	my $ebsInfoEbsOptimizedInfoBaselineBandwidthInMbps = $instance->{'EbsInfo'}->{'EbsOptimizedInfo'}->{'BaselineBandwidthInMbps'} || '0';
	my $ebsInfoEbsOptimizedInfoBaselineThroughputInMBps = $instance->{'EbsInfo'}->{'EbsOptimizedInfo'}->{'BaselineThroughputInMBps'} || '0.0';
	my $ebsInfoEbsOptimizedInfoBaselineIops = $instance->{'EbsInfo'}->{'EbsOptimizedInfo'}->{'BaselineIops'} || '0';
	my $ebsInfoEbsOptimizedInfoMaximumBandwidthInMbps = $instance->{'EbsInfo'}->{'EbsOptimizedInfo'}->{'MaximumBandwidthInMbps'} || '0';
	my $ebsInfoEbsOptimizedInfoMaximumThroughputInMBps = $instance->{'EbsInfo'}->{'EbsOptimizedInfo'}->{'MaximumThroughputInMBps'} || '0.0';
	my $ebsInfoEbsOptimizedInfoMaximumIops = $instance->{'EbsInfo'}->{'EbsOptimizedInfo'}->{'MaximumIops'} || '0';
	my $ebsInfoNvmeSupport = $instance->{'EbsInfo'}->{'NvmeSupport'} || '';
	# Network
	my $networkInfoNetworkPerformance = $instance->{'NetworkInfo'}->{'NetworkPerformance'} || '?';
	my $networkInfoMaximumNetworkInterfaces = $instance->{'NetworkInfo'}->{'MaximumNetworkInterfaces'} || '0';
	my $networkInfoMaximumNetworkCards = $instance->{'NetworkInfo'}->{'MaximumNetworkCards'} || '0';
	my $networkInfoDefaultNetworkCardIndex = $instance->{'NetworkInfo'}->{'DefaultNetworkCardIndex'} || '0';
	foreach my $networkCard (@{$instance->{'NetworkInfo'}->{'NetworkCards'}}) {
		my $networkCardIndex = $networkCard->{'NetworkCardIndex'};
		my $networkPerformance = $networkCard->{'NetworkPerformance'};
		my $maximumNetworkInterfaces = $networkCard->{'MaximumNetworkInterfaces'};
		my $baselineBandwidthInGbps = $networkCard->{'BaselineBandwidthInGbps'};
		my $peakBandwidthInGbps = $networkCard->{'PeakBandwidthInGbps'};
		my $insert = qq ~
		INSERT INTO 'instance-network-cards' (
			'instanceType',
			'networkCardIndex',
			'networkPerformance',
			'maximumNetworkInterfaces',
			'baselineBandwidthInGbps',
			'peakBandwidthInGbps'
		) VALUES (
			'$instanceType',
			'$networkCardIndex',
			'$networkPerformance',
			'$maximumNetworkInterfaces',
			'$baselineBandwidthInGbps',
			'$peakBandwidthInGbps'
		);
		~;
		$db->do($insert) or die "ERROR: Cannot insert network card '$DBI::errstr'\n";
	}
	my $networkInfoIpv4AddressesPerInterface = $instance->{'NetworkInfo'}->{'Ipv4AddressesPerInterface'} || '0';
	my $networkInfoIpv6AddressesPerInterface = $instance->{'NetworkInfo'}->{'Ipv6AddressesPerInterface'} || '0';
	my $networkInfoIpv6Supported = $instance->{'NetworkInfo'}->{'Ipv6Supported'} || '0';
	my $networkInfoEnaSupport = $instance->{'NetworkInfo'}->{'EnaSupport'} || '';
	my $networkInfoEfaSupported = $instance->{'NetworkInfo'}->{'EfaSupported'} || '0';
	my $networkInfoEncryptionInTransitSupported = $instance->{'NetworkInfo'}->{'EncryptionInTransitSupported'} || '0';
	my $networkInfoEnaSrdSupported = $instance->{'NetworkInfo'}->{'EnaSrdSupported'} || '0';
	# GPU
	foreach my $gpu (@{$instance->{'GpuInfo'}->{'Gpus'}}) {
		my $name = $gpu->{'Name'};
		my $manufacturer = $gpu->{'Manufacturer'};
		my $count = $gpu->{'Count'};
		my $memoryInfoSizeInMiB = $gpu->{'MemoryInfo'}->{'SizeInMiB'};
		my $insert = qq ~
		INSERT INTO 'instance-gpus' (
			'instanceType',
			'name',
			'manufacturer',
			'count',
			'memorySizeInMiB'
		) VALUES (
			'$instanceType',
			'$name',
			'$manufacturer',
			'$count',
			'$memoryInfoSizeInMiB'
		);
		~;
		$db->do($insert) or die "ERROR: Cannot insert GPU '$DBI::errstr'\n";
	}
	my $gpuInfoTotalGpuMemoryInMiB = $instance->{'GpuInfo'}->{'TotalGpuMemoryInMiB'} || '0';
	# Misc
	my $placementGroupInfoSupportedStrategies = join(', ', @{$instance->{'PlacementGroupInfo'}->{'SupportedStrategies'}||()});
	my $hibernationSupported = $instance->{'HibernationSupported'} || '0';
	my $burstablePerformanceSupported = $instance->{'BurstablePerformanceSupported'} || '0';
	my $dedicatedHostsSupported = $instance->{'DedicatedHostsSupported'} || '0';
	my $autoRecoverySupported = $instance->{'AutoRecoverySupported'} || '0';
	my $supportedBootModes = join(', ', @{$instance->{'SupportedBootModes'}});
	my $nitroEnclavesSupport = $instance->{'NitroEnclavesSupport'} || '';
	my $nitroTpmSupport = $instance->{'NitroTpmSupport'} || '';
	my $nitroTpmInfoSupportedVersions = '';
	if ($instance->{'NitroTpmInfo'}) {
		$nitroTpmInfoSupportedVersions = join(', ', @{$instance->{'NitroTpmInfo'}->{'SupportedVersions'}});
	}

	my $insert = qq ~
	INSERT INTO 'instance-types' (
		'instanceType',
		'instanceFamily',
		'currentGeneration',
		'freeTierEligible',
		'supportedUsageClasses',
		'supportedRootDeviceTypes',
		'supportedVirtualizationTypes',
		'bareMetal',
		'hypervisor',
		'processorArchitectures',
		'processorClockSpeedInGhz',
		'processorManufacturer',
		'vCpus',
		'vCpuCores',
		'vCpuThreadsPerCore',
		'memorySizeInMiB',
		'storageSupported',
		'storageTotalSizeInGB',
		'storageNvmeSupport',
		'storageEncryptionSupport',
		'ebsOptimizedSupport',
		'ebsEncryptionSupport',
		'ebsOptimizedBaselineBandwidthInMbps',
		'ebsOptimizedBaselineThroughputInMBps',
		'ebsOptimizedBaselineIops',
		'ebsOptimizedMaxBandwidthInMbps',
		'ebsOptimizedMaxThroughputInMBps',
		'ebsOptimizedMaxIops',
		'ebsNvmeSupport',
		'networkPerformance',
		'maxNetworkInterfaces',
		'maxNetworkCards',
		'ipv4AddrPerInterface',
		'ipv6AddrPerInterface',
		'ipv6Supported',
		'enaSupport',
		'efaSupported',
		'encryptionInTransitSupported',
		'enaSrdSupported',
		'gpuTotalGpuMemoryInMiB',
		'placementGroupSupportedStrategies',
		'hibernationSupported',
		'burstablePerformanceSupported',
		'dedicatedHostsSupported',
		'autoRecoverySupported',
		'supportedBootModes',
		'nitroEnclavesSupport',
		'nitroTpmSupport',
		'nitroTpmSupportedVersions'
	) VALUES (
		'$instanceType',
		'$instanceFamily',
		'$currentGeneration',
		'$freeTierEligible',
		'$supportedUsageClasses',
		'$supportedRootDeviceTypes',
		'$supportedVirtualizationTypes',
		'$bareMetal',
		'$hypervisor',
		'$processorInfoSupportedArchitectures',
		'$processorInfoSustainedClockSpeedInGhz',
		'$processorInfoManufacturer',
		'$vCpuInfoDefaultVCpus',
		'$vCpuInfoDefaultCores',
		'$vCpuInfoDefaultThreadsPerCore',
		'$memoryInfoSizeInMiB',
		'$storageSupported',
		'$storageInfoTotalSizeInGB',
		'$storageInfoNvmeSupport',
		'$storageInfoEncryptionSupport',
		'$ebsInfoEbsOptimizedSupport',
		'$ebsInfoEncryptionSupport',
		'$ebsInfoEbsOptimizedInfoBaselineBandwidthInMbps',
		'$ebsInfoEbsOptimizedInfoBaselineThroughputInMBps',
		'$ebsInfoEbsOptimizedInfoBaselineIops',
		'$ebsInfoEbsOptimizedInfoMaximumBandwidthInMbps',
		'$ebsInfoEbsOptimizedInfoMaximumThroughputInMBps',
		'$ebsInfoEbsOptimizedInfoMaximumIops',
		'$ebsInfoNvmeSupport',
		'$networkInfoNetworkPerformance',
		'$networkInfoMaximumNetworkInterfaces',
		'$networkInfoMaximumNetworkCards',
		'$networkInfoIpv4AddressesPerInterface',
		'$networkInfoIpv6AddressesPerInterface',
		'$networkInfoIpv6Supported',
		'$networkInfoEnaSupport',
		'$networkInfoEfaSupported',
		'$networkInfoEncryptionInTransitSupported',
		'$networkInfoEnaSrdSupported',
		'$gpuInfoTotalGpuMemoryInMiB',
		'$placementGroupInfoSupportedStrategies',
		'$hibernationSupported',
		'$burstablePerformanceSupported',
		'$dedicatedHostsSupported',
		'$autoRecoverySupported',
		'$supportedBootModes',
		'$nitroEnclavesSupport',
		'$nitroTpmSupport',
		'$nitroTpmInfoSupportedVersions'
	);
	~;
	$db->do($insert) or die "ERROR: Cannot insert instance '$DBI::errstr'\n";
}

# Update values from price list table
my $select = qq ~
SELECT
	"Instance Type" AS "instanceType",
	"Instance Family" AS "instanceFamilyName",
	"Physical Processor" AS "processor",
	"Processor Features" AS "processorFeatures",
	"Storage" AS "storage"
FROM "us-east-1"
WHERE "Instance Type" != ""
GROUP BY "Instance Type"
~;
my $sth = $db->prepare($select);
$sth->execute;
$sth->bind_columns (\my (
	$instanceType,
	$instanceFamilyName,
	$processor,
	$processorFeatures,
	$storage
));
while ($sth->fetch) {
	my $update = qq ~
	UPDATE 'instance-types'
	SET
		instanceFamilyName = '$instanceFamilyName',
		processor = '$processor',
		processorFeatures = '$processorFeatures',
		storage = '$storage'
	WHERE instanceType = '$instanceType';
	~;
	$db->do($update) or die "ERROR: Cannot update instance '$DBI::errstr'\n";
}