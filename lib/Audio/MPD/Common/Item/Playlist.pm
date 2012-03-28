#
# This file is part of Audio-MPD-Common
#
# This software is copyright (c) 2007 by Jerome Quelin.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
use 5.008;
use strict;
use warnings;

package Audio::MPD::Common::Item::Playlist;
{
  $Audio::MPD::Common::Item::Playlist::VERSION = '1.120881';
}
# ABSTRACT: a playlist object

use Moose;
use MooseX::Has::Sugar;
use MooseX::Types::Moose qw{ Str };

use base qw{ Audio::MPD::Common::Item };


# -- public attributes


has last_modified => ( rw, isa=>Str );
has playlist      => ( rw, isa=>Str, required );

1;


=pod

=head1 NAME

Audio::MPD::Common::Item::Playlist - a playlist object

=head1 VERSION

version 1.120881

=head1 DESCRIPTION

L<Audio::MPD::Common::Item::Playlist> is more a placeholder with some
attributes.

The constructor should only be called by L<Audio::MPD::Common::Item>'s
constructor.

=head1 ATTRIBUTES

=head2 $item->last_modified;

Last modification date.

=head2 $item->playlist;

Path to the playlist file.

=head1 AUTHOR

Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2007 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

