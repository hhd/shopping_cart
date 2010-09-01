class Admin < ActiveRecord::Base

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates_presence_of :full_name

  attr_accessible :full_name, :email, :password, :password_confirmation

end
