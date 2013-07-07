# Puppet module: openssh

This is a Puppet module for openssh.
It manages its installation, configuration and service.

The blueprint of this module is from http://github.com/Example42-templates/

Released under the terms of Apache 2 License.


## USAGE - Basic management

* Install openssh with default settings (package installed, service started, default configuration files)

        class { 'openssh': }

* Remove openssh package and purge all the managed files

        class { 'openssh':
          ensure => absent,
        }

* Install a specific version of openssh package

        class { 'openssh':
          version => '1.0.1',
        }

* Install the latest version of openssh package

        class { 'openssh':
          version => 'latest',
        }

* Enable openssh service (both at boot and runtime). This is default.

        class { 'openssh':
          status => 'enabled',
        }

* Disable openssh service (both at boot and runtime)

        class { 'openssh':
          status => 'disabled',
        }

* Ensure service is running but don't manage if is disabled at boot

        class { 'openssh':
          status => 'running',
        }

* Ensure service is disabled at boot and do not check it is running

        class { 'openssh':
          status => 'deactivated',
        }

* Do not manage service status and boot condition

        class { 'openssh':
          status => 'unmanaged',
        }

* Do not automatically restart services when configuration files change (Default: true).

        class { 'openssh':
          autorestart => false,
        }

* Enable auditing (on all the arguments)  without making changes on existing openssh configuration *files*

        class { 'openssh':
          audit => 'all',
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'openssh':
          noops => true,
        }


## USAGE - Overrides and Customizations
* Use custom source for main configuration file 

        class { 'openssh':
          source => [ "puppet:///modules/example42/openssh/openssh.conf-${hostname}" ,
                      "puppet:///modules/example42/openssh/openssh.conf" ], 
        }


* Use custom source directory for the whole configuration dir.

        class { 'openssh':
          dir_source  => 'puppet:///modules/example42/openssh/conf/',
        }

* Use custom source directory for the whole configuration dir purging all the local files that are not on the dir.
  Note: This option can be used to be sure that the content of a directory is exactly the same you expect, but it is desctructive and may remove files.

        class { 'openssh':
          dir_source => 'puppet:///modules/example42/openssh/conf/',
          dir_purge  => true, # Default: false.
        }

* Use custom source directory for the whole configuration dir and define recursing policy.

        class { 'openssh':
          dir_source    => 'puppet:///modules/example42/openssh/conf/',
          dir_recursion => false, # Default: true.
        }

* Use custom template for main config file. Note that template and source arguments are alternative.

        class { 'openssh':
          template => 'example42/openssh/openssh.conf.erb',
        }

* Use a custom template and provide an hash of custom configurations that you can use inside the template

        class { 'openssh':
          template => 'example42/openssh/openssh.conf.erb',
          options  => {
            opt  => 'value',
            opt2 => 'value2',
          },
        }


* Specify the name of a custom class to include that provides the dependencies required by the module

        class { 'openssh':
          dependency_class => 'example42::dependency_openssh',
        }


* Automatically include a custom class with extra resources related to openssh.
  Here is loaded $modulepath/example42/manifests/my_openssh.pp.
  Note: Use a subclass name different than openssh to avoid order loading issues.

        class { 'openssh':
          my_class => 'example42::my_openssh',
        }

## TESTING
[![Build Status](https://travis-ci.org/example42/puppet-openssh.png?branch=master)](https://travis-ci.org/example42/puppet-openssh)
