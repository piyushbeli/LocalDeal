class VendorImage < ActiveRecord::Base
  belongs_to :vendor
  validates_presence_of :vendor_id, :url
end