class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  devise :timeoutable, :timeout_in => 30.days
  validates :name, presence: true, allow_blank: false
  validates :mobile, length: {is: 10}, numericality: {only_integer: true}, uniqueness: true, allow_nil: true
end
