#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 04/25/2010 23:54:38
#

use strict;
use warnings;

use Test::More tests => 2;

use FreeBSD::Perl::CPAN;

my $cpan = new FreeBSD::Perl::CPAN()
    or die $!;

my $ratings_csv = $cpan->fetch_ratings();

ok( $ratings_csv,    "Should Pass, we must fetch ratings." );
ok( -f $ratings_csv, "Should Pass, ratings file must be save on FS." )

__END__
