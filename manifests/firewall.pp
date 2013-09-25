#
# = Class: openssh::firewall
#
# This class firewalls openssh
#
# POC
#
class openssh::firewall {

  $enable          = $openssh::firewall_options_hash['enable'],
  $tool            = $openssh::firewall_options_hash['tool'],
  $host            = $openssh::firewall_options_hash['host'],
  $port            = $openssh::firewall_options_hash['port'],
  $protocol        = $openssh::firewall_options_hash['protocol'],
  $source_ip4      = $openssh::firewall_options_hash['source_ip4'],
  $destination_ip4 = $openssh::firewall_options_hash['destination_ip4'],
  $source_ip6      = $openssh::firewall_options_hash['source_ip6'],
  $destination_ip6 = $openssh::firewall_options_hash['destination_ip6'],

  if $port {
    firewall::port { "openssh_${protocol}_${port}":
      enable   => $enable,
      ip       => $host,
      protocol => $protocol,
      port     => $port,
      tool     => $tool,
    }
  }
}
