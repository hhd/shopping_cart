# Tasks for debugging and/or interacting with an existing site.
namespace :live do

  desc "Prints the last n lines of the production log file"
  task :view_log do
    n = variables[:n] or 100

    if n =~ /^\d+$/
      run "tail -n #{n} #{release_path}/log/production.log"
    else
      puts "You must provide a numeric value to this recipe"
    end
  end

  # Tasks for dumping MySQL data across servers.
  # These tasks only copy data and thus assume that the database structure does
  # not vary across servers. MySQL must be used locally for imports from remote
  # servers.
  namespace :dump do

    set :remote_db_conf, YAML::load(File.read(File.join(project_root, "config", "database.yml.example")))
    set :local_db_conf, YAML::load(File.read(File.join(project_root, "config", "database.yml")))

    desc "Copies ALL data from the staging/preview server to the live server. BE CAREFUL!"
    task :staging_to_live do
      if target_server == :production
        run mysql_transport(:preview) 
        run dump_uploads(:preview)
      else
        puts "Failure. This task must be run from the production server"
      end
    end

    desc "Copies ALL data from the live server to the staging/preview server. BE CAREFUL!"
    task :live_to_staging do
      if target_server == :preview
        run mysql_transport(:production) 
        run dump_uploads(:production)
      else
        puts "Failure. This task must be run from the staging/preview server"
      end
    end

    desc "Copies ALL data from the live server to your local machine"
    task :live_to_local do
      local_dump(:production)
    end

    desc "Copies ALL data from the staging/preview server to your local machine"
    task :staging_to_local do
      local_dump(:preview)
    end

    # Returns true if MySQL is being used in the development environment.
    def using_mysql?
      local_db_conf["development"]["adapter"] == "mysql"
    end

    # Dumps data from a remote server to the local machine. Includes MySQL data and
    # uploaded media in ./public/system.
    def local_dump(server)
      if using_mysql?
        if target_server == server
          # Capture MySQL data and import it locally.
          data = capture(mysql_dump)
          user = local_db_conf["development"]["username"]
          pass = local_db_conf["development"]["password"]
          File.open("cap_dump_data.sql", "w") do |f|
            f.write data.sub("`#{remote_db_conf["production"]["database"]}`",
                             "`#{local_db_conf["development"]["database"]}`")
          end
          `cat cap_dump_data.sql | mysql -u #{user} -p#{pass}`
          FileUtils.rm_f("cap_dump_data.sql")

          # Copy uploaded media from the remote server to the local machine.
          if File.exists?("public/system")
            FileUtils.rm_rf("public/system")
            current_file = ""
            get("#{shared_path}/system", "public/", :via => :scp, :recursive => true) do |channel, name, received, total|
              if current_file == name
                puts "...#{(received*100) / total}%"
              else
                current_file = name
                puts "GET #{name} (#{total} bytes)"
              end
            end
          end
        else
          puts "Failure. This task must be run from the #{server} server"
        end
      else
        puts "Failure. This task uses mysqldump, so you must use MySQL in development"
      end
    end

    # Returns a string representing the command to ssh into a server and dump the contents of a
    # MySQL database into a local database of the same name.
    def mysql_transport(server)
      conf = remote_db_conf["production"]
      "ssh #{ssh_options[:username]}@#{hostnames[server]} '#{mysql_dump}' | " +
      "mysql -u #{conf["username"]} -p#{conf["password"]}"
    end

    # Returns a string representing the command to dump the contents/structure of the database
    # for this project.
    def mysql_dump
      conf = remote_db_conf["production"]
      "mysqldump --no-create-db --skip-comments --databases #{conf["database"]} " +
      "-u #{conf["username"]} -p#{conf["password"]}"
    end

    # Returns a string representing the command to scp all uploaded files from one server to
    # another.
    def dump_uploads(server)
      "scp -r #{ssh_options[:username]}@#{hostnames[server]}:#{shared_path}/system #{shared_path}"
    end
  
  end

end
