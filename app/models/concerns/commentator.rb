module Commentator
  extend ActiveSupport::Concern

  included  do
    has_many :comments, as: :commentator
  end

end