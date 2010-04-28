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
        my @indx = </usr/ports/INDEX-?>;
        die "Couldn't find an INDEX file."
            if ( !@indx );
        return $indx[$#indx];
    },
);

sub create_hash {
    my ($self) = @_;
    my $indexes;
    open( my $IDX, '<', $self->file )
        or return;
    while ( my $line = <$IDX> ) {
        next if ( $line !~ /^(.*?)\|(\/.*?\w)\|.*?$/ );
        $indexes->{$2} = $1;
    }
    close($IDX);
    return $indexes;
}

1;

__END__
