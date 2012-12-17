include_recipe "java"

directory node["selenium"]["lib"] do
  owner "root"
  group "root"
  mode 00755
  action :create
end

remote_file "#{node["selenium"]["lib"]}/#{node["selenium"]["jar"]}" do
  source "http://selenium.googlecode.com/files/#{node["selenium"]["jar"]}"
  mode 00644
end

directory node["selenium"]["log"] do
  owner "root"
  group "root"
  mode 00777
  action :create
end

template "/etc/init.d/selenium" do
  source "selenium.erb"
  mode 00755
end

service "selenium" do
  action [ :enable, :start ]
end

package "xvfb"
package "iceweasel"

template "/etc/init.d/xvfb" do
  source "xvfb.erb"
  mode 00755
end

service "xvfb" do
  action [ :enable, :start ]
end
