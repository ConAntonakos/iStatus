class Status < ActiveRecord::Base
  attr_accessible :content, :user_id #changed the :name field to :user_id for user model
  belongs_to :user
end
