class Category < ActiveRecord::Base
  has_many :subcategories
  has_many :vendors
  include FriendlyId
  markable_as :favorite

  validates_presence_of :name, :slug

  friendly_id :name, use: [:slugged, :history]

  def as_json(options={})
    super(options.merge(
              except: [:updated_at, :created_at],
              include: {
                  subcategories: {
                      except: [:created_at, :updated_at, :category_id]
                  }
              }
          ))
  end

end