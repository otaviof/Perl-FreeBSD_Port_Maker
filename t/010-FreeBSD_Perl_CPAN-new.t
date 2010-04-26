#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 04/25/2010 16:11:27
#

use strict;
use warnings;

use Test::More tests => 5;

BEGIN {
    use_ok('FreeBSD::Perl::CPAN');
    use FreeBSD::Perl::CPAN;
}

my $cpan = new_ok( 'FreeBSD::Perl::CPAN', [ {} ] );

ok( $cpan->has_sanitize, "Should Pass, we must start with sanitize flag." );
ok( $cpan->clear_sanitize,
    "Should Pass, we must be able to clean this flag." );
ok( !$cpan->has_sanitize, "Should Fail, this flag must be off." );

__END__
