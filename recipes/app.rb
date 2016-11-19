def create_folder(home, sub)
  directory ::File.join(home, sub) do
    owner 'deployer'
    group 'deployer'
    mode '0755'
    recursive true
  end
end

app_dir = "/srv/apps/rm_test"
create_folder(app_dir, '')
%w(shared shared/config shared/log).each do |sub|
  create_folder(app_dir, sub)
end
