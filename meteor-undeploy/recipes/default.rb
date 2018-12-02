#
# Cookbook Name:: meteor-undeploy
# Recipe:: default
#
# Copyright 2016, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

app = search("aws_opsworks_app").first

execute "Stop Meteor as Node Application" do
  user "deploy"
  command "sudo forever stopall"
end

bash "remove previous version" do
  user "deploy"
  cwd "/var/www/#{app['name']}"
  code <<-EOH
    rm -rf bundle
    rm #{app['name']}.tar.gz
  EOH
end
