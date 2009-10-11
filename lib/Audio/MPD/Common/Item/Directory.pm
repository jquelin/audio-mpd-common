use strict;
use warnings;

package Audio::MPD::Common::Item::Directory;
# ABSTRACT: a directory object

use Moose;

use base qw{ Audio::MPD::Common::Item };


# -- public attributes

=attr $item->directory;

The path to the item's directory.

=cut

has directory => ( is=>'rw', isa=>'Str', required=>1 );

1;
__END__

=head1 DESCRIPTION

L<Audio::MPD::Common::Item::Directory> is more a placeholder with some
attributes.

The constructor should only be called by L<Audio::MPD::Common::Item>'s
constructor.
