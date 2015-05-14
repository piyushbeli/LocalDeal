class Deal < ActiveRecord::Base
  include Vendor::VendorResource

  has_many :deal_outlets
  has_and_belongs_to_many :outlets, through: :deal_outlets

  validates_presence_of :title, :vendor_id

  def as_json(options={})
    super(options.merge(
                     except: [:created_at, :updated_at],
                     include: {
                         outlets: {
                             except: [:created_at, :updated_at]
                         }
                     }
          ))
  end

end