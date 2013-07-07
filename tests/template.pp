#
# Testing configuration file provisioning via template
# Auditing enabled
#
class { 'openssh':
  template => 'openssh/tests/test.conf',
  audit    => 'all',
}
