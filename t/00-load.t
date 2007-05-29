#!perl
#
# This file is part of Audio::MPD::Common
# Copyright (c) 2007 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
#

use strict;
use warnings;

use Test::More tests => 8;

BEGIN { use_ok( 'Audio::MPD::Common' ); }
my $version = $Audio::MPD::Common::VERSION;
diag( "Testing Audio::MPD::Common $version, Perl $], $^X" );

use_ok( 'Audio::MPD::Common::Item::Directory' );
use_ok( 'Audio::MPD::Common::Item::Playlist' );
use_ok( 'Audio::MPD::Common::Item::Song' );
use_ok( 'Audio::MPD::Common::Item' );
use_ok( 'Audio::MPD::Common::Time' );
use_ok( 'Audio::MPD::Common::Stats' );
use_ok( 'Audio::MPD::Common::Status' );

exit;
