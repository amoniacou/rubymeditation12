require 'spec_helper'

describe 'rm-test::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe file('/home/deployer/.rvm') do
    it { should be_directory }
    it { should be_owned_by 'deployer' }
  end

  describe command('/home/deployer/.rvm/rubies/default/bin/ruby --version') do
    its(:stdout) { should match /2\.3\.1/ }
  end

  describe command('psql --version') do
    its(:stdout) { should match /9\.5/ }
  end
end
