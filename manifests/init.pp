#
# = Class: openssh
#
# This class installs and manages openssh
#
#
# == Parameters
#
# Refer to the official documentation for standard parameters usage.
# Look at the code for the list of supported parametes and their defaults.
#
class openssh (

  $ensure              = 'present',
  $version             = undef,
  $audit               = undef,

  $package             = $openssh::params::package,

  $service             = $openssh::params::service,
  $service_ensure      = 'running',
  $service_enable      = true,

  $file                = $openssh::params::file,
  $file_owner          = $openssh::params::file_owner,
  $file_group          = $openssh::params::file_group,
  $file_mode           = $openssh::params::file_mode,
  $file_replace        = $openssh::params::file_replace,
  $file_require        = "Package['openssh']",
  $file_notify         = "Service['openssh']",
  $file_source         = undef,
  $file_template       = undef,
  $file_content        = undef,
  $file_options_hash   = undef,

  $dir                 = $openssh::params::dir,
  $dir_source          = undef,
  $dir_purge           = false,
  $dir_recurse         = true,

  $dependency_class    = undef,
  $monitor_class       = 'openssh::monitor',
  $firewall_class      = 'openssh::firewall',
  $my_class            = undef,

  $monitor             = false,
  $monitor_host        = $::ipaddress,
  $monitor_port        = 22,
  $monitor_protocol    = tcp,
  $monitor_tool        = '',

  $firewall            = false,
  $firewall_src        = '0/0',
  $firewall_dst        = '0/0',
  $firewall_port       = 22,
  $firewall_protocol   = tcp

  ) inherits openssh::params {


  # Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent. WARNING: If set to absent all the resources managed by the module are removed.')
  validate_bool($service_enable)
  validate_bool($dir_recurse)
  validate_bool($dir_purge)
  if $file_options_hash { validate_hash($file_options_hash) }

  # Calculation of variables used in the module
  if $file_content {
    $managed_file_content = $file_content
  } else {
    if $file_template {
      $managed_file_content = template($file_template)
    } else {
      $managed_file_content = undef
    }
  }

  if $version {
    $managed_package_ensure = $version
  } else {
    $managed_package_ensure = $ensure
  }

  if $ensure == 'absent' {
    $managed_service_enable = undef
    $managed_service_ensure = stopped
    $dir_ensure = absent
    $file_ensure = absent
  } else {
    $managed_service_enable = $service_enable
    $managed_service_ensure = $service_ensure
    $dir_ensure = directory
    $file_ensure = present
  }


  # Resources Managed

  if $openssh::package {
    package { $openssh::package:
      ensure   => $openssh::managed_package_ensure,
    }
  }

  if $openssh::service {
    service { $openssh::service:
      ensure     => $openssh::managed_service_ensure,
      enable     => $openssh::managed_service_enable,
    }
  }

  if $openssh::file {
    file { 'openssh.conf':
      ensure  => $openssh::file_ensure,
      path    => $openssh::file,
      mode    => $openssh::file_mode,
      owner   => $openssh::file_owner,
      group   => $openssh::file_group,
      source  => $openssh::file_source,
      content => $openssh::managed_file_content,
      audit   => $openssh::audit,
      notify  => $openssh::file_notify,
      require => $openssh::file_require,
    }
  }

  if $openssh::dir_source {
    file { 'openssh.dir':
      ensure  => $openssh::dir_ensure,
      path    => $openssh::dir,
      source  => $openssh::dir_source,
      recurse => $openssh::dir_recurse,
      purge   => $openssh::dir_purge,
      force   => $openssh::dir_purge,
      audit   => $openssh::audit,
      notify  => $openssh::file_notify,
      require => $openssh::file_require,
    }
  }

  # Extra classes
  if $openssh::dependency_class {
    include $openssh::dependency_class
  }

  if $openssh::monitor and $openssh::monitor_class {
    include $openssh::monitor_class
  }

  if $openssh::firewall and $openssh::firewall_class {
    include $openssh::firewall_class
  }

  if $openssh::my_class {
    include $openssh::my_class
  }

}
