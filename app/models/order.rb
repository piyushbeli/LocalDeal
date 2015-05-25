class Order < ActiveRecord::Base
  include UserResource
  include Vendor::VendorResource

  validates_datetime :expire_at
  validates_presence_of :what_you_get, :expire_at, :user, :vendor
end
