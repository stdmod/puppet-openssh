#
# = Class: openssh::service
#
# This class manages openssh service
#
class openssh::service {

  if $openssh::service {
    service { $openssh::service:
      ensure     => $openssh::managed_service_ensure,
      enable     => $openssh::managed_service_enable,
      subscribe  => $openssh::service_subscribe,
      provider   => $openssh::service_provider,
      noop       => $openssh::noop,
    }
  }

}
