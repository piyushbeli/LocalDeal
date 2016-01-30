class OutletImage < ActiveRecord::Base
  belongs_to :uploader, polymorphic: true
  belongs_to :outlet
  validates_presence_of :uploader_id, :uploader_type, :outlet_id, :url
end