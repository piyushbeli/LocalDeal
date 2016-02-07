class Comment < ActiveRecord::Base
  #A comment is also commentable
  include Commentable
  markable_as :liked, :spam

  belongs_to :commentable, polymorphic: true
  belongs_to :commentator, polymorphic: true
  belongs_to :offer

  after_save :increment_review_count
  after_destroy :decrement_review_count

  private
  def increment_review_count
    commentable_type.constantize.increment_counter(:no_of_comments, commentable_id)
  end

  def decrement_review_count
    commentable_type.constantize.decrement_counter(:no_of_comments, commentable_id)
  end


  validates_presence_of  :body, :commentable, :commentator
end