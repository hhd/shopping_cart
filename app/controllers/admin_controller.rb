class AdminController < ApplicationController

  layout "admin"

  before_filter :authenticate_admin!

  def index
  end

  ActiveScaffold.set_defaults do |config| 
    config.ignore_columns.add [:created_at, :updated_at]
  end

  class << self
    # Overload in subclass to give a custom CMS navigation title.
    # We use alias_method so the original definition is always available.
    def nav_title
      self.to_s.sub("Admin::", "").sub(/Controller$/, "").titleize
    end
    alias_method :orig_nav_title, :nav_title

    # Overload in subclass to prevent generating a CMS nav for the
    # given controller.
    def show_nav?
      true
    end
  end

end
