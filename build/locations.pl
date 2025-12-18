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
# Insert locations from JSON
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

my $locations = JSON::XS->new->utf8->decode($json);

foreach my $location (keys %{$locations}) {
	my $code = $locations->{$location}->{'code'} || "";
	my $name = $locations->{$location}->{'name'} || "";
	my $type = $locations->{$location}->{'type'} || "";
	my $continent = $locations->{$location}->{'continent'} || "";
	print "$code\n";
	my $insert = qq ~
	INSERT INTO 'locations' (
		'location',
		'locationName',
		'locationType',
		'locationContinent'
	) VALUES (
		'$code',
		'$name',
		'$type',
		'$continent'
	);
	~;
	$db->do($insert) or die "ERROR: Cannot insert location '$DBI::errstr'\n";
}