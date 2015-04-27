class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  validates :name, presence: true
end
