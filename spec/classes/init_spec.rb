# require 'spec_helper'
require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'openssh' do

  let(:title) { 'openssh' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { {
    :ipaddress => '10.42.42.42',
  } }

  describe 'Test default settings  ' do
    it 'should install openssh package' do should contain_package('openssh-server').with_ensure('present') end
    it 'should run openssh service' do should contain_service('sshd').with_ensure('running') end
    it 'should enable openssh service at boot' do should contain_service('sshd').with_enable('true') end
    it 'should manage config file presence' do should contain_file('openssh.conf').with_ensure('present') end
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
    it { should contain_package('openssh-server').with_ensure('1.0.42') }
  end

  describe 'Test decommissioning' do
    let(:params) { {:ensure => 'absent'} }
    it 'should remove Package[openssh]' do should contain_package('openssh-server').with_ensure('absent') end
    it 'should stop Service[openssh]' do should contain_service('sshd').with_ensure('stopped') end
    it 'should not manage at boot Service[openssh]' do should contain_service('sshd').with_enable(nil) end
    it 'should remove openssh configuration file' do should contain_file('openssh.conf').with_ensure('absent') end
  end

  describe 'Test service disabling' do
    let(:params) { {
      :service_ensure => 'stopped',
      :service_enable => false,
    } }
    it 'should stop Service[openssh]' do should contain_service('sshd').with_ensure('stopped') end
    it 'should not enable at boot Service[openssh]' do should contain_service('sshd').with_enable('false') end
  end

  describe 'Test noop mode' do
    let(:params) { {:noop => true} }
    it { should contain_package('openssh-server').with_noop('true') }
    it { should contain_service('sshd').with_noop('true') }
    it { should contain_file('openssh.conf').with_noop('true') }
  end

  describe 'Test custom file via template' do
    let(:params) { {
      :file_template => 'openssh/spec/spec.conf.erb',
      :file_options_hash => { 'opt_a' => 'value_a' },
    } }
    it { should contain_file('openssh.conf').with_content(/fqdn: rspec.example42.com/) }
    it 'should generate a template that uses custom options' do
      should contain_file('openssh.conf').with_content(/value_a/)
    end
  end

  describe 'Test custom file via source' do
    let(:params) { {:file_source => "puppet:///modules/openssh/spec/spec.conf"} }
    it { should contain_file('openssh.conf').with_source('puppet:///modules/openssh/spec/spec.conf') }
  end

  describe 'Test customizations - dir' do
    let(:params) { {
      :dir_source => 'puppet:///modules/openssh/tests/',
      :dir_purge => true
    } }
    it { should contain_file('openssh.dir').with_source('puppet:///modules/openssh/tests/') }
    it { should contain_file('openssh.dir').with_purge('true') }
    it { should contain_file('openssh.dir').with_force('true') }
  end

  describe 'Test customizations - custom class' do
    let(:params) { {:class_my => "openssh::spec" } }
    it { should contain_file('my_config').with_content(/my_content/) }
    it { should contain_file('my_config').with_path('/etc/openssh/my_config') }
  end

  describe 'Test service subscribe' do
    let(:params) { {:service_subscribe => false } }
    it 'should not automatically restart the service when files change' do
      should contain_service('sshd').with_subscribe(false)
    end
  end

end
