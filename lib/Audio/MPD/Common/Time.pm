use strict;
use warnings;

package Audio::MPD::Common::Time;
# ABSTRACT: class representing time of current song

use base qw[ Class::Accessor::Fast ];
__PACKAGE__->mk_accessors
    ( qw[ percent sofar left total
          sofar_secs sofar_mins seconds_sofar
          total_secs total_mins seconds_total
          left_secs  left_mins  seconds_left
        ] );


#--
# Constructor

#
# my $status = Audio::MPD::Common::Time->new( $time )
#
# The constructor for the class Audio::MPD::Common::Time. $time is
# the time value (on the "time" line) of what the output MPD server
# returns to the status command.
#
sub new {
    my ($class, $time) = @_;
    $time ||= '0:0';
    my ($seconds_sofar, $seconds_total) = split /:/, $time;
    my $seconds_left = $seconds_total - $seconds_sofar;
    my $percent      = $seconds_total ? 100*$seconds_sofar/$seconds_total : 0;

    # Parse the time so far
    my $sofar_mins = int( $seconds_sofar / 60 );
    my $sofar_secs = $seconds_sofar % 60;
    my $sofar = sprintf "%d:%02d", $sofar_mins, $sofar_secs;

    # Parse the total time
    my $total_mins = int( $seconds_total / 60 );
    my $total_secs = $seconds_total % 60;
    my $total = sprintf "%d:%02d", $total_mins, $total_secs;

    # Parse the time left
    my $left_mins = int( $seconds_left / 60 );
    my $left_secs = $seconds_left % 60;
    my $left = sprintf "%d:%02d", $left_mins, $left_secs;


    # create object
    my $self = {
        # time elapsed in seconds
        seconds_sofar => $seconds_sofar,
        seconds_left  => $seconds_left,
        seconds_total => $seconds_total,

        # cooked values
        sofar      => $sofar,
        left       => $left,
        total      => $total,
        percent    => sprintf("%.1f", $percent), # 1 decimal

        # details
        sofar_secs => $sofar_secs,
        sofar_mins => $sofar_mins,
        total_secs => $total_secs,
        total_mins => $total_mins,
        left_secs  => $left_secs,
        left_mins  => $left_mins,
    };
    bless $self, $class;
    return $self;
}


1;
__END__

=head1 SYNOPSIS

    my $time = $status->time;
    print $time->sofar;


=head1 DESCRIPTION

L<Audio::MPD::Common::Status> returns some time information with the C<time()>
accessor. This information relates to the elapsed time of the current song,
as well as the remaining and total time. This information is encapsulated
in an L<Audio::MPD::Common::Time> object.

Note that an L<Audio::MPD::Common::Time> object does B<not> update itself
regularly, and thus should be used immediately.


=head1 METHODS

=head2 Constructor

=over 4

=item new( $time )

The C<new()> method is the constructor for the L<Audio::MPD::Common::Time>
class.

Note: one should B<never> ever instantiate an L<Audio::MPD::Common::Time>
object directly - use the mpd modules instead.

=back


=head2 Accessors

Once created, one can access the following members of the object:

=over 4

=item cooked values:

The C<sofar()>, C<left()> and C<total()> methods return the according values
under the form C<minutes:seconds>. Note the existence of a C<percent()>
method returning a percentage complete. (one decimal)


=item values in seconds:

The C<seconds_sofar()>, C<seconds_left()> and C<seconds_total()> return the
according values in seconds.


=item detailled values:

If you want to cook your own value, then the following methods can help:
C<sofar_secs()> and C<sofar_mins()> return the seconds and minutes elapsed.
Same for C<left_secs()> and C<left_mins()> (time remaining), C<total_secs()>
and C<total_mins()>. (total song length)


=back


Please note that those accessors are read-only: changing a value will B<not>
change the current settings of MPD server. Use the mpd modules to alter the
settings.

