use strict;
use warnings;

package Audio::MPD::Common;
# ABSTRACT: common helper classes for mpd

1;
__END__

=head1 DESCRIPTION

Depending on whether you're using a POE-aware environment or not, people
wanting to tinker with mpd (Music Player Daemon) will use either
L<POE::Component::Client::MPD> or L<Audio::MPD>.

But even if the run-cores of those two modules differ completely, they
are using the exact same common classes to represent the various mpd
states and information.

Therefore, those common classes have been outsourced to
L<Audio::MPD::Common>.

This module does not export any methods, but the dist provides the
following classes that you can query with perldoc:

=over 4

=item o L<Audio::MPD::Common::Item>

=item o L<Audio::MPD::Common::Item::Directory>

=item o L<Audio::MPD::Common::Item::Playlist>

=item o L<Audio::MPD::Common::Item::Song>

=item o L<Audio::MPD::Common::Stats>

=item o L<Audio::MPD::Common::Status>

=item o L<Audio::MPD::Common::Time>

=back


Note that those modules should not be of any use outside the two mpd
modules afore-mentioned.


=head1 SEE ALSO

=over 4

=item L<Audio::MPD>

=item L<POE::Component::Client::MPD>

=back

