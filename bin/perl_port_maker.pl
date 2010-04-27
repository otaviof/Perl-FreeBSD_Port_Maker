#!/usr/bin/env perl

#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 04/26/2010 12:47:03
#

use strict;
use warnings;

use FreeBSD::Perl::CPAN;
use Parse::CPAN::Ratings;

my $cpan = new FreeBSD::Perl::CPAN()
    or die $!;

my $ratings_csv = $cpan->fetch_ratings()
    or die "Cannot fetch CSV ratings file";

my $ratings = new Parse::CPAN::Ratings( filename => $ratings_csv )
    or die $!;

foreach my $r ( $ratings->ratings ) {
    next if ( $r->rating < 3 or $r->distribution =~ /win32/i );

    # sanitizing misspelled names with version
    $r->{distribution} =~ s/^(.*?)\-(\d+\.)+\d+$/$1/;

    # serch this on FreeBSD Ports!
}

unlink($ratings_csv);

__END__
