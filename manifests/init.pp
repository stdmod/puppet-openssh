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
  $noop                = undef,

  $package             = $openssh::params::package,
  $package_provider    = undef,

  $service             = $openssh::params::service,
  $service_ensure      = 'running',
  $service_enable      = true,
  $service_subscribe   = $openssh::params::service_subscribe,
  $service_provider    = undef,

  $file                = $openssh::params::file,
  $file_owner          = $openssh::params::file_owner,
  $file_group          = $openssh::params::file_group,
  $file_mode           = $openssh::params::file_mode,
  $file_replace        = $openssh::params::file_replace,
  $file_source         = undef,
  $file_template       = undef,
  $file_content        = undef,
  $file_options_hash   = undef,

  $dir                 = $openssh::params::dir,
  $dir_source          = undef,
  $dir_purge           = false,
  $dir_recurse         = true,

  $class_dependency    = undef,
  $class_monitor       = 'openssh::monitor',
  $class_firewall      = 'openssh::firewall',
  $class_my            = undef,

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
  class { 'openssh::install':
  }

  class { 'openssh::service':
    require => Class['openssh::install'],
  }

  class { 'openssh::config':
    require => Class['openssh::install'],
  }


  # Extra classes
  if $openssh::class_dependency {
    include $openssh::class_dependency
  }

  if $openssh::monitor and $openssh::class_monitor {
    include $openssh::class_monitor
  }

  if $openssh::firewall and $openssh::class_firewall {
    include $openssh::class_firewall
  }

  if $openssh::class_my {
    include $openssh::class_my
  }

}
