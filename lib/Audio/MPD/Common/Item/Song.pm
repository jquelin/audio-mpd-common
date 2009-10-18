use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Item::Song;
# ABSTRACT: a song object with some audio tags

use Moose;
use Readonly;

use base qw{ Audio::MPD::Common::Item };
use overload '""' => \&as_string;

Readonly my $SEP => ' = ';


# -- public attributes

=attr $song->album;

Album of the song.

=attr $song->artist;

Artist of the song.

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

has album  => ( is=>'rw', isa=>'Str' );
has artist => ( is=>'rw', isa=>'Str' );
has date   => ( is=>'rw', isa=>'Int' );
has disc   => ( is=>'rw', isa=>'Str' );
has file   => ( is=>'rw', isa=>'Str', required=>1 );
has genre  => ( is=>'rw', isa=>'Str' );
has id     => ( is=>'rw', isa=>'Int' );
has name   => ( is=>'rw', isa=>'Str' );
has pos    => ( is=>'rw', isa=>'Int' );
has title  => ( is=>'rw', isa=>'Str' );
has track  => ( is=>'rw', isa=>'Str' );
has time   => ( is=>'rw', isa=>'Int' );


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
