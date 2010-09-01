# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  layout :layout_by_resource

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

 private

  # Determines the layout for the current resource.
  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin"
    else
      "application"
    end
  end
 
end
