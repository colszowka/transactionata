class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  validate :name, :presence => true
  validate :login, :presence => true, :uniqueness => true
  validate :email, :presence => true, :uniqueness => true
  validate :password, :presence => true, :confirmation => true
  
  has_many :posts
end
