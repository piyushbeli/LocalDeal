class Subcategory < ActiveRecord::Base
  has_many :vendor_subcategories
  has_and_belongs_to_many :vendors, through: :vendor_subcategories
  include FriendlyId

  belongs_to :category
  validates_presence_of :category_id, :name, :slug, :sequence_separator => "---"
  #friendly_id :slug_candidates, use: [:slugged, :history]
  friendly_id do |config|
    config.base = :slug_candidates
    config.use :slugged
    config.sequence_separator = "---"
  end
  #Slug candidate in sequence of priority
  def slug_candidates
    [
        "#{name}",
        "#{category.name} #{name}"
    ]
  end
end