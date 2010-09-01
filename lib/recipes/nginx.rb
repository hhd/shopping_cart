# Tasks for interfacing with Nginx.
namespace :nginx do

  [:stop, :start, :restart, :reload, :status].each do |action|
    desc "#{action.to_s.capitalize} Nginx"
    task action, :roles => :web do
      sudo "/etc/init.d/nginx #{action.to_s}", :via => run_method, :pty => true
    end
  end

  desc "Creates the Nginx Virtual Host configuration for this app"
  task :vh do
    set :site_conf_file, "#{site_domain}.conf"
    set :site_conf_path, "/usr/local/nginx/conf/apps/#{site_conf_file}"
    set :mongrel_config, YAML::load(File.read(File.join(project_root, "config", "mongrel_cluster.yml")))

    # Generate the upstream block for this app.
    vh_template = "upstream mongrel#{mongrel_config["port"]} {\n"
    mongrel_config["servers"].to_i.times do |offset|
      vh_template << "  server 127.0.0.1:#{mongrel_config["port"].to_i + offset};\n"
    end
    vh_template << "}\n\n"

    # Create the correct hostnames depending on the deployment environment.
    hostnames = if target_server == :production
      "www.#{site_domain} #{site_domain}"
    else
      "#{site_domain}.au #{site_domain}"
    end

    # Create the remaining server configuration (the indentation is intentional).
    vh_template << <<-EOF
server {
  listen      80;
  server_name #{hostnames};
  root        /var/www/apps/rails/#{application}/current/public;
  index       index.html index.htm;

  access_log /usr/local/nginx/logs/#{application}.access.log;
  error_log  /usr/local/nginx/logs/#{application}.error.log;

  try_files $uri/index.html $uri.html $uri @mongrel#{mongrel_config["port"]};

  location @mongrel#{mongrel_config["port"]} {
    proxy_set_header  X-Real-IP        $remote_addr;
    proxy_set_header  X-Forwarded-For  $proxy_add_x_forwarded_for;
    proxy_set_header  Host             $http_host;
    proxy_redirect    off;
    proxy_pass        http://mongrel#{mongrel_config["port"]};
  }

  error_page  500 502 503 504  /50x.html;
  location = /50x.html {
    root html;
  }
}
    EOF

    # Write the configuration file to the server
    put vh_template, "./#{site_conf_file}", :mode => 0666
    sudo "mv -f ./#{site_conf_file} #{site_conf_path}", :pty => true
  end

end
