class Order < ActiveRecord::Base
  include UserResource
  include Vendor::VendorResource

  belongs_to :outlet
  belongs_to :offer
  validates_datetime :expire_at
  validates_presence_of :what_you_get, :expire_at, :user, :vendor

  def is_active
    return expire_at > Date.today
  end
end
