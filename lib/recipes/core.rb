require "mongrel_cluster/recipes"

# Do not edit this file!!
# Add your custom tasks to lib/recipes/YOUR_TASK.rb
# Configuration options can be found in: config/deployment_config.yml

set :deployment_config, YAML::load(File.read(File.join(project_root, "config", "deployment_config.yml")))
set :application, deployment_config["app_name"]

set :repository, "ssh://git@vcs.hhd.com.au/var/git/repos/#{deployment_config["repo_name"]}.git"
set :scm, :git

set :use_sudo, false
set :user, "capistrano"
set :runner, "capistrano"
ssh_options[:username] = "capistrano"
#default_run_options[:pty] = true

set :deploy_to, "/var/www/apps/rails/#{application}"

# Servers.
#  Staging:    cap some:task
#  Production: cap -S server=production some:task
set :hostnames, {:production => "production.hhd.com.au", :preview => "hhdpreview.com.au"}
set :target_server, (variables[:server] || "preview").to_sym
server hostnames[target_server], :app, :web, :db, :primary => true

if target_server == :preview
  set :site_domain, "#{deployment_config["subdomain"]}.#{find_servers(:role => :app).first}"
else
  set :site_domain, deployment_config["live_domain"]
end

# Mongrel configuration.
set :mongrel_conf, File.join(current_path, "config", "mongrel_cluster.yml")

# Creates the database.yml file immediately after deployment.
after "deploy:update_code" do
  run "cp #{File.join(current_release, "config", "database.yml.example")} #{File.join(current_release, "config", "database.yml")}"
end

# Always install gem dependencies before migrating
# to prevent Rails from throwing exception.
before "deploy:migrate" do
  sudo "rake -f #{File.join(current_release, "Rakefile")} gems:install"
end