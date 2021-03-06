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
  owner 'deploy'
  mode '0777'
  action :create
end

directory "/var/www/#{app['name']}" do
  owner 'deploy'
  mode '0777'
  action :create
end

bash "remove previous version" do
  user "deploy"
  cwd "/var/www/#{app['name']}"
  ignore_failure true
  environment 'PATH' => "~/.nvm/versions/node/v8.11.4/bin/:#{ENV['PATH']}"
  code <<-EOH
    forever stopall
    rm -rf bundle
    rm #{app['name']}.tar.gz
  EOH
end

bash "get app and unbundle it" do
  user "deploy"
  cwd "/var/www/#{app['name']}"
  code <<-EOH
    wget #{app['app_source']['url']}
    tar -zxvf #{app['name']}.tar.gz
  EOH
end
