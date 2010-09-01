# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Data for development environment. You can add your own data here.
if RAILS_ENV == "development"
  # Default Admininstrator.
  Admin.create(:full_name => "Mickey Rourke", :email => "admin@hhd.com.au",
               :password => "test123", :password_confirmation => "test123")
  puts "Created default administrator."
end
