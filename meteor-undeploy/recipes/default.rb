#
# Cookbook Name:: meteor-undeploy
# Recipe:: default
#
# Copyright 2016, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

execute "Stop Meteor as Node Application" do
  user "root"
  command "forever stopall"
end

app = search("aws_opsworks_app").first

bash "remove previous version" do 
  user "root"
  cwd "/root"
  code <<-EOH
    rm -rf bundle
    rm #{app['name']}.tar.gz
  EOH
end