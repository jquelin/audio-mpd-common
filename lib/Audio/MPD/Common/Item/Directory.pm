use strict;
use warnings;

package Audio::MPD::Common::Item::Directory;
# ABSTRACT: a directory object

use Moose;

use base qw{ Audio::MPD::Common::Item };

# -- attributes

=attr $status->directory()

The path to the item's directory.

=cut

has directory => ( is=>'ro', isa=>'Str', required=>1 );

1;
__END__

=head1 DESCRIPTION

L<Audio::MPD::Common::Item::Directory> is more a placeholder for a
hash ref with one pre-defined key, namely the directory name.
