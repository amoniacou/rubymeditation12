require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
  config.log_level = :error
end

def create_users_manage(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:users_manage, :create, resource_name)
end
