class Outlet < ActiveRecord::Base
  include Vendor::VendorResource
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  has_many :deal_outlets
  has_and_belongs_to_many :deals, through: :deal_outlets ,dependent: :destroy

  validates_presence_of :city_id, :vendor_id, :latitude, :longitude, :name, :mobile, :city, :street, :street_id
  validates_format_of :latitude, :longitude, with: /\A\d{1,9}\.?\d{0,6}\z/
  validates_length_of :mobile, is: 10
  validates :contact_no, allow_blank: true, length: {maximum: 15}

  scope :by_city, ->(id = nil) { where("city_id = ?", "#{id}") }
  scope :by_category, ->(id = nil) { joins(:vendor).where("vendors.category_id = ?", id) }
  scope :by_street, ->(id = nil) { where("street_id = ?", "#{id}") }
  scope :by_sub_categories, ->(subcategory_ids) { joins(:vendor => :subcategories).where("subcategories.id IN (?)", subcategory_ids) }


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
