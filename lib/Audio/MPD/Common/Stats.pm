use strict;
use warnings;

package Audio::MPD::Common::Stats;
# ABSTRACT: class representing MPD stats

use Moose;

# -- attributes

=attr $stats->artists()

Number of artists in the music database.

=attr $stats->albums()

Number of albums in the music database.

=attr $stats->songs()

Number of songs in the music database.

=attr $stats->uptime()

Daemon uptime (time since last startup) in seconds.

=attr $stats->playtime()

Time length of music played.

=attr $stats->db_playtime()

Sum of all song times in the music database.

=attr $stats->db_update()

Last database update in UNIX time.

=cut

has artists     => ( is=>'ro', isa=>'Int', required=>1 );
has albums      => ( is=>'ro', isa=>'Int', required=>1 );
has songs       => ( is=>'ro', isa=>'Int', required=>1 );
has uptime      => ( is=>'ro', isa=>'Int', required=>1 );
has playtime    => ( is=>'ro', isa=>'Int', required=>1 );
has db_playtime => ( is=>'ro', isa=>'Int', required=>1 );
has db_update   => ( is=>'ro', isa=>'Int', required=>1 );


# -- constructor

=method my $stats = Audio::MPD::Common::Stats->new( %params );

The C<new()> method is the constructor for the L<Audio::MPD::Common::Stats>
class.

Note: one should B<never> ever instantiate an L<Audio::MPD::Common::Stats>
object directly - use the mpd modules instead.

=cut

1;
__END__

=head1 DESCRIPTION

The MPD server maintains some general information. Those information can be
queried with the mpd modules. Some of those information are served to you as
an L<Audio::MPD::Common::Status> object.

Note that an L<Audio::MPD::Common::Stats> object does B<not> update itself
regularly, and thus should be used immediately.
