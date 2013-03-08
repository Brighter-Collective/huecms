class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  attr_accessible :content, :commentable_id, :commentable_type, :user_id

end
