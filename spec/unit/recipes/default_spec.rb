#
# Cookbook Name:: rm-test
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'rm-test::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    before :each do
      # stub_command('which sudo').and_return('/usr/bin/sudo')
      stub_command('bash -c "source /home/deployer/.rvm/scripts/rvm && type rvm | cat | head -1 | grep -q \'^rvm is a function$\'"').and_return(true)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    %w(users rvm::user).each do |k|
      it "includes the `#{k}` recipe" do
        expect(chef_run).to include_recipe(k)
      end
    end
    it 'should manage user with users' do
      expect(chef_run).to create_users_manage('deployer')
    end
  end
end
