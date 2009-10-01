use strict;
use warnings;

package Audio::MPD::Common::Item::Playlist;
# ABSTRACT: a playlist object

use Moose;

use base qw{ Audio::MPD::Common::Item };


# -- attributes

=attr $item->last_modified()

Last modification date.

=attr $item->playlist()

Path to the playlist file.

=cut

has last_modified => ( is=>'ro', isa=>'Str', required=>0 );
has playlist      => ( is=>'ro', isa=>'Str', required=>1 );

1;
__END__

=head1 DESCRIPTION

L<Audio::MPD::Common::Item::Playlist> is more a placeholder with some
attributes.

The constructor should only be called by L<Audio::MPD::Common::Item>'s
constructor.

