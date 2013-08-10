# Class: openssh::params
#
# Defines all the variables used in the module.
#
class openssh::params {

  $package = $::osfamily ? {
    Suse    => 'openssh',
    OpenBSD => '',
    default => 'openssh-server',
  }

  $service = $::osfamily ? {
    Debian  => 'ssh',
    default => 'sshd',
  }

  $file = $::osfamily ? {
    default => '/etc/ssh/sshd_config',
  }

  $file_mode = $::osfamily ? {
    Suse    => '0640',
    OpenBSD => '0644',
    default => '0600',
  }

  $file_owner = $::osfamily ? {
    default => 'root',
  }

  $file_group = $::osfamily ? {
    default => 'root',
  }

  $dir = $::osfamily ? {
    default => '/etc/ssh',
  }

}
