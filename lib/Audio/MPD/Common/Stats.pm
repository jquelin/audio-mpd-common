use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Stats;
# ABSTRACT: class representing MPD stats

use Moose;
use MooseX::Has::Sugar;
use MooseX::Types::Moose qw{ Int };


# -- public attributes

=attr $stats->artists;

Number of artists in the music database.

=attr $stats->albums;

Number of albums in the music database.

=attr $stats->songs;

Number of songs in the music database.

=attr $stats->uptime;

Daemon uptime (time since last startup) in seconds.

=attr $stats->playtime;

Time length of music played.

=attr $stats->db_playtime;

Sum of all song times in the music database.

=attr $stats->db_update;

Last database update in UNIX time.

=cut

has artists     => ( ro, isa=>Int, required );
has albums      => ( ro, isa=>Int, required );
has songs       => ( ro, isa=>Int, required );
has uptime      => ( ro, isa=>Int, required );
has playtime    => ( ro, isa=>Int, required );
has db_playtime => ( ro, isa=>Int, required );
has db_update   => ( ro, isa=>Int, required );


1;
__END__

=head1 DESCRIPTION

The MPD server maintains some general information. Those information can
be queried with the mpd modules. Some of those information are served to
you as an L<Audio::MPD::Common::Stats> object.

An L<Audio::MPD::Common::Stats> object does B<not> update itself
regularly, and thus should be used immediately.

Note: one should B<never> ever instantiate an L<Audio::MPD::Common::Stats>
object directly - use the mpd modules instead.
