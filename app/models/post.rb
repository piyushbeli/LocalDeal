class Post < ActiveRecord::Base
  include UserResource
  include Commentable

  def as_json(options = {})
    super(options.merge(include: [:user, comments: {include: :user}]))
  end

end
