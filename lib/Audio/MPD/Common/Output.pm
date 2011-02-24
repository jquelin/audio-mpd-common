use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Output;
# ABSTRACT: class representing MPD output

use Moose;
use MooseX::Has::Sugar;


# -- public attributes

=attr $output->id;

Internal MPD id for the output.

=attr $output->name;

Friendly-name for the output.

=attr $output->enabled;

Boolean stating whether the output is enabled or not.

=cut

has id          => ( ro, isa=>"Int",  required );
has name        => ( ro, isa=>"Str",  required );
has enabled     => ( ro, isa=>"Bool", required );


1;
__END__

=head1 DESCRIPTION

The MPD server can have various outputs defined, generally one per sound
card. Those output can be queried with the mpd modules. Some of those
information are served to you as an L<Audio::MPD::Common::Output>
object.

An L<Audio::MPD::Common::Output> object does B<not> update itself
regularly, and thus should be used immediately.

Note: one should B<never> ever instantiate an
L<Audio::MPD::Common::Output> object directly - use the mpd modules
instead.
