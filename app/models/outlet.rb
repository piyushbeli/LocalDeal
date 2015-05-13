class Outlet < ActiveRecord::Base
  include Vendor::VendorResource

  has_many :deal_outlets
  has_and_belongs_to_many :deals, through: :deal_outlets ,dependent: :destroy

  validates_presence_of :city_id, :vendor_id, :latitude, :longitude, :name, :mobile
  validates_format_of :latitude, :longitude, with: /\A\d{1,9}\.?\d{0,6}\z/
  validates_length_of :mobile, is: 10
  validates :contact_no, allow_blank: true, length: {maximum: 15}

  def as_json(options = {})
    super(except: [:created_at, :updated_at, :vendor_id],
          include: {
              vendor: {
                  only: [:id, :name]
              },
              deals: {
                  include: {
                      #Offers
                  }
              }
          }
    )

  end

end
