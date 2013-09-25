#
# = Class: openssh::monitor
#
# This class monitors openssh
#
# POC
#
class openssh::monitor {

  $enable   = $openssh::monitor_options_hash['enable'],
  $tool     = $openssh::monitor_options_hash['tool'],
  $host     = $openssh::monitor_options_hash['host'],
  $protocol = $openssh::monitor_options_hash['protocol'],
  $port     = $openssh::monitor_options_hash['port'],
  $service  = $openssh::monitor_options_hash['service'],
  $process  = $openssh::monitor_options_hash['process'],

  if $port and $protocol == 'tcp' {
    monitor::port { "openssh_port_${protocol}_${port}":
      enable   => $enable,
      tool     => $tool,
      ip       => $host,
      protocol => $protocol,
      port     => $port,
    }
  }
  if $service {
    monitor::service { "openssh_service_${service}":
      enable   => $enable,
      tool     => $tool,
      service  => $service,
    }
  }


}
