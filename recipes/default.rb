#
# Cookbook Name:: rm-test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'users'

# Create our deployer user
users_manage 'deployer' do
  group_name 'sysadmin'
  data_bag 'users'
end

# Setup sudo
include_recipe 'sudo'

# Install RVM and ruby
include_recipe 'rvm::user'

# Install PostgreSQL
include_recipe 'postgresql::server'
include_recipe 'postgresql::contrib'
include_recipe 'postgresql::ruby'
include_recipe 'rm-test::app'
include_recipe 'rm-test::databases'
include_recipe 'rm-test::nginx'
