#!/usr/bin/env perl

#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 04/26/2010 12:47:03
#

use strict;
use warnings;

use English;
use FreeBSD::Perl::CPAN;
use FreeBSD::Port::INDEX;
use Parse::CPAN::Ratings;

BEGIN {
    die "Just FreeBSD is supported."
        if ( $OSNAME !~ /freebsd/i );
}

my $cpan = new FreeBSD::Perl::CPAN()
    or die $!;

my $ratings_csv = $cpan->fetch_ratings()
    or die "Cannot fetch CSV ratings file";

my $ratings = new Parse::CPAN::Ratings( filename => $ratings_csv )
    or die $!;

my $index = new FreeBSD::Port::INDEX()
    or die $!;

my $ports_index = $index->create_hash()
    or die "Cannot generate an hash from Port INDEX";

foreach my $r ( $ratings->ratings ) {
    next if ( $r->rating < 3 or $r->distribution =~ /win32/i );

    # sanitizing misspelled names with version
    $r->{distribution} =~ s/^(.*?)\-(\d+\.)+\d+$/$1/;

    # serch this on FreeBSD Ports!
    foreach my $k ( keys %{$ports_index} ) {
        print "New port: $r->{distribution}\n"
            if ( $ports_index->{$k} =~ /$r->{distribution}/i );
    }
}

unlink($ratings_csv);

__END__
