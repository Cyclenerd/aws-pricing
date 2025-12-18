#!/usr/bin/perl

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
# Create static website with all Amazon EC2 instances in all locations/regions
#

use strict;
use DBI;
use Encode qw(decode);
use JSON::XS;
use Template;
use File::Copy;

# Open DB
my $dbFile  = './ec2.db';
my $db = DBI->connect("dbi:SQLite:dbname=$dbFile","","") or die "ERROR: Cannot connect $DBI::errstr\n";

# Exports
my $csvExport = 'aws-instances-locations.csv';
my $fileSizeCsvExport = -s "$csvExport" || die "ERROR: Cannot get CSV '$csvExport' filesize!\n";
$fileSizeCsvExport = sprintf '%.2f', $fileSizeCsvExport / 1048576;
my $sqlExport = 'aws-instances-locations.sql.gz';
my $fileSizeSqlExport = -s "$sqlExport" || die "ERROR: Cannot get SQL '$sqlExport' filesize!\n";
$fileSizeSqlExport = sprintf '%.2f', $fileSizeSqlExport / 1048576;

print "Select:\n";

# Instance Types
print "\tInstance Types\n";
my $instancesSqlFile = "./select/instances.sql";
open my $instancesSqlFh, "<", $instancesSqlFile or die "ERROR: Cannot open SQL file '$instancesSqlFile'!";
my $instancesSql = do { local $/; <$instancesSqlFh> };
my $instancesSth = $db->prepare($instancesSql);
$instancesSth->execute();
my @instances = ();
my @instancesIntel = ();
my @instancesAmd = ();
my @instancesAws = ();
my @instancesApple = ();
my @instancesSap = ();
my @instancesSapHana = ();
my @instancesGpu = ();
while (my $instance = $instancesSth->fetchrow_hashref) {
	push(@instances, $instance);
	push(@instancesIntel, $instance)   if ($instance->{'processorManufacturer'} =~ /Intel/);
	push(@instancesAmd, $instance)     if ($instance->{'processorManufacturer'} =~ /AMD/);
	push(@instancesAws, $instance)     if ($instance->{'processorManufacturer'} =~ /AWS/);
	push(@instancesApple, $instance)   if ($instance->{'processorManufacturer'} =~ /Apple/);
	push(@instancesSap, $instance)     if ($instance->{'sapSupported'});
	push(@instancesSapHana, $instance) if ($instance->{'sapHanaSupported'});
	push(@instancesGpu, $instance)     if ($instance->{'gpuTotalGpuMemoryInMiB'});
}
$instancesSth->finish;

# Locations
print "\tLocations\n";
my $locationsSqlFile = "./select/locations.sql";
open my $locationsSqlFh, "<", $locationsSqlFile or die "ERROR: Cannot open SQL file '$locationsSqlFile'!";
my $locationsSql = do { local $/; <$locationsSqlFh> };
my $locationsSth = $db->prepare($locationsSql);
$locationsSth->execute();
my @locations = ();
my @regions = ();
my @localZones = ();
my @wavelengthZones = ();
while (my $location = $locationsSth->fetchrow_hashref) {
	push(@locations, $location);
	push(@regions, $location)         if ($location->{'locationType'} =~ /Region/);
	push(@localZones, $location)      if ($location->{'locationType'} =~ /Local/);
	push(@wavelengthZones, $location) if ($location->{'locationType'} =~ /Wavelength/);
}
$locationsSth->finish;

print "\tAll Instance Types in all Locations\n";
my $instancesLocationsSqlFile = "./select/picker-instances-regions.sql";
open my $instancesLocationsSqlFh, "<", $instancesLocationsSqlFile or die "ERROR: Cannot open SQL file '$instancesLocationsSqlFile'!";
my $instancesLocationsSql = do { local $/; <$instancesLocationsSqlFh> };
my $instancesLocationsSth = $db->prepare($instancesLocationsSql);
$instancesLocationsSth->execute();
my @instancesLocations = ();
while (my $instanceLocation = $instancesLocationsSth->fetchrow_hashref) {
	push(@instancesLocations, $instanceLocation);
}
$instancesLocationsSth->finish;

