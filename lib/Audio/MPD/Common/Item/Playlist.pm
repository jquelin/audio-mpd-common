use strict;
use warnings;

package Audio::MPD::Common::Item::Playlist;
# ABSTRACT: a playlist object

use base qw[ Class::Accessor::Fast Audio::MPD::Common::Item ];
__PACKAGE__->mk_accessors( qw[ last_modified playlist ] );

1;
__END__

=head1 SYNOPSIS

    print $item->playlist . "\n";


=head1 DESCRIPTION

C<Audio::MPD::Common::Item::Playlist> is more a placeholder for a hash ref
with one pre-defined key, namely the playlist name.


=head1 PUBLIC METHODS

This module only has a C<new()> constructor, which should only be called by
C<Audio::MPD::Common::Item>'s constructor.

The only other public method is an accessor: playlist().

