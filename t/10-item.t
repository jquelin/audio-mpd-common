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

use Audio::MPD::Common::Item;
use Test::More tests => 22;

my ($i, $output, @output, %params);

#
# testing amc::item::song
$output = 'file: some/random/path/to/a/song.ogg
Time: 234
Artist: Foo Bar
Album: Frobnizer
Track: 26
Title: Blah!
Pos: 10
Id: 14
';
@output = split /\n/, $output;
%params = map { /^([^:]+):\s+(.*)$/ ? ($1=>$2) : () } @output;
$i = Audio::MPD::Common::Item->new( %params );
isa_ok( $i, 'Audio::MPD::Common::Item::Song', 'song creation' );
is( $i->file,   'some/random/path/to/a/song.ogg',  'accessor: file' );
is( $i->time,   234,                               'accessor: time' );
is( $i->artist, 'Foo Bar',                         'accessor: artist' );
is( $i->album,  'Frobnizer',                       'accessor: album' );
is( $i->track,  26,                                'accessor: track' );
is( $i->title,  'Blah!',                           'accessor: title' );
is( $i->pos,    10,                                'accessor: pos' );
is( $i->id,     14,                                'accessor: id' );
isa_ok( $i, 'Audio::MPD::Common::Item', 'song inherits from item' );


#
# testing as_string from amc::item::song.
is( $i->as_string, 'Frobnizer = 26 = Foo Bar = Blah!', 'as_string() with all tags' );
$i->track(undef);
is( $i->as_string, 'Foo Bar = Blah!', 'as_string() without track' );
$i->track(26); $i->album(undef);
is( $i->as_string, 'Foo Bar = Blah!', 'as_string() without album' );
$i->artist(undef);
is( $i->as_string, 'Blah!',           'as_string() without artist' );
$i->title(undef);
is( $i->as_string, 'some/random/path/to/a/song.ogg', 'as_string() without title' );


#
# testing amc::item::directory
$output = "directory: some/random/path\n";
@output = split /\n/, $output;
%params = map { /^([^:]+):\s+(.*)$/ ? ($1=>$2) : () } @output;
$i = Audio::MPD::Common::Item->new( %params );
isa_ok( $i, 'Audio::MPD::Common::Item::Directory', 'directory creation' );
is( $i->directory, 'some/random/path',  'accessor: directory' );
isa_ok( $i, 'Audio::MPD::Common::Item', 'directory inherits from item' );


#
# testing amc::item::playlist
$output = 'playlist: some_name
Last-Modified: 2006-12-13T19:53:50Z
';
@output = split /\n/, $output;
%params = map { /^([^:]+):\s+(.*)$/ ? ($1=>$2) : () } @output;
$i = Audio::MPD::Common::Item->new( %params );
isa_ok( $i, 'Audio::MPD::Common::Item::Playlist', 'playlist creation' );
is( $i->playlist, 'some_name',  'accessor: playlist' );
is( $i->last_modified, '2006-12-13T19:53:50Z',  'accessor: last_modified' );
isa_ok( $i, 'Audio::MPD::Common::Item', 'playlistinherits from item' );

exit;
