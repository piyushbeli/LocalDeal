class Post < ActiveRecord::Base
  include UserResource
  include Commentable
  validates_presence_of :title
  validates_length_of :title, maximum: 10

  def as_json(options = {})
    super(options.merge(include: [:user, comments: {include: :user}]))
  end

end
