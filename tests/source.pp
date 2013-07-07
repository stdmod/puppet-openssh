#
# Testing configuration file provisioning via source
# Auditing enabled
#
class { 'openssh':
  source => 'puppet:///modules/openssh/tests/test.conf',
  audit  => 'all',
}
