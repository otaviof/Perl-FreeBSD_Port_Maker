package FreeBSD::Port::INDEX;

#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 04/27/2010 00:34:57
#

use strict;
use warnings;

use File::Glob ':globally';
use Moose;

has 'file' => (
    is      => 'rw',
    isa     => 'Str',
    default => sub {
        my @indexes = </usr/ports/INDEX-?>;
        die "Couldn't find an INDEX file."
            if ( !@indexes );
        return $indexes[$#indexes];
    },
);

1;

__END__
