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

sub fetch_ratings {
    my ($self) = @_;
    my $csv = '/tmp/' . rand( 10**10 ) . '.csv.tmp';
    unlink($csv) if ( -f $csv );
    getstore( $self->csv_url, $csv )
        or return;
    return $csv;
}

1;

__END__
