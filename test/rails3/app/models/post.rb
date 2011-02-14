class Post < ActiveRecord::Base
  validate :title, :presence => true
  validate :body, :presence => true
  
  belongs_to :user
end
