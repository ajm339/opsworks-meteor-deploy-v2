#
# Cookbook Name:: get-app
# Recipe:: default
#
# Copyright 2016, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

app = search("aws_opsworks_app").first

directory "/var/www" do
  owner 'ubuntu'
  mode '0777'
  action :create
end

directory "/var/www/#{app['name']}" do
  owner 'ubuntu'
  mode '0777'
  action :create
end

bash "remove previous version" do
  user "ubuntu"
  cwd "/var/www/#{app['name']}"
  ignore_failure true
  code <<-EOH
    forever stopall
    rm -rf bundle
    rm #{app['name']}.tar.gz
  EOH
end

bash "get app and unbundle it" do
  user "ubuntu"
  cwd "/var/www/#{app['name']}"
  code <<-EOH
    wget #{app['app_source']['url']}
    tar -zxvf #{app['name']}.tar.gz
  EOH
end
