use strict;
use warnings;

package Audio::MPD::Common::Stats;
# ABSTRACT: class representing MPD stats

use base qw[ Class::Accessor::Fast ];
__PACKAGE__->mk_accessors
    ( qw[ artists albums songs uptime playtime db_playtime db_update ] );


1;
__END__

=head1 SYNOPSIS

    print $stats->artists;


=head1 DESCRIPTION

The MPD server maintains some general information. Those information can be
queried with the mpd modules. Some of those information are served to you as
an C<Audio::MPD::Common::Status> object.

Note that an C<Audio::MPD::Common::Stats> object does B<not> update itself
regularly, and thus should be used immediately.


=head1 METHODS

=head2 Constructor

=over 4

=item new( %kv )

The C<new()> method is the constructor for the C<Audio::MPD::Common::Stats>
class.

Note: one should B<never> ever instantiate an C<Audio::MPD::Common::Stats>
object directly - use the mpd modules instead.

=back


=head2 Accessors

Once created, one can access to the following members of the object:

=over 4

=item $stats->artists()

Number of artists in the music database.


=item $stats->albums()

Number of albums in the music database.


=item $stats->songs()

Number of songs in the music database.


=item $stats->uptime()

Daemon uptime (time since last startup) in seconds.


=item $stats->playtime()

Time length of music played.


=item $stats->db_playtime()

Sum of all song times in the music database.


=item $stats->db_update()

Last database update in UNIX time.


=back


Please note that those accessors are read-only: changing a value will B<not>
change the current settings of MPD server. Use the mpd modules to alter the
settings.

