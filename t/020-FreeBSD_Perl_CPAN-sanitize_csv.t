#
#  Author: Otavio Fernandes <otaviof@gmail.com>
# Created: 04/26/2010 00:08:04
#

use strict;
use warnings;

use Test::More tests => 8;

use File::Slurp;
use FreeBSD::Perl::CPAN;

sub search_for_dirty_csv_lines {
    my (@csv_lines) = @_;
    return grep( !/^(\S+\w+\S+,\S+\w+\S+,\S+\w+\S+|)$/, @csv_lines );
}

my $cpan         = new FreeBSD::Perl::CPAN();
my $csv_file     = $cpan->fetch_ratings();
my @csv_contents = read_file($csv_file);
my $initial_size = $#csv_contents;

ok( $initial_size > 100, "Should Pass, this array contains CSV's lines." );

ok( !$cpan->sanitize_csv( "/var/tmp/" . rand( 10**10 ) . ".txt" ),
    "Should Fail, file parameter must exists." );
ok( $cpan->sanitize_csv($csv_file),
    "Should Pass, with an valid CSV file path." );

ok( search_for_dirty_csv_lines(@csv_contents),
    "Should Pass, This CSV file is dirty!"
);

my $csv_file_new = $cpan->sanitize_csv($csv_file);

ok( $csv_file eq $csv_file_new, "Should Pass, method must replace file" );

undef @csv_contents;

#
# Sanitized CSV
#

$cpan->clear_sanitize;

my @csv_contents_new = read_file($csv_file_new);
my $final_size       = $#csv_contents_new;

cmp_ok( $final_size,   '>', 0 );
cmp_ok( $initial_size, '>', $final_size );

ok( !search_for_dirty_csv_lines(@csv_contents),
    "Should Fail, This CSV file isnt dirty anymore"
);

#
# Clean-Up
#

unlink( $csv_file, $csv_file_new );

__END__
