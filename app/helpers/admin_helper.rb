module AdminHelper

  # Generates the default CMS navigation in the following ways:
  #   0) Attempts to render: ./app/views/admin/RESOURCE/_nav.html.erb
  #   1) Generates default Nav based on the resource name.
  # To disable automatic nav generation for a particular controller,
  # you should overload "show_nav?" and have it return false.
  def cms_navigation
    controllers = Dir[File.join(RAILS_ROOT, "app", "controllers", "admin", "*_controller.rb")]
    navigation = controllers.map do |path|
      # This eval hack is required because of a name clash between
      # the model "Admin" and the namespace module "Admin".
      # So "klass" here will be like: "Admin::ProductsController".
      klass = eval("Admin::#{File.basename(path).sub(/\.rb/, "").camelcase}")

      if klass.superclass == AdminController and klass.show_nav?
        custom_view = File.join(RAILS_ROOT, "app", "views", cms_nav_url(klass), "_nav.html.erb")

        # Render the custom view it possible, otherwise just the detault.
        partial = if File.exists?(custom_view)
          "#{cms_nav_url(klass)}nav"
        else
          "/admin/nav"
        end
        
        render :partial => partial, :locals => {:resource => klass}
      end
    end

    navigation.compact.join("\n")
  end

  # Generates a URL for a CMS section given the controller name:
  #   Admin::ProductCategoriesController -> "/admin/product_categories"
  def cms_nav_url(resource)
    "/#{resource.to_s.sub("::", "/").sub(/Controller$/, "").underscore}/"
  end

end
