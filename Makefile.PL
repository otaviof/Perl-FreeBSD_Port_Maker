use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(

    # ABSTRACT_FROM => 'lib/FreeBSD/Port/Maker.pm',

    NAME         => 'FreeBSD::Port::Maker',
    AUTHOR       => 'Otavio Fernandes <otaviof@gmail.com>',
    VERSION_FROM => 'lib/FreeBSD/Port/Maker.pm',
    EXE_FILES    => [ 'bin/perl_port_maker.pl', ],
    PREREQ_PM    => {
        'File::Glob'   => 0,
        'File::Slurp'  => 9999.13,
        'Git::Wrapper' => 0.006,
        'LWP::Simple'  => 5.827,
        'Moose'        => 1.01,
        'Test::More'   => 0.94,
    },

    ( $ExtUtils::MakeMaker::VERSION >= 6.3002
        ? ( 'LICENSE' => 'bsd' )
        : () ),

    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'FreeBSD-Port-Maker-*' },

);

# --
# Writing 'Changes' file from Git
# --

use Git::Wrapper;

my $git = new Git::Wrapper( $ENV{PWD} );

unlink 'Changes' if ( -f 'Changes' );

open( my $CHG, '>', 'Changes' ) or die $!;
foreach my $log ( $git->log ) {
    print $CHG "commit: ", $log->id, "\n";
    print $CHG "Author: ", $log->attr->{date},   "\n";
    print $CHG "  Date: ", $log->attr->{author}, "\n\n";
    print $CHG "\t", $log->message, "\n\n";
}
close($CHG);