# Template
mkdir('../web/');
my $gmtime = gmtime();
my $timestamp = time();
my $template = Template->new(
	INCLUDE_PATH => './src',
	PRE_PROCESS  => 'config.tt2',
	VARIABLES => {
		'gmtime'           => $gmtime,
		'timestamp'        => $timestamp,
		'csvFileSize'      => $fileSizeCsvExport,
		'sqlFileSize'      => $fileSizeSqlExport,
		'gitHubServerUrl'  => $ENV{'GITHUB_SERVER_URL'} || '',
		'gitHubRepository' => $ENV{'GITHUB_REPOSITORY'} || '',
		'gitHubRunId'      => $ENV{'GITHUB_RUN_ID'}     || '',
	}
);

# Instance Types
print "Instance Types:\n";
my @instancesPages = ('instances', 'intel', 'amd', 'aws-graviton', 'apple-silicon', 'gpu', 'sap', 'sap-hana');
foreach my $instancesPage (@instancesPages) {
	print "\t$instancesPage\n";
	$template->process(
		"$instancesPage.tt2",
		{
			'instances'        => \@instances,
			'instancesIntel'   => \@instancesIntel,
			'instancesAmd'     => \@instancesAmd,
			'instancesAws'     => \@instancesAws,
			'instancesApple'   => \@instancesApple,
			'instancesGpu'     => \@instancesGpu,
			'instancesSap'     => \@instancesSap,
			'instancesSapHana' => \@instancesSapHana,
		},
		"../web/$instancesPage.html"
	) || die "Template process failed: ", $template->error(), "\n";
}

# Locations
print "Locations:\n";
my @locationsPages = ('locations', 'regions', 'local-zones', 'wavelength-zones');
foreach my $locationsPage (@locationsPages) {
	print "\t$locationsPage\n";
	$template->process(
		"$locationsPage.tt2",
		{
			'locations'       => \@locations,
			'regions'         => \@regions,
			'localZones'      => \@localZones,
			'wavelengthZones' => \@wavelengthZones,
		},
		"../web/$locationsPage.html"
	) || die "Template process failed: ", $template->error(), "\n";
}

# Location Details
print "Location:\n";
my $locationInstancesSqlFile = "./select/location-instances.sql";
open my $locationInstancesSqlFh, "<", $locationInstancesSqlFile or die "ERROR: Cannot open SQL file '$locationInstancesSqlFile'!";
my $locationInstancesSql = do { local $/; <$locationInstancesSqlFh> };
my $locationDisksSqlFile = "./select/location-disks.sql";
open my $locationDisksSqlFh, "<", $locationDisksSqlFile or die "ERROR: Cannot open SQL file '$locationDisksSqlFile'!";
my $locationDisksSql = do { local $/; <$locationDisksSqlFh> };
foreach my $location (@locations) {
	my $locationCode = $location->{'location'};
	print "\t$locationCode\n";
	# Instance Types
	my $locationInstancesFilterSql = $locationInstancesSql;
	$locationInstancesFilterSql =~ s/us-east-1/$locationCode/g;
	my $locationInstancesSth = $db->prepare($locationInstancesFilterSql);
	$locationInstancesSth->execute();
	my @locationInstances = ();
	while (my $instance = $locationInstancesSth->fetchrow_hashref) { push(@locationInstances, $instance) }
	$locationInstancesSth->finish;
	# Disks (EBS Volume Types)
	my $locationDisksFilterSql = $locationDisksSql;
	$locationDisksFilterSql =~ s/us-east-1/$locationCode/g;
	my $locationDisksSth = $db->prepare($locationDisksFilterSql);
	$locationDisksSth->execute();
	my @locationDisks = ();
	while (my $disk = $locationDisksSth->fetchrow_hashref) { push(@locationDisks, $disk) }
	$locationDisksSth->finish;
	$template->process(
		'location.tt2',
		{
			'locations'         => \@locations,
			'instances'         => \@instances,
			'location'          => $location,
			'locationInstances' => \@locationInstances,
			'locationDisks'     => \@locationDisks,
		},
		"../web/$locationCode.html"
	) || die "Template process failed: ", $template->error(), "\n";
}

