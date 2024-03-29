
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'A simple client to TGC\'s web services.',
  'AUTHOR' => 'JT Smith <jt@plainblack.com>',
  'BUILD_REQUIRES' => {},
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  'DISTNAME' => 'TheGameCrafter-Client',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'TheGameCrafter::Client',
  'PREREQ_PM' => {
    'HTTP::Request::Common' => '0',
    'JSON' => '0',
    'LWP::UserAgent' => '6.04',
    'Ouch' => '0.0400',
    'Test::Deep' => '0',
    'Test::More' => '0',
    'URI' => '0'
  },
  'VERSION' => '0.0103',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



