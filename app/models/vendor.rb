class Vendor < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :outlets, dependent: :destroy

  validates :mobile, length: {is: 10}, numericality: {only_integer: true}, uniqueness: true, presence: true

  def as_json(options={})
    super(options.merge(
                     except: [:created_at, :updated_at],
                     include: {
                         outlets: {
                             except: [:created_at, :updated_at, :vendor_id]
                         }
                     }
          ))
  end
end
