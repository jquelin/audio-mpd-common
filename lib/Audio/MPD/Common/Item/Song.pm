use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Item::Song;
# ABSTRACT: a song object with some audio tags

use Moose;
use MooseX::Has::Sugar;
use MooseX::Types::Moose qw{ Int Str };
use Readonly;

use base qw{ Audio::MPD::Common::Item };
use overload '""' => \&as_string;

Readonly my $SEP => ' = ';


# -- public attributes

=attr $song->album;

Album of the song.

=attr $song->artist;

Artist of the song.

=attr $song->album_artist;

Artist of the album.

=attr $song->date;

Last modification date of the song.

=attr $song->disc;

Disc number of the album. This is a string to allow tags such as C<1/2>.

=attr $song->file;

Path to the song. Only attribute which will always be defined.

=attr $song->genre;

Genre of the song.

=attr $song->id;

Id of the song in MPD's database.

=attr $song->last_modified;

Last time the song was modified.

=attr $song->name;

Name of the song (for http streams).

=attr $song->pos;

Position of the song in the playlist.

=attr $song->title;

Title of the song.

=attr $song->track;

Track number of the song.

=attr $song->time;

Length of the song in seconds.

=cut

has album  => ( rw, isa=>Str );
has album_artist => ( rw, isa=>Str );
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

=method my $str = $song->as_string;

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

=cut

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
__END__

=head1 DESCRIPTION

L<Audio::MPD::Common::Item::Song> is more a placeholder with some
attributes. Those attributes are taken from the song tags, so some of
them can be empty depending on the file.

The constructor should only be called by L<Audio::MPD::Common::Item>'s
constructor.
