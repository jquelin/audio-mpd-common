use strict;
use warnings;

package Audio::MPD::Common::Item::Directory;
# ABSTRACT: a directory object

use base qw[ Class::Accessor::Fast Audio::MPD::Common::Item ];
__PACKAGE__->mk_accessors( qw[ directory ] );

1;
__END__

=head1 SYNOPSIS

    print $item->directory . "\n";


=head1 DESCRIPTION

C<Audio::MPD::Common::Item::Directory> is more a placeholder for a
hash ref with one pre-defined key, namely the directory name.


=head1 PUBLIC METHODS

This module only has a C<new()> constructor, which should only be called by
C<Audio::MPD::Common::Item>'s constructor.

The only other public method is an accessor: directory().

