class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :commentator, polymorphic: true

  validates_presence_of :title, :body, :commentable, :commentator
end