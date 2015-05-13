class VendorSubcategory < ActiveRecord::Base
  has_many :subcategories
  has_many :vendors

  validates_presence_of :vendor_id, :subcategory_id
end