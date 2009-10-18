use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Item;
# ABSTRACT: a generic collection item

use Audio::MPD::Common::Item::Directory;
use Audio::MPD::Common::Item::Playlist;
use Audio::MPD::Common::Item::Song;


# -- constructor

=method my $item = Audio::MPD::Common::Item->new( %params );

Create and return either an L<Audio::MPD::Common::Item::Song>, an
L<Audio::MPD::Common::Item::Directory> or an L<Audio::MPD::Common::Playlist>
object, depending on the existence of a key C<file>, C<directory> or
C<playlist> (respectively).

=cut

sub new {
    my ($pkg, %params) = @_;

    # transform keys in lowercase, remove dashes "-"
    my %lowcase;
    @lowcase{ map { s/-/_/; lc } keys %params } = values %params;

    return Audio::MPD::Common::Item::Song->new(\%lowcase)      if exists $params{file};
    return Audio::MPD::Common::Item::Directory->new(\%lowcase) if exists $params{directory};
    return Audio::MPD::Common::Item::Playlist->new(\%lowcase)  if exists $params{playlist};
}

1;
__END__

=head1 SYNOPSIS

    my $item = Audio::MPD::Common::Item->new( %params );


=head1 DESCRIPTION

L<Audio::MPD::Common::Item> is a virtual class representing a generic
item of mpd's collection. It can be either a song, a directory or a playlist.

Depending on the params given to C<new>, it will create and return an
L<Audio::MPD::Common::Item::Song>, an L<Audio::MPD::Common::Item::Directory>
or an L<Audio::MPD::Common::Playlist> object. Currently, the
discrimination is done on the existence of the C<file> key of C<%params>.
