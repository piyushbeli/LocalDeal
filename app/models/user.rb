class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  devise :timeoutable, :timeout_in => 30.days
  validates :name, presence: true
end
