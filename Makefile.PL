use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile1(
    MIN_PERL_VERSION => '5.008',
    META_MERGE => {
        resources => {
            repository => 'http://github.com/snark/html-laundry',
        },
    },
    #BUILD_REQUIRES => {
    #},

    NAME          => 'HTML::Laundry',
    AUTHOR        => 'Six Apart, Ltd. <scook@sixapart.com>',
    VERSION_FROM  => 'lib/HTML/Laundry.pm',
    ABSTRACT_FROM => 'lib/HTML/Laundry.pm',
    'LICENSE' => 'perl',
    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More'      => 0,
        'Test::Exception' => 0,
        'HTML::Entities'  => 0,
        'HTML::Parser'    => 0,
        'Scalar::Util'    => 0,
        'Switch'          => 0,
        'URI'             => 0,
        'URI::Escape'     => 0,
        'URI::Split'      => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'HTML-Laundry-*' },
);

sub WriteMakefile1 {  #Written by Alexandr Ciornii, version 0.21. Added by eumm-upgrade.
    my %params=@_;
    my $eumm_version=$ExtUtils::MakeMaker::VERSION;
    $eumm_version=eval $eumm_version;
    die "EXTRA_META is deprecated" if exists $params{EXTRA_META};
    die "License not specified" if not exists $params{LICENSE};
    if ($params{BUILD_REQUIRES} and $eumm_version < 6.5503) {
        #EUMM 6.5502 has problems with BUILD_REQUIRES
        $params{PREREQ_PM}={ %{$params{PREREQ_PM} || {}} , %{$params{BUILD_REQUIRES}} };
        delete $params{BUILD_REQUIRES};
    }
    delete $params{CONFIGURE_REQUIRES} if $eumm_version < 6.52;
    delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
    delete $params{META_MERGE} if $eumm_version < 6.46;
    delete $params{META_ADD} if $eumm_version < 6.46;
    delete $params{LICENSE} if $eumm_version < 6.31;
    delete $params{AUTHOR} if $] < 5.005;
    delete $params{ABSTRACT_FROM} if $] < 5.005;
    delete $params{BINARY_LOCATION} if $] < 5.005;

    WriteMakefile(%params);
}

