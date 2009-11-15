use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Item::Playlist;
# ABSTRACT: a playlist object

use Moose;
use MooseX::Has::Sugar;
use MooseX::Types::Moose qw{ Str };

use base qw{ Audio::MPD::Common::Item };


# -- public attributes

=attr $item->last_modified;

Last modification date.

=attr $item->playlist;

Path to the playlist file.

=cut

has last_modified => ( rw, isa=>Str );
has playlist      => ( rw, isa=>Str, required );

1;
__END__

=head1 DESCRIPTION

L<Audio::MPD::Common::Item::Playlist> is more a placeholder with some
attributes.

The constructor should only be called by L<Audio::MPD::Common::Item>'s
constructor.

