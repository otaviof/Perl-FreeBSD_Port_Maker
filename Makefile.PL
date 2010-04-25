use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'FreeBSD::Port::Maker',
    AUTHOR              => 'Otavio Fernandes <otaviof@gmail.com>',
    VERSION_FROM        => 'lib/FreeBSD/Port/Maker.pm',
    ABSTRACT_FROM       => 'lib/FreeBSD/Port/Maker.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'bsd')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'FreeBSD-Port-Maker-*' },
);
