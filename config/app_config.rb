# This is where I place all application-wide "constants" and configuration.
# It's much nicer than using global variables. The pattern is described at the
# URL below:
#
# Source: http://toolmantim.com/thoughts/consolidating_your_apps_constants

require "active_support"

module HHD
  module Config
    mattr_accessor :admin_email, :client_name

    @@admin_email = "logan@hhd.com.au"
    @@client_name = "HHD Camera Store"
  end
end
