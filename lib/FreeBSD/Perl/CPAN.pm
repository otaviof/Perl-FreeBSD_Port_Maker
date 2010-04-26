package FreeBSD::Perl::CPAN;

#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 04/25/2010 23:47:07
#

use strict;
use warnings;

use Moose;
use LWP::Simple;

has 'csv_url' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'http://cpanratings.perl.org/csv/all_ratings.csv',
);

has 'sanitize' => (
    is        => 'rw',
    isa       => 'Bool',
    default   => 1,
    clearer   => 'clear_sanitize',
    predicate => 'has_sanitize',
);

sub fetch_ratings {
    my ($self) = @_;
    my $csv = '/tmp/' . rand( 10**10 ) . '.csv.tmp';
    unlink($csv) if ( -f $csv );
    getstore( $self->csv_url, $csv )
        or return;
    return ( ( $self->has_sanitize ) ? $self->sanitize_csv($csv) : $csv );
}

sub sanitize_csv {
    my ( $self, $csv_path ) = @_;
    return 0 if ( !-f $csv_path );
    my $csv_temp = '/tmp/' . rand( 10**10 ) . '_csv.tmp';
    open( my $OLD, '<', $csv_path ) or return;
    open( my $NEW, '>', $csv_temp ) or return;
    while (<$OLD>) {
        chomp;
        next if ( !/^(\S+\w+\S+,\S+\w+\S+,\S+\w+\S+|)$/ );
        print $NEW $_, "\n";
    }
    close($NEW);
    close($OLD);
    return ( ( rename( $csv_temp, $csv_path ) ) ? $csv_path : '' );
}

1;

__END__
