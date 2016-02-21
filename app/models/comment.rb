class Comment < ActiveRecord::Base
  #A comment is also commentable
  include Commentable
  markable_as :liked, :spam

  belongs_to :commentable, polymorphic: true
  belongs_to :commentator, polymorphic: true
  belongs_to :offer

  after_save :increment_review_count, :update_outlet_reviews
  after_destroy :decrement_review_count, :update_outlet_reviews

  private
  def increment_review_count
    commentable_type.constantize.increment_counter(:no_of_comments, commentable_id)
  end

  def decrement_review_count
    commentable_type.constantize.decrement_counter(:no_of_comments, commentable_id)
  end

  def update_outlet_reviews
    if commentable_type == 'Comment'
      outlet = self.commentable.commentable(:include => :comments)
    else
      outlet = self.commentable
    end
    key = 'Outlet-' + outlet.slug + '-' + 'reviews'
    CacheService.update_key(key, outlet.comments)
    if offer_id
      key = key + '-offer-' + offer_id
      CacheService.update_key(key, outlet.comments.where(offer_id: offer_id))
    end
  end


  validates_presence_of  :body, :commentable, :commentator
end