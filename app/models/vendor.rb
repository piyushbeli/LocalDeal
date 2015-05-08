class Vendor < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :mobile, length: {is: 10}, numericality: {only_integer: true}, uniqueness: true, presence: true
end
