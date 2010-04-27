#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 04/27/2010 00:31:37
#

use strict;
use warnings;

use Test::More tests => 4;

BEGIN {
    use_ok('FreeBSD::Port::INDEX');
    use FreeBSD::Port::INDEX;
}

my $index = new_ok( 'FreeBSD::Port::INDEX', [ {} ] );

ok( $index->file,
    "Should Pass, constructor must provide an Port INDEX file." );
ok( -f $index->file, "Should Pass, file must exists." );

__END__
