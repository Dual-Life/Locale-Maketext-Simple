use strict;
use warnings;

my %META = (
  name => 'Locale-Maketext-Simple',
  license => 'mit',
  author => [ 'Audrey Tang <cpan AT audreyt DOT org>' ],
  prereqs => {
    configure => { requires => {
      'ExtUtils::MakeMaker' => 0,
    } },
    build => { requires => {
    } },
    test => {
      requires => {
        'Test::More' => 0,
      },
    },
    runtime => {
      requires => {
      },
    },
  },
  resources => {
    repository => {
      url => 'https://github.com/Dual-Life/Locale-Maketext-Simple.git',
      web => 'https://github.com/Dual-Life/Locale-Maketext-Simple',
      type => 'git',
    },
    bugtracker => {
      web => 'https://rt.cpan.org/Public/Dist/Display.html?Name=Locale-Maketext-Simple',
      mailto => 'bug-Locale-Maketext-Simple@rt.cpan.org',
    },
    license => [ 'https://opensource.org/licenses/MIT' ],
  },
  no_index => {
    directory => [ 't', 'xt' ]
  },
);

my %MM_ARGS = (
  INSTALLDIRS => ("$]" >= 5.010 && "$]" < 5.011 ? 'perl' : 'site'),
);

## BOILERPLATE ###############################################################
require ExtUtils::MakeMaker;

# have to do this since old EUMM dev releases miss the eval $VERSION line
my $eumm_version  = eval $ExtUtils::MakeMaker::VERSION;
my $mymeta        = $eumm_version >= 6.57_02;
my $mymeta_broken = $mymeta && $eumm_version < 6.57_07;

$MM_ARGS{DISTNAME} = $META{name};
($MM_ARGS{NAME} = $META{name}) =~ s/-/::/g
  if !$MM_ARGS{NAME};
($MM_ARGS{VERSION_FROM} = "lib/$MM_ARGS{NAME}.pm") =~ s{::}{/}g;
$MM_ARGS{ABSTRACT_FROM} ||= $MM_ARGS{VERSION_FROM}
  unless $MM_ARGS{ABSTRACT};
$META{license} = [ $META{license} ]
  if $META{license} && !ref $META{license};
$MM_ARGS{LICENSE} = $META{license}[0]
  if $META{license} && $eumm_version >= 6.30;
$MM_ARGS{NO_MYMETA} = 1
  if $mymeta_broken;
$MM_ARGS{META_ADD} = { 'meta-spec' => { version => 2 }, %META }
  unless -f 'META.yml';
$MM_ARGS{dist}{TARFLAGS} ||= '-c -v --format=ustar -f';

for (qw(configure build test runtime)) {
  my $key = $_ eq 'runtime' ? 'PREREQ_PM' : uc $_.'_REQUIRES';
  my $r = $MM_ARGS{$key} = {
    %{$META{prereqs}{$_}{requires} || {}},
    %{delete $MM_ARGS{$key} || {}},
  };
  defined $r->{$_} or delete $r->{$_} for keys %$r;
}

$MM_ARGS{MIN_PERL_VERSION} = delete $MM_ARGS{PREREQ_PM}{perl} || 0;

delete $MM_ARGS{MIN_PERL_VERSION}
  if $eumm_version < 6.47_01;
$MM_ARGS{BUILD_REQUIRES} = {%{$MM_ARGS{BUILD_REQUIRES}}, %{delete $MM_ARGS{TEST_REQUIRES}}}
  if $eumm_version < 6.63_03;
$MM_ARGS{PREREQ_PM} = {%{$MM_ARGS{PREREQ_PM}}, %{delete $MM_ARGS{BUILD_REQUIRES}}}
  if $eumm_version < 6.55_01;
delete $MM_ARGS{CONFIGURE_REQUIRES}
  if $eumm_version < 6.51_03;

ExtUtils::MakeMaker::WriteMakefile(%MM_ARGS);
## END BOILERPLATE ###########################################################
