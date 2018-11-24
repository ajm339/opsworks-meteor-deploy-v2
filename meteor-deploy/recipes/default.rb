#
# Cookbook Name:: meteor-deploy
# Recipe:: default
#
# Copyright 2018, Alex J Meyers
#
# All rights reserved - Do Not Redistribute
#

bash "install meteor production dependencies" do
  user "ubuntu"
  cwd "/home/ubuntu/bundle/programs/server"
  code <<-EOH
    npm install --production
  EOH
end

execute "Start Meteor as Node Application with Websockets option defined in Stack Settings" do
	user "ubuntu"
	cwd "/home/ubuntu/bundle"
	command "METEOR_SETTINGS=#{node["METEOR_SETTINGS"]} PORT=#{node["PORT"]} MONGO_URL=#{node["MONGO_URL"]} ROOT_URL=#{node["ROOT_URL"]} MAIL_URL=#{node["MAIL_URL"]} forever start main.js"
end
