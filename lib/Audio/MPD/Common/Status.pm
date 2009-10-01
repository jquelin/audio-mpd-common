use strict;
use warnings;

package Audio::MPD::Common::Status;
# ABSTRACT: class representing MPD status

use Moose;
use Moose::Util::TypeConstraints;
use Audio::MPD::Common::Time;

subtype 'Int_0_100'
      => as 'Int'
      => where { $_ >= 0 && $_ <= 100 }
      => message { "$_ is not between 0 and 100" };
enum 'State' => qw{ play stop pause };
coerce 'Audio::MPD::Common::Time'
    => from 'Str'
    => via { Audio::MPD::Common::Time->new($_) };

has audio          => ( is=>'ro', required=>1, isa=>'Str' );
has bitrate        => ( is=>'ro', required=>1, isa=>'Int' );
has error          => ( is=>'ro', required=>0, isa=>'Str' );
has playlist       => ( is=>'ro', required=>1, isa=>'Int' );
has playlistlength => ( is=>'ro', required=>1, isa=>'Int' );
has random         => ( is=>'ro', required=>1, isa=>'Bool' );
has repeat         => ( is=>'ro', required=>1, isa=>'Bool' );
has songid         => ( is=>'ro', required=>1, isa=>'Int' );
has song           => ( is=>'ro', required=>1, isa=>'Int' );
has state          => ( is=>'ro', required=>1, isa=>'State' );
has time           => ( is=>'ro', required=>1, isa=>'Audio::MPD::Common::Time', coerce=>1 );
has updating_db    => ( is=>'ro', required=>1, isa=>'Int' );
has volume         => ( is=>'ro', required=>1, isa=>'Int_0_100' );
has xfade          => ( is=>'ro', required=>1, isa=>'Int' );

1;
__END__

=head1 SYNOPSIS

    print $status->bitrate;


=head1 DESCRIPTION

The MPD server maintains some information on its current state. Those
information can be queried with mpd modules. Some of those information
are served to you as an L<Audio::MPD::Common::Status> object.

Note that an L<Audio::MPD::Common::Status> object does B<not> update
itself regularly, and thus should be used immediately.


=head1 METHODS

=head2 Constructor

=over 4

=item new( \%kv )

The C<new()> method is the constructor for the
L<Audio::MPD::Common::Status> class. C<%kv> is a cooked output of what
MPD server returns to the status command.

Note: one should B<never> ever instantiate an L<Audio::MPD::Common::Status>
object directly - use the mpd modules instead.

=back


=head2 Accessors

Once created, one can access to the following members of the object:

=over 4

=item $status->audio()

A string with the sample rate of the song currently playing, number of bits
of the output and number of channels (2 for stereo) - separated by a colon.


=item $status->bitrate()

The instantaneous bitrate in kbps.


=item $status->error()

May appear in special error cases, such as when disabling output.


=item $status->playlist()

The playlist version number, that changes every time the playlist is updated.


=item $status->playlistlength()

The number of songs in the playlist.


=item $status->random()

Whether the playlist is read randomly or not.


=item $status->repeat()

Whether the song is repeated or not.


=item $status->song()

The offset of the song currently played in the playlist.


=item $status->songid()

The song id (MPD id) of the song currently played.


=item $status->state()

The state of MPD server. Either C<play>, C<stop> or C<pause>.


=item $status->time()

An L<Audio::MPD::Common::Time> object, representing the time elapsed /
remainging and total. See the associated pod for more details.


=item $status->updating_db()

An integer, representing the current update job.


=item $status->volume()

The current MPD volume - an integer between 0 and 100.


=item $status->xfade()

The crossfade in seconds.


=back

Please note that those accessors are read-only: changing a value will B<not>
change the current settings of MPD server. Use the mpd modules to alter the
settings.
