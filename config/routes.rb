ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes"

  # This is required to prevent Rails from becoming confused about the Admin namespace
  # in production.
  map.connect "/admin", :controller => "admin"

  map.namespace :admin do |admin|
    admin.resources :lenses, :active_scaffold => true

    admin.resources :cameras, :active_scaffold => true

    admin.resources :admins, :active_scaffold => true

    admin.root :controller => "admin", :action => "index"
  end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "static", :action => "index"

  # Routes for authentication
  map.devise_for :admins

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
