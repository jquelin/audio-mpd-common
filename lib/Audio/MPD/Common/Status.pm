use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Status;
# ABSTRACT: class representing MPD status

use Moose;
use MooseX::Has::Sugar;
use MooseX::Types::Moose qw{ Bool Int Str };

use Audio::MPD::Common::Time;
use Audio::MPD::Common::Types;


# -- public attributes

=attr $status->audio;

A string with the sample rate of the song currently playing, number of
bits of the output and number of channels (2 for stereo) - separated
by a colon.

=attr $status->bitrate;

The instantaneous bitrate in kbps.

=attr $status->error;

May appear in special error cases, such as when disabling output.

=attr $status->playlist;

The playlist version number, that changes every time the playlist
is updated.

=attr $status->playlistlength;

The number of songs in the playlist.

=attr $status->random;

Whether the playlist is read randomly or not.

=attr $status->repeat;

Whether the song is repeated or not.

=attr $status->song;

The offset of the song currently played in the playlist.

=attr $status->songid;

The song id (MPD id) of the song currently played.

=attr $status->state;

The state of MPD server. Either C<play>, C<stop> or C<pause>.

=attr $status->time;

An L<Audio::MPD::Common::Time> object, representing the time elapsed /
remainging and total. See the associated pod for more details.

=attr $status->updating_db;

An integer, representing the current update job.

=attr $status->volume;

The current MPD volume - an integer between 0 and 100.

=attr $status->xfade;

The crossfade in seconds.

=cut

has audio          => ( ro, isa=>Str  );
has bitrate        => ( ro, isa=>Int  );
has error          => ( ro, isa=>Str  );
has playlist       => ( ro, isa=>Int  );
has playlistlength => ( ro, isa=>Int  );
has random         => ( ro, isa=>Bool );
has repeat         => ( ro, isa=>Bool );
has songid         => ( ro, isa=>Int  );
has song           => ( ro, isa=>Int  );
has state          => ( ro, isa=>'State' );
has time           => ( ro, isa=>'Audio::MPD::Common::Time', coerce );
has updating_db    => ( ro, isa=>Int  );
has volume         => ( ro, isa=>Int  );
has xfade          => ( ro, isa=>Int, default=>0 );


1;
__END__

=head1 DESCRIPTION

The MPD server maintains some information on its current state. Those
information can be queried with mpd modules. Some of those information
are served to you as an L<Audio::MPD::Common::Status> object.

An L<Audio::MPD::Common::Status> object does B<not> update itself
regularly, and thus should be used immediately.

Note: one should B<never> ever instantiate an L<Audio::MPD::Common::Status>
object directly - use the mpd modules instead.
