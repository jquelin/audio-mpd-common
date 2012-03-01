#
# This file is part of Audio-MPD-Common
#
# This software is copyright (c) 2007 by Jerome Quelin.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Item::Song;
{
  $Audio::MPD::Common::Item::Song::VERSION = '1.120610';
}
# ABSTRACT: a song object with some audio tags

use Moose;
use MooseX::Has::Sugar;
use MooseX::Types::Moose qw{ Int Str };
use Readonly;

use base qw{ Audio::MPD::Common::Item };
use overload '""' => \&as_string;

Readonly my $SEP => ' = ';


# -- public attributes


has album  => ( rw, isa=>Str );
has artist => ( rw, isa=>Str );
has date   => ( rw, isa=>Str );
has disc   => ( rw, isa=>Str );
has file   => ( rw, isa=>Str, required );
has genre  => ( rw, isa=>Str );
has last_modified => ( rw, isa=>Str );
has id     => ( rw, isa=>Int );
has name   => ( rw, isa=>Str );
has pos    => ( rw, isa=>Int );
has title  => ( rw, isa=>Str );
has track  => ( rw, isa=>Str );
has time   => ( rw, isa=>Int );


# -- public methods


sub as_string {
    my ($self) = @_;

    return $self->file unless defined $self->title;
    my $str = $self->title;
    return $str unless defined $self->artist;
    $str = $self->artist . $SEP . $str;
    return $str unless defined $self->album && defined $self->track;
    return join $SEP,
        $self->album,
        $self->track,
        $str;
}

1;


=pod

=head1 NAME

Audio::MPD::Common::Item::Song - a song object with some audio tags

=head1 VERSION

version 1.120610

=head1 DESCRIPTION

L<Audio::MPD::Common::Item::Song> is more a placeholder with some
attributes. Those attributes are taken from the song tags, so some of
them can be empty depending on the file.

The constructor should only be called by L<Audio::MPD::Common::Item>'s
constructor.

=head1 ATTRIBUTES

=head2 $song->album;

Album of the song.

=head2 $song->artist;

Artist of the song.

=head2 $song->date;

Last modification date of the song.

=head2 $song->disc;

Disc number of the album. This is a string to allow tags such as C<1/2>.

=head2 $song->file;

Path to the song. Only attribute which will always be defined.

=head2 $song->genre;

Genre of the song.

=head2 $song->id;

Id of the song in MPD's database.

=head2 $song->last_modified;

Last time the song was modified.

=head2 $song->name;

Name of the song (for http streams).

=head2 $song->pos;

Position of the song in the playlist.

=head2 $song->title;

Title of the song.

=head2 $song->track;

Track number of the song.

=head2 $song->time;

Length of the song in seconds.

=head1 METHODS

=head2 my $str = $song->as_string;

Return a string representing $song. This string will be:

=over 4

=item either "album = track = artist = title"

=item or "artist = title"

=item or "title"

=item or "file"

=back

(in this order), depending on the existing tags of the song. The last
possibility always exist of course, since it's a path.

This method is also used to automatically stringify the C<$song>.

=head1 AUTHOR

Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2007 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

