class Order < ActiveRecord::Base
  include UserResource
  include Vendor::VendorResource

  belongs_to :outlet
  belongs_to :offer
  validates_datetime :expire_at
  validates_presence_of :what_you_get, :expire_at, :user, :vendor

  scope :by_order_key, ->(key = nil) { where("order_no LIKE ?", "%#{key}%") }

  def is_active
    return expire_at > Date.today && !redeemed
  end
end
