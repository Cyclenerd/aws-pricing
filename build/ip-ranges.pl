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
# Update number of public IPv4 addresses for Amazon EC2 instances in each location
# Thank you PatMyron: https://github.com/PatMyron/cloud/issues/11#issuecomment-922591282
#

use strict;
use DBI;
use JSON::XS;

my $dbFile  = 'ec2.db';

# Open DB
my $db = DBI->connect("dbi:SQLite:dbname=$dbFile","","") or die "ERROR: Cannot connect $DBI::errstr\n";

# Parse JSON
my $json;
while(<>){ $json .= $_ }

my $publicipranges = JSON::XS->new->utf8->decode($json);

my %locations;
foreach my $prefix (sort @{$publicipranges->{'prefixes'}}) {
	my $service = $prefix->{'service'} || "";
	next if ($service ne "EC2");
	my $network_border_group = $prefix->{'network_border_group'} || "";
	next if (!$network_border_group || $network_border_group eq "GLOBAL");
	if ($prefix->{'ip_prefix'} =~ /\/(\d+)$/) {
		my $mask = $1;
		my $ipv4 = 2**(32-$mask);
		$locations{$network_border_group} += $ipv4;
	}
}

foreach my $location (sort keys %locations) {
	my $ipv4 = $locations{$location} || "0";
	print "$location\n";
	my $update = "UPDATE locations SET publicIpv4Addr = '$ipv4' WHERE location = '$location';";
	$db->do($update) or die "ERROR: Cannot update location '$DBI::errstr'\n";
}