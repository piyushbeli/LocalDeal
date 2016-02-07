class OutletImage < ActiveRecord::Base
  belongs_to :uploader, polymorphic: true
  belongs_to :outlet
  belongs_to :comment
  belongs_to :offer
  validates_presence_of :uploader_id, :uploader_type, :outlet_id, :url
end