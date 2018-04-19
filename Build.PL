use Module::Build;

sub ACTION_build {
  my $self = shift;
  $self->SUPER::ACTION_build;

  my @commands = ( 'autoreconf -fiv', './configure --prefix=`pwd`', 'make', 'make install', );

  for my $command (@commands) {
    if(system $command) {
      die "Failed to execute $command";
    }
  }
}

my $builder = $class->new(
                'module_name'         => 'vcftools',
                'dist_author'         => q(npg <npg@sanger.ac.uk>),
                'dist_version'        => $class->git_tag(),
                'dist_abstract'       => 'A set of tools written in Perl and C++ for working with VCF files',
                'license'             => 'lgpl',

          'configure_requires' => {
                'ExtUtils::CBuilder'              => 0,
          },

          'build_requires' => $build_requires,
          'requires'      =>  $requires,

          'dist'          => { COMPRESS => 'gzip', SUFFIX => 'gz', },
         );

$builder->create_build_script();

1;
