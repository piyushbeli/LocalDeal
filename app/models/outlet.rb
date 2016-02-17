require 'elasticsearch/model'

class Outlet < ActiveRecord::Base
  include Vendor::VendorResource
  include Commentable
  include FriendlyId
  markable_as :favorite

  #For Elastic search
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

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

  validates_presence_of :city_id, :vendor_id, :latitude, :longitude, :name, :mobile, :city, :street, :street_id, :slug, :city_latitude, :city_longitude, :street_latitude, :street_longitude
  validates_format_of :latitude, :longitude, :city_latitude, :city_longitude, :street_latitude, :street_longitude, with: /\A\d{1,9}\.?\d{0,6}\z/
  validates_length_of :mobile, is: 10
  validates :contact_no, allow_blank: true, length: {maximum: 15}

  scope :verified_vendors, -> {joins(:vendor).where("vendors.is_verified = true")}
  scope :by_city, ->(id = nil) { where("city_id = ?", "#{id}") }
  scope :by_category, ->(id = nil) { joins(:vendor).where("vendors.category_id = ?", id) }
  scope :by_street, ->(id = nil) { where("street_id = ?", "#{id}") }
  scope :by_sub_categories, ->(subcategory_ids) { joins(:vendor => :subcategories).where("subcategories.id IN (?)", subcategory_ids) }

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

  def self.search(query)
    __elasticsearch__.search(
        {
            query: {
                multi_match: {
                    query: query,
                    fields: ['name^10']
                }
            }
        }
    )
  end

  def as_indexed_json(options={})
    self.as_json({
                     only: [:name, :id]
                 })
  end

  def update_outlet
    CacheService.update_entity(self.includes(:deals, :vendor), true)
  end

end

