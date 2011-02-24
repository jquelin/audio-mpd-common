#!perl

use strict;
use warnings;

use Audio::MPD::Common::Output;
use Test::More tests => 4;


my %kv = (
    id      => 3,
    name    => "my soundcard",
    enabled => 1,
);

my $s = Audio::MPD::Common::Output->new( \%kv );
isa_ok( $s, 'Audio::MPD::Common::Output', 'object creation' );
is( $s->id,      3,              'accessor: id' );
is( $s->name,    "my soundcard", 'accessor: name' );
is( $s->enabled, 1,              'accessor: enabled' );
