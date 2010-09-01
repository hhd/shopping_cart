# Tasks for setting up resources on the remote server.
namespace :setup do

  set :production_db_conf, YAML::load(File.read(File.join(project_root, "config", "database.yml.example")))["production"]

  desc "Creates the database for production/staging usage. Must be run before migrating!"
  task :database do
    # Create database, new user, and setup correct privileges.
    if production_db_conf["database"] and production_db_conf["username"] and production_db_conf["password"]
      commands = ["CREATE DATABASE IF NOT EXISTS #{production_db_conf["database"]}",
                  "CREATE USER '#{production_db_conf["username"]}'@'localhost' IDENTIFIED BY '#{production_db_conf["password"]}'",
                  "GRANT ALL PRIVILEGES ON #{production_db_conf["database"]}.* TO '#{production_db_conf["username"]}'@'localhost'"]

      run "mysql -u $MYSQL_USER -p$MYSQL_PASS -e \"#{commands.join("; ")}\""
    else
      puts "You must provide a production username and password in the config/database.yml.example file"
    end
  end

  desc "Runs rake db:seed on the server"
  task :seed do
    run "cd #{current_release}; rake db:seed RAILS_ENV=production;"
  end

  desc "Irreversibly removes a website from the staging server (be careful!)"
  task :remove do
    mongrel.cluster.stop
    sudo "rm -rf /usr/local/nginx/conf/apps/#{site_domain}.conf /var/www/apps/rails/#{application}", :pty => true
    nginx.restart

    commands = ["DROP DATABASE IF EXISTS #{production_db_conf['database']}",
                "DROP USER '#{production_db_conf['username']}'@'localhost'"]

    run "mysql -u $MYSQL_USER -p$MYSQL_PASS -e \"#{commands.join('; ')}\""
  end

  desc "Runs an arbitrary rake task on the server(s). Must receive 'task' variable"
  task :rake do
    task = variables[:task]

    if task
      run "rake -f #{current_release}/Rakefile #{task}"
    else
      puts "You must provide a 'task' variable to this recipe: cap rake setup:task=my_task"
    end
  end

  desc "A full deploy to the staging/production server. Includes web server, database, etc"
  task :all do
    transaction do
      deploy.setup
      deploy.update
      setup.database
      deploy.migrate
      seed
      nginx.vh
      mongrel.cluster.start
      nginx.restart
    end
  end

end
