class Subcategory < ActiveRecord::Base
  has_many :vendor_subcategories
  has_and_belongs_to_many :vendors, through: :vendor_subcategories

  validates_presence_of :category_id, :name
end