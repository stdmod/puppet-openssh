#
# = Class: openssh::monitor
#
# This class monitors openssh
#
class openssh::monitor (
  $enable   = $openssh::monitor,
  $tool     = $openssh::monitor_tool,
  $host     = $openssh::monitor_host,
  $protocol = $openssh::monitor_protocol,
  $port     = $openssh::monitor_port,
  $service  = $openssh::service,
  ) inherits openssh {

  if $port and $protocol == 'tcp' {
    monitor::port { "openssh_${openssh::protocol}_${openssh::port}":
      ip       => $host,
      protocol => $protocol,
      port     => $port,
      tool     => $tool,
      enable   => $enable,
    }
  }
  if $service {
    monitor::service { 'openssh_service':
      service  => $service,
      tool     => $tool,
      enable   => $enable,
    }
  }
}
