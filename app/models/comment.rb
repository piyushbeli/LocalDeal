class Comment < ActiveRecord::Base
  #A comment is also commentable
  include Commentable

  belongs_to :commentable, polymorphic: true
  belongs_to :commentator, polymorphic: true


  validates_presence_of  :body, :commentable, :commentator
end