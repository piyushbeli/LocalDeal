class Vendor < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  has_many :outlets, dependent: :destroy
  belongs_to :category
  has_many :vendor_images, dependent:  :destroy
  has_many :deals

  has_many :vendor_subcategories
  has_and_belongs_to_many :subcategories, through: :vendor_subcategories


  validates :mobile, length: {is: 10}, numericality: {only_integer: true}, uniqueness: true, presence: true

  def as_json(options={})
    super(options.merge(
                     except: [:created_at, :updated_at],
                     include: {
                         outlets: {
                             except: [:created_at, :updated_at, :vendor_id]
                         },
                         vendor_images: {
                             except: [:created_at, :updated_at, :vendor_id]
                         },
                         subcategories: {
                             except: [:created_at, :updated_at, :category_id, :name]
                         }
                     }
          ))
  end

  def dealCountLimitReached?
    deals.length >= 4
  end
end
