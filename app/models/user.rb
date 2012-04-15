class User < ActiveRecord::Base
  attr_accessible :name, :email

  validates :user, :presence => true
end
