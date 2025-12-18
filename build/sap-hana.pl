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
# Update SAP HANA supported instances
#

use strict;
use DBI;
use Text::CSV;

my $dbFile  = 'ec2.db';
my $csvFile = 'sap-hana.csv';

# Open DB
my $db = DBI->connect("dbi:SQLite:dbname=$dbFile","","") or die "ERROR: Cannot connect $DBI::errstr\n";

# Parse CSV
my $csv = Text::CSV->new ({ binary => 1, auto_diag => 1 });
open my $fh, "<:encoding(utf8)", $csvFile or die "ERROR: Cannot open CSV file '$csvFile'!";
while (my $row = $csv->getline ($fh)) {
	my $instanceType = $row->[1];
	my $saps = $row->[4];
	# Check instance type name (remove space)
	if ($instanceType =~ /^([\d\w-]+\.[\d\w-]+)/) {
		$instanceType = $1;
	} else {
		next;
	}
	# Check SAPS (remove space)
	if ($saps =~ /^(\d+)/) {
		$saps = $1;
	} else {
		next;
	}
	print "$instanceType [$saps]\n";
	my $update = qq ~
	UPDATE 'instance-types'
	SET sapHanaSupported = '1', sapSaps = '$saps'
	WHERE instanceType = '$instanceType';
	~;
	$db->do($update) or die "ERROR: Cannot update instance type '$DBI::errstr'\n";
}
close $fh;