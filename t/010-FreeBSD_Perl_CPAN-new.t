#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 04/25/2010 16:11:27
#

use strict;
use warnings;

use Test::More tests => 2;

BEGIN {
    use_ok('FreeBSD::Perl::CPAN');
    use FreeBSD::Perl::CPAN;
}

my $cpan = new_ok( 'FreeBSD::Perl::CPAN', [ {} ] );

__END__
