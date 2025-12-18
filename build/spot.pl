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
# Update spot price from JSON (https://aws.amazon.com/ec2/spot/pricing/)
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

my $prices = JSON::XS->new->utf8->decode($json);

foreach my $region (sort @{$prices->{'config'}->{'regions'}}) {
	my $location = $region->{'region'} || "";
	print "$location\n";
	foreach my $type (@{$region->{'instanceTypes'}}) {
		foreach my $size (@{$type->{'sizes'}}) {
			my $instanceType = $size->{'size'};
			my ($spotLinuxHr, $spotWindowsHr);
			print "\t$instanceType\n";
			foreach my $price (@{$size->{'valueColumns'}}) {
				my $os = $price->{'name'};
				my $usd = $price->{'prices'}->{'USD'} || "0.0";
				if ($usd !~ /^[\d\.]+$/ ) { $usd = "0.0" }
				if ($os eq "linux") { $spotLinuxHr = $usd }
				if ($os eq "mswin") { $spotWindowsHr = $usd }
			}
			my $update = qq ~
			UPDATE 'instance-shared-prices'
			SET
				spotLinuxHr = '$spotLinuxHr',
				spotWindowsHr = '$spotWindowsHr'
			WHERE instanceType = '$instanceType'
			AND location = '$location';
			~;
			$db->do($update) or die "ERROR: Cannot update instance spot price '$DBI::errstr'\n";
		}
	}
}