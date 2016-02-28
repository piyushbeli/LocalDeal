class Vendor < ActiveRecord::Base

  devise :database_authenticatable, :recoverable,
         :trackable, :validatable, :registerable

  devise :timeoutable, :timeout_in => 1.hour

  include DeviseTokenAuth::Concerns::User
  include Spammable
  include FriendlyId
  acts_as_marker

  friendly_id :slug_candidates, use: [:slugged, :history]
  has_many :outlets, dependent: :destroy
  belongs_to :category
  has_many :outlet_images, as: :uploader
  has_many :deals
  has_many :orders

  has_many :vendors_subcategories
  has_and_belongs_to_many :subcategories, through: :vendors_subcategories

  validates :mobile, length: {is: 10}, numericality: {only_integer: true}, uniqueness: true, presence: true

  def as_json(options={})
    super(options.merge(
                     except: [:created_at, :updated_at],
                     include: {
                         outlets: {
                             except: [:created_at, :updated_at, :vendor_id]
                         },
                         subcategories: {
                             except: [:created_at, :updated_at, :category_id, :name]
                         }
                     }
          ))
  end

  def active_for_authentication?
    true
  end

  def set_verified (bool)
    self.update_attribute('is_verified', true)
  end

  def max_deal_reached?
    deals.length >= 1
  end

  def spammed_by_user? (user_id)
    return spams.where(spammer_id: user_id).count > 0
  end

  #Slug candidate in sequence of priority
  def slug_candidates
    [
        "#{name}",
        "#{name} #{random_no}"
    ]
  end

  def random_no
    return rand(10000..99999)
  end
end
