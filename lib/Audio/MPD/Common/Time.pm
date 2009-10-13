use strict;
use warnings;

package Audio::MPD::Common::Time;
# ABSTRACT: class representing time of current song

use Moose 0.92; # need hash trait


# -- attributes

=attr $time->time;

The time passed to the constructor, used to compute all others values
(see methods). It is the time value (on the "time" line) of what the MPD
server returns to the status command. Defaults to C<0:0>.

=cut

has time => ( is=>'ro', isa=>'Str', default=>'0:0' );



=method my $str = $time->sofar;

Return elapsed C<$time> (C<minutes:seconds> format).

=method my $str = $time->left;

Return remaining C<$time> (C<minutes:seconds> format).

=method my $str = $time->left;

Return total C<$time> (C<minutes:seconds> format).

=method my $percent = $time->percent;

Return elapsed C<$time> (percentage, 1 digit).

=method my $secs = $time->seconds_sofar;

Return elapsed C<$time> in seconds.

=method my $secs = $time->seconds_left;

Return remaining C<$time> in seconds.

=method my $secs = $time->seconds_total;

Return total C<$time> in seconds.

=method my $mins = $time->sofar_mins;

Return minutes part of elapsed C<$time>.

=method my $secs = $time->sofar_secs;

Return seconds part of elapsed C<$time>.

=method my $mins = $time->left_mins;

Return minutes part of remaining C<$time>.

=method my $secs = $time->left_secs;

Return seconds part of remaining C<$time>.

=method my $mins = $time->total_mins;

Return minutes part of total C<$time>.

=method my $mins = $time->total_secs;

Return seconds part of total C<$time>.

=cut

# _cooked_values contains all the computed values.
has _cooked_values => (
      traits     => [ 'Hash' ],
      is         => 'ro',
      isa        => 'HashRef',
      lazy_build => 1,
      handles    => {
          percent       => [ get => 'percent'       ],
          sofar         => [ get => 'sofar'         ],
          left          => [ get => 'left'          ],
          total         => [ get => 'total'         ],
          sofar_secs    => [ get => 'sofar_secs'    ],
          sofar_mins    => [ get => 'sofar_mins'    ],
          seconds_sofar => [ get => 'seconds_sofar' ],
          total_secs    => [ get => 'total_secs'    ],
          total_mins    => [ get => 'total_mins'    ],
          seconds_total => [ get => 'seconds_total' ],
          left_secs     => [ get => 'left_secs'     ],
          left_mins     => [ get => 'left_mins'     ],
          seconds_left  => [ get => 'seconds_left'  ],
      },
);

# -- builders

sub _build__cooked_values {
    my $self = shift;
    my $time = $self->time;

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


    return {
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
}


1;
__END__


=head1 DESCRIPTION

L<Audio::MPD::Common::Status> returns some time information with the
C<time()> accessor. This information relates to the elapsed time of the
current song, as well as the remaining and total time. This information
is encapsulated in an L<Audio::MPD::Common::Time> object.

An L<Audio::MPD::Common::Time> object does B<not> update itself
regularly, and thus should be used immediately.

Note: one should B<never> ever instantiate an L<Audio::MPD::Common::Time>
object directly - use the mpd modules instead.

