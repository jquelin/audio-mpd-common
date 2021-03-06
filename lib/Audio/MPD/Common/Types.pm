use 5.008;
use warnings;
use strict;

package Audio::MPD::Common::Types;
# ABSTRACT: types used in the distribution

use Moose::Util::TypeConstraints;

use Audio::MPD::Common::Time;

enum 'State' => [ qw{ play stop pause } ];

coerce 'Audio::MPD::Common::Time'
    => from 'Str'
    => via { Audio::MPD::Common::Time->new(time=>$_) };

1;
__END__

=head1 DESCRIPTION

This module implements the specific types used by the distribution, and
exports them (exporting is done by L<Moose::Util::TypeConstraints>).

Current types defined:

=over 4

=item * State - a simple enumeration, allowing C<play>, C<stop>
and C<pause>.

=back

It also defines a type coertion from C<Str> to C<Audio::MPD::Common::Time>.
