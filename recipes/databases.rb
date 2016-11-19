include_recipe 'openssl'
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

# Set db password if it empty for our app
node.set_unless['rm_test']['db_pass'] = secure_password

# Default connection info
postgresql_connection_info = {
  host: 'localhost',
  port: node['postgresql']['config']['port'],
  username: 'postgres',
  password: node['postgresql']['password']['postgres']
}

# Create database
db_name = 'rm_test_production'
db_user = 'rm_test'
postgresql_database db_name do
  connection postgresql_connection_info
  action :create
end

# Create user
postgresql_database_user db_user do
  connection postgresql_connection_info
  password node['rm_test']['db_pass']
  action :create
end

# Grant privileges to user for this db
postgresql_database_user db_user do
  connection postgresql_connection_info
  database_name db_name
  privileges [:all]
  action :grant
end

template '/srv/apps/rm_test/shared/config/database.yml' do
  source 'database.yml.erb'
  mode '0644'
  owner 'deployer'
  variables(db_name: db_name,
            db_user: db_user,
            db_pool: 25,
            db_password: node['rm_test']['db_pass'])
  action :create_if_missing
end

