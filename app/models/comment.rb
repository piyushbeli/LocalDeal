class Comment < ActiveRecord::Base
  include Commentable

  belongs_to :commentable, polymorphic: true
  belongs_to :commentator, polymorphic: true


  validates_presence_of  :body, :commentable, :commentator
end