# Instance Type Details
print "Instance Type:\n";
my $instanceLocationsSqlFile = "./select/instance-locations.sql";
open my $instanceLocationsSqlFh, "<", $instanceLocationsSqlFile or die "ERROR: Cannot open SQL file '$instanceLocationsSqlFile'!";
my $instanceLocationsSql = do { local $/; <$instanceLocationsSqlFh> };
foreach my $instance (@instances) {
	my $instanceType = $instance->{'instanceType'};
	print "\t$instanceType\n";
	# Instance Types
	my $instanceLocationsFilterSql = $instanceLocationsSql;
	$instanceLocationsFilterSql =~ s/t3.medium/$instanceType/g;
	my $instanceLocationsSth = $db->prepare($instanceLocationsFilterSql);
	$instanceLocationsSth->execute();
	my @instanceLocations = ();
	while (my $location = $instanceLocationsSth->fetchrow_hashref) { push(@instanceLocations, $location) }
	$instanceLocationsSth->finish;
	$template->process(
		'instance.tt2',
		{
			'locations'         => \@locations,
			'instances'         => \@instances,
			'instance'          => $instance,
			'instanceLocations' => \@instanceLocations,
		},
		"../web/$instanceType.html"
	) || die "Template process failed: ", $template->error(), "\n";
}

# All Instance Types  in all Locations
print "Instance Picker:\n";
print "\tpicker.js\n";
$template->process('picker.js', {}, '../web/picker.js') || die "Template process failed: ", $template->error(), "\n";
print "\tinstances-locations.json\n";
my $instancesLocationsJson = encode_json \@instancesLocations;
$instancesLocationsJson = decode('UTF-8', $instancesLocationsJson); # force UTF-8
$template->process(
	'instances-locations.tt2',
	{
		'json' => $instancesLocationsJson
	},
	'../web/instances-locations.json'
) || die "Template process failed: ", $template->error(), "\n";

# Misc
print "Misc:\n";
my @miscPages = (
	'404',
	'download',
	'imprint',
	'index',
	'picker',
	'robots',
	'sitemap',
);
foreach my $miscPage (@miscPages) {
	print "\t$miscPage\n";
	my $fileExtension = 'html';
	$fileExtension = 'txt' if ($miscPage eq 'robots' || $miscPage eq 'sitemap');
	$template->process(
		"$miscPage.tt2",
		{
			'locations' => \@locations,
			'instances' => \@instances,
		},
		"../web/$miscPage.$fileExtension"
	) || die "Template process failed: ", $template->error(), "\n";
}

# Images
mkdir('../web/img/');
my @images = (
	'combine-filter.png',
	'filter.png',
	'social.png',
);
foreach my $image (@images) {
	copy("./src/img/$image", "../web/img/$image") || die "ERROR: Can not copy '$image'!\n";
}

# Favicon
my @favicons = (
	'favicon.ico',
	'favicon-16x16.png',
	'favicon-32x32.png',
	'apple-touch-icon.png',
	'android-chrome-192x192.png',
	'android-chrome-512x512.png',
	'site.webmanifest',
);
foreach my $favicon (@favicons) {
	copy("./src/img/favicon/$favicon", "../web/$favicon") || die "ERROR: Can not copy '$favicon'!\n";
}

# Exports
copy("./$csvExport", "../web/$csvExport") || die "ERROR: Can not copy '$csvExport'!\n";
copy("./$sqlExport", "../web/$sqlExport") || die "ERROR: Can not copy '$sqlExport'!\n";

copy("./src/ads.txt", "../web/ads.txt") || die "ERROR: Can not copy 'ads.txt'!\n";
copy("./src/popin-min.js", "../web/popin-min.js") || die "ERROR: Can not copy 'popin-min.js'!\n";

print "DONE\n";