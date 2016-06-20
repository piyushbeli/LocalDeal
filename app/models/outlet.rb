class Outlet < ActiveRecord::Base
  include Vendor::VendorResource
  include Commentable
  include FriendlyId
  markable_as :favorite

  #For Elastic search
  searchkick text_middle: [:name]

  ratyrate_rateable "service"

  friendly_id :slug_candidates, use: [:slugged, :history]
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  attr_accessor :distance_from_current_loc, :average_rating, :no_of_raters

  has_many :deals_outlets
  has_many :deals, through: :deals_outlets ,dependent: :destroy
  belongs_to :vendor
  has_many :outlet_images
  has_many :outlet_menus

  validates_presence_of :city_id, :vendor_id, :latitude, :longitude, :name, :mobile, :city, :street, :street_id, :slug, :city_latitude, :city_longitude, :street_latitude, :street_longitude
  validates_format_of :latitude, :longitude, :city_latitude, :city_longitude, :street_latitude, :street_longitude, with: /\A\d{1,9}\.?\d{0,6}\z/
  validates_length_of :mobile, is: 10
  validates :contact_no, allow_blank: true, length: {maximum: 15}

  scope :verified_vendors, -> {joins(:vendor).where("vendors.is_verified = true")}
  scope :by_city, ->(id = nil) { where("city_id = ?", "#{id}") }
  scope :by_category, ->(id = nil) { joins(:vendor).where("vendors.category_id = ?", id) }
  scope :by_street, ->(id = nil) { where("street_id = ?", "#{id}") }
  scope :by_sub_categories, ->(subcategory_ids) { joins(:vendor => :subcategories).where("subcategories.id IN (?)", subcategory_ids) }
  scope :with_active_offer, -> () { joins(:deals => :offers).where("offers.end_at > now()")}

  after_save :update_outlet

  def attributes
    super.merge({average_rating: average_rating, no_of_raters: no_of_raters})
  end

  #Slug candidate in sequence of priority
  def slug_candidates
    [
        "#{name} #{street}",
        "#{name} #{street} #{latitude} #{longitude}"
    ]
  end

  def user_rating (user)
    if !user || user.nil?
      return nil
    else
      rating = user.ratings_given.where(dimension: "service", rateable_id: self.id, rateable_type: self.class.name)
      return rating[0].stars unless rating.blank?
    end
  end

  def average_rating
    rating = self.average("service")
    return rating.avg unless rating.nil?
  end

  def no_of_raters
    self.raters("service").count
  end

  def offers_summary
    all_deals = self.deals.includes('offers')
    total_bought_offers = 0
    total_offers_remaining = 0
    best_discounted_offer = {}

    all_deals.each do |deal|
      offers = deal.offers.includes('orders')
      best_discounted_offer = offers[0]
      offers.each do |offer|
        best_discounted_offer = offer unless best_discounted_offer.discount > offer.discount
        total_bought_offers += offer.orders.count
        total_offers_remaining += offer.max_no_of_coupons
      end
    end
    summary = {
        total_bought_offers: total_bought_offers,
        total_offers_remaining: total_offers_remaining,
        best_offer: best_discounted_offer.as_json.extract!('discount', 'actual_price', 'offered_price')
    }
    return summary
  end

  def search_data
    as_json only: [:name, :slug, :street, :city]
  end

  def detail_json
    outlet_json = Rabl::Renderer.new('user/outlets/show', self).render
  end

  def update_outlet
    CacheService.update_entity(self, true)
  end

end

