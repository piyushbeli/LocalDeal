class Post < ActiveRecord::Base
  include UserResource
  include Commentable
  validates_presence_of :title
  validates_length_of :title, maximum: 10

  def as_json(options = {})
    super(options.merge(
                     except: [:created_at, :updated_at, :user_id],
                     include: {
                         user: {
                             only: [:name, :id]
                         },
                         comments: {
                             include: {
                                 user: {
                                     only: [:name, :id]
                                 }
                             }
                         }
                     }
          ))
  end

end
