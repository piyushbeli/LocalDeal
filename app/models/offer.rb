class Offer < ActiveRecord::Base
  belongs_to :deal
  belongs_to :offer_type
  validates_presence_of :deal_id, :offer_type_id, :discount, :what_you_get, :fine_print, :start_at, :expire_at, :max_no_of_coupons
  validates_presence_of :discount, if: :fixed_percent?
  validates :discount, numericality: {less_than_or_equal_to: 100}, if: :fixed_percent?
  validates_presence_of :actual_price, :offered_price, if: :special_offer?
  validates :actual_price, :offered_price, numericality:  {greater_than: 0}, if: :special_offer?
  validate :offered_price_not_greater_than_actual_price, if: :special_offer?
  validates_datetime :start_at #, :on_or_after => :today
  validates_datetime :end_at, :after => :start_at
  validates_datetime :expire_at, :after => :end_at

  #For Elastic search
  searchkick text_middle: [:what_you_get]

  has_many :orders
  has_many :comments
  has_many :outlet_images

  after_save :update_outlets
  before_save :calculate_percent

  def search_data(options={})
    as_json({
                     only: [:what_you_get, :id, :slug, :offered_price, :actual_price, :discount]
                 })
  end

  def fixed_percent?
    return offer_type.name.upcase == 'FIXED_PERCENT'
  end

  def special_offer?
    return offer_type.name.upcase == 'SPECIAL_DISCOUNTED_PRICE'
  end

  def is_expired?
    return expire_at < Date.today
  end

  def has_ended?
    return end_at < Date.today
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

  def update_outlets
    self.deal.update_outlets
  end

  def offered_price_not_greater_than_actual_price
    if offered_price && actual_price && offered_price > actual_price
      errors.add(:offered_price, 'can not be greater than actual price')
    end
  end

  def calculate_percent
    if offer_type.name == 'SPECIAL_DISCOUNTED_PRICE' && offered_price != 0
        self.discount = (offered_price.to_f/actual_price)*100
    end
  end

  def should_index?
    !is_expired?
  end

end