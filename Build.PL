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
use Module::Build;

my $builder = Module::Build->new (
    module_name         => 'Audio::MPD::Common',
    dist_author         => 'Jerome Quelin <jquelin@cpan.org>',
    license             => 'perl',
    dist_version_from   => 'lib/Audio/MPD/Common.pm',
    add_to_cleanup => [
        'Audio-MPD-Common-*', 'MANIFEST.bak',
        map { ( '*/' x $_ ) . '*~' } 0..6 ],
    build_requires => {
        'Class::Accessor' => 0,
        'Readonly'        => 0,
        'Test::More'      => 0,
        'perl'            => '5.008',
    },
    requires => {
        'Class::Accessor' => 0,
        'Readonly'        => 0,
        'perl'            => '5.008',
    },
    recommends     => {
        'Test::Pod'           => 0,
        'Test::Pod::Coverage' => 0,
    },
);

$builder->create_build_script();
