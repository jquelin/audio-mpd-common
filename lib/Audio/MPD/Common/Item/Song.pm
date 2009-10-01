use strict;
use warnings;

package Audio::MPD::Common::Item::Song;
# ABSTRACT: a song object with some audio tags

use overload '""' => \&as_string;
use Readonly;

use base qw[ Class::Accessor::Fast Audio::MPD::Common::Item ];
__PACKAGE__->mk_accessors( qw[ album artist date file genre id pos title track time ] );


Readonly my $SEP => ' = ';


#
# my $str = $song->as_string;
#
# Return a string representing $song. This string will be;
#  - either "album = track = artist = title"
#  - or     "artist = title"
#  - or     "title"
#  - or     "file"
# (in this order), depending on the existing tags of the song. The last
# possibility always exist of course, since it's a path.
#
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

L<Audio::MPD::Common::Item::Song> is more a placeholder for a
hash ref with some pre-defined keys, namely some audio tags.


=head1 PUBLIC METHODS

This module has a C<new()> constructor, which should only be called by
L<Audio::MPD::Common::Item>'s constructor.

The only other public methods are the accessors - see below.


=head2 Accessors

The following methods are the accessors to their respective named
fields: C<album()>, C<artist()>, C<dat()>, C<file()>, C<genre()>, C<id>,
C<pos>, C<title()>, C<track()>, C<time()>. You can call them either with
no arg to get the value, or with an arg to replace the current value.


=head2 Methods


=over 4

=item $song->as_string()

Return a string representing $song. This string will be:

=over 4

=item either "album = track = artist = title"

=item or "artist = title"

=item or "title"

=item or "file"

=back

(in this order), depending on the existing tags of the song. The last
possibility always exist of course, since it's a path.

=back

