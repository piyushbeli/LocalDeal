class Offer < ActiveRecord::Base
  belongs_to :deal
  belongs_to :offer_type
  validates_presence_of :deal_id, :offer_type_id, :discount, :what_you_get, :fine_print, :start_at, :expire_at, :max_no_of_coupons
  validates :discount, numericality: {less_than_or_equal_to: 100}  unless :flat_discount?
  validates_datetime :start_at #, :on_or_after => :today
  validates_datetime :end_at, :after => :start_at
  validates_datetime :expire_at, :after => :end_at

  #For Elastic search
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :orders
  has_many :comments
  has_many :outlet_images

  after_save :update_outlet

  def as_indexed_json(options={})
    self.as_json({
                     only: [:what_you_get, :id]
                 })
  end

  def flat_discount?
    offer_type.upcase == 'FLAT'
  end

  def is_expired?
    return expire_at < Date.today
  end

  def limit_reached?
    return max_no_of_coupons <= no_of_active_orders
  end

  def no_of_active_orders
    return orders.where(['redeemed = 0 and expire_at >= ?', Date.today]).count
  end

  def total_no_of_orders
    return orders.count
  end

  def coupons_remaining
    return max_no_of_coupons - no_of_active_orders
  end

  def total_comments

  end

  def update_outlet
    CacheService.update_entity(self.deal.outlet, true)
  end

end