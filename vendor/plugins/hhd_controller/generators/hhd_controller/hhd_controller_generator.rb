class HhdControllerGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Controllers.
      m.template "hhd_controller.rb", "app/controllers/admin/#{file_name}_controller.rb"

      # Views.
      m.directory "app/views/admin/#{file_name}"

      # Helpers.
      m.template "hhd_helper.rb", "app/helpers/admin/#{file_name}_helper.rb"

      # Routes.
      if options[:command] == :create
        routing_code = "admin.resources :#{file_name}, :active_scaffold => true"
        sentinel = "map.namespace :admin do |admin|"
        gsub_file "config/routes.rb", /(#{Regexp.escape(sentinel)})/mi do |match|
          "#{match}\n    #{routing_code}\n"
        end
        puts "Added route: #{routing_code}"
      else
        sentinel = "admin.resources :#{file_name}, :active_scaffold => true"
        gsub_file "config/routes.rb", /(#{Regexp.escape(sentinel)}\n)/mi do |match|
          ""
        end
        puts "Removed route: #{sentinel}"
      end
    end
  end

 private

  # A simple method to modify the contents of an existing file.
  def gsub_file(relative_destination, regexp, *args, &block)
    path = destination_path(relative_destination)
    content = File.read(path).gsub(regexp, *args, &block)
    File.open(path, 'wb') { |file| file.write(content) }
  end

end
