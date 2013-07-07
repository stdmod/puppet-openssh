#
# = Class: openssh::config
#
# This class manages openssh configurations
#
class openssh::config {

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
      noop    => $openssh::noop,
    }
  }

  # Configuration Directory, if dir defined
  if $openssh::dir_source {
    file { 'openssh.dir':
      ensure  => $openssh::dir_ensure,
      path    => $openssh::dir,
      source  => $openssh::dir_source,
      recurse => $openssh::dir_recurse,
      purge   => $openssh::dir_purge,
      force   => $openssh::dir_purge,
      audit   => $openssh::audit,
      noop    => $openssh::noop,
    }
  }

}
