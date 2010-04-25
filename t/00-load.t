#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'FreeBSD::Port::Maker' );
}

diag( "Testing FreeBSD::Port::Maker $FreeBSD::Port::Maker::VERSION, Perl $], $^X" );
