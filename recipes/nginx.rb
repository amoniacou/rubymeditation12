
include_recipe 'nginx'
include_recipe 'simple_iptables'

# Allow HTTP
simple_iptables_rule 'http' do
  rule ['--proto tcp --dport 80']
  jump 'ACCEPT'
end

template "#{node['nginx']['dir']}/sites-available/rm-test.conf" do
  source 'nginx.conf.erb'
  mode '0644'
  action :create
  variables app_name: 'rm_test', domain: 'rmtest.com'
end

nginx_site 'rm-test.conf'

