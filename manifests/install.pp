#
# = Class: openssh::install
#
# This class installs openssh
#
class openssh::install {

  if $openssh::package {
    package { $openssh::package:
      ensure   => $openssh::managed_package_ensure,
      provider => $openssh::package_provider,
      noop     => $openssh::noop,
    }
  }

}
