# Puppet module: openssh

This is a Puppet module for openssh.
It manages its installation, configuration and service.

The module is based on stdmod naming standars.
Refer to http://github.com/stdmod/

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

* Enable openssh service. This is default.

        class { 'openssh':
          service_ensure => 'running',
        }

* Enable openssh service at boot. This is default.

        class { 'openssh':
          service_status => 'enabled',
        }


* Do not automatically restart services when configuration files change (Default: Class['openssh::config']).

        class { 'openssh':
          service_subscribe => false,
        }

* Enable auditing (on all the arguments)  without making changes on existing openssh configuration *files*

        class { 'openssh':
          audit => 'all',
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'openssh':
          noop => true,
        }


## USAGE - Overrides and Customizations
* Use custom source for main configuration file 

        class { 'openssh':
          file_source => [ "puppet:///modules/example42/openssh/openssh.conf-${hostname}" ,
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
          file_template => 'example42/openssh/openssh.conf.erb',
        }

* Use a custom template and provide an hash of custom configurations that you can use inside the template

        class { 'openssh':
          filetemplate       => 'example42/openssh/openssh.conf.erb',
          file_options_hash  => {
            opt  => 'value',
            opt2 => 'value2',
          },
        }


* Specify the name of a custom class to include that provides the dependencies required by the module

        class { 'openssh':
          class_dependency  => 'site::openssh_dependency',
        }


* Automatically include a custom class with extra resources related to openssh.
  Here is loaded $modulepath/example42/manifests/my_openssh.pp.
  Note: Use a subclass name different than openssh to avoid order loading issues.

        class { 'openssh':
         class_my => 'site::openssh_my',
        }

## TESTING
[![Build Status](https://travis-ci.org/stdmod/puppet-openssh.png?branch=master)](https://travis-ci.org/stdmod/puppet-openssh)
