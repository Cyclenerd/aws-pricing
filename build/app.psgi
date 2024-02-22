#!/usr/bin/perl

use strict;
use Plack::App::Directory;

my $app = Plack::App::Directory->new({
	root => "../web/"
})->to_app;