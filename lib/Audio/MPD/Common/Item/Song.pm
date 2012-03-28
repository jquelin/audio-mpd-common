use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Item::Song;
# ABSTRACT: a song object with some audio tags

use Moose;
use MooseX::Has::Sugar;
use MooseX::Types::Moose qw{ Int Str };
use Readonly;
use String::Formatter method_stringf => {
    -as => '_stringf',
    codes => {
        A => sub { $_[0]->albumartist },
        a => sub { $_[0]->artist },
        C => sub { $_[0]->composer },
        D => sub { $_[0]->disc },
        d => sub { $_[0]->album },
        f => sub { $_[0]->file },
        g => sub { $_[0]->genre },
        i => sub { $_[0]->id },
        l => sub { $_[0]->time },
        M => sub { $_[0]->date },
        m => sub { $_[0]->last_modified },
        N => sub { $_[0]->name },
        n => sub { $_[0]->track },
        P => sub { $_[0]->performer },
        p => sub { $_[0]->pos },
        t => sub { $_[0]->title },
    },
};

use base qw{ Audio::MPD::Common::Item };
use overload '""' => \&as_string;

Readonly my $SEP => ' = ';


# -- public attributes

=attr album

Album of the song. (format code: %d)

=attr artist

Artist of the song. (format code: %a)

=attr albumartist

Artist of the album. (format code: %A)

=attr composer

Song composer. (format code: %C)

=attr date

Last modification date of the song. (format code: %M)

=attr disc

Disc number of the album. This is a string to allow tags such as C<1/2>.
(format code: %D)

=attr file

Path to the song. Only attribute which will always be defined. (format
code: %f)

=attr genre

Genre of the song. (format code: %g)

=attr id

Id of the song in MPD's database. (format code: %i)

=attr last_modified

Last time the song was modified. (format code: %m)

=attr name

Name of the song (for http streams). (format code: %N)

=attr performer

Song performer. (format code: %P)

=attr pos

Position of the song in the playlist. (format code: %p)

=attr title

Title of the song. (format code: %t)

=attr track

Track number of the song. (format code: %n)

=attr time

Length of the song in seconds. (format code: %l)

=cut

has album  => ( rw, isa=>Str );
has albumartist => ( rw, isa=>Str );
has artist => ( rw, isa=>Str );
has composer => ( rw, isa=>Str );
has date   => ( rw, isa=>Str );
has disc   => ( rw, isa=>Str );
has file   => ( rw, isa=>Str, required );
has genre  => ( rw, isa=>Str );
has last_modified => ( rw, isa=>Str );
has id     => ( rw, isa=>Int );
has name   => ( rw, isa=>Str );
has pos    => ( rw, isa=>Int );
has performer => ( rw, isa=>Str );
has title  => ( rw, isa=>Str );
has track  => ( rw, isa=>Str );
has time   => ( rw, isa=>Int );


# -- public methods

=method as_string

    my $str = $song->as_string( [$format] );

Return a string representing $song. If C<$format> is specified, use it
to format the string. Otherwise, the string returned will be:

=over 4

=item either "album = track = artist = title"

=item or "artist = title"

=item or "title"

=item or "file"

=back

(in this order), depending on the existing tags of the song. The last
possibility always exist of course, since it's a path.

This method is also used to automatically stringify the C<$song>.

B<WARNING:> the format codes are not yet definitive and may be subject
to change!

=cut

sub as_string {
    my ($self, $format) = @_;

    return _stringf($format, $self) if $format;
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
