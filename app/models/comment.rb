class Comment < ActiveRecord::Base
  include UserResource
  belongs_to :post

end
