#
# Cookbook Name:: meteor-deploy
# Recipe:: default
#
# Copyright 2018, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

app = search("aws_opsworks_app").first

bash "check npm and node" do
  user "ubuntu"
  cwd "/var/www/#{app['name']}/bundle/programs/server"
  code <<-EOH
    echo $USER
    whoami
    npm --version
    node --version
  EOH
end


bash "install meteor production dependencies" do
  user "ubuntu"
  cwd "/var/www/#{app['name']}/bundle/programs/server"
  code <<-EOH
    sudo npm install --production
  EOH
end

execute "Start Meteor as Node Application with Websockets option defined in Stack Settings" do
	user "ubuntu"
	cwd "/var/www/#{app['name']}/bundle"
	command "METEOR_SETTINGS=#{node["METEOR_SETTINGS"]} PORT=#{node["PORT"]} MONGO_URL=#{node["MONGO_URL"]} ROOT_URL=#{node["ROOT_URL"]} MAIL_URL=#{node["MAIL_URL"]} forever start main.js"
end
