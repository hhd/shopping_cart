# Rake tasks for deployment configuration.

# Asks a question and returns the result as a string.
def ask(question, format=/.*/)
  answer = ""
  until answer.length > 0 and answer =~ format
    print(question)
    answer = STDIN.gets.chomp
  end
  answer
end

# Attempts to fetch the repository name from our VSC server.
def fetch_repo_name
  git_config = File.read(File.join(RAILS_ROOT, ".git", "config"))
  remote = /ssh:\/\/git\@vcs\.hhd\.com\.au\/var\/git\/repos\/(.+)\.git/
  (git_config =~ remote) ? $1 : nil
end

# Generates a random string "length" characters long.
def generate_password(length=8)
  (0...length).map{(65 + rand(25)).chr}.join
end

# Parses YAML from a file, modifies it's content and then dumps it back
# to the same file.
def construct_and_write_yaml(filepath)
  data = YAML::load(File.open(filepath))

  yield data

  File.open(filepath, "w") do |f|
    f.write(YAML::dump(data))
  end
end

namespace :deploy do
  desc "Configures the local application for deployment"
  task :setup do
    app_name = ask("Name of application (a-z, 0-9 with no spaces): ", /^[a-zA-Z0-9\-]+$/)
    start_port = ask("Which port to start the mongrel(s) on? ", /^\d{4,5}$/)

    # Generate and write the deployment configuration.
    repo_name = fetch_repo_name || ask("What is the name of the repository? ")
    construct_and_write_yaml("config/deployment_config.yml") do |data|
      data.update("repo_name" => repo_name, "app_name" => app_name, "subdomain" => app_name)
    end

    # Generate and write the mongrel configuration.
    construct_and_write_yaml("config/mongrel_cluster.yml") do |data|
      data.update("port" => start_port, "cwd" => "/var/www/apps/rails/#{app_name}/current")
    end
    
    # Generate and write the database.yml.example (random password and database name/user).
    construct_and_write_yaml("config/database.yml.example") do |data|
      data["production"].update("username" => app_name[0, 15].gsub("-", "_"), "password" => generate_password,
                                "database" => "#{app_name.gsub("-", "_")}_production")
    end
    
    # Print further instructions for the user.
    puts "\nSuccessfully setup application for deployment. You are now ready to deploy:\n\n"
    puts "   FIRST COMMIT AND PUSH: git commit -avm 'Setup for deployment'; git push origin master\n"
    puts "   AND THEN DEPLOY: cap setup:all"
    puts "   OR: cap -S server=production setup:all\n\n"
  end
end
