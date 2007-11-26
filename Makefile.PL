#!perl
#
# This file is part of Audio::MPD::Common
# Copyright (c) 2007 Jerome Quelin, all rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
#

BEGIN { require 5.008; }
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Audio::MPD::Common',
    AUTHOR              => 'Jerome Quelin <jquelin@cpan.org>',
    VERSION_FROM        => 'lib/Audio/MPD/Common.pm',
    ABSTRACT_FROM       => 'lib/Audio/MPD/Common.pm',
    PREREQ_PM => {
        'Class::Accessor' => 0,
        'Readonly'        => 0,
        'Test::More'      => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => [
		'Audio-MPD-Common-*', 'MANIFEST.bak',
		map { ( '*/' x $_ ) . '*~' } 0..6
	] },
);
