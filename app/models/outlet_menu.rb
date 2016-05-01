class OutletMenu < ActiveRecord::Base
  belongs_to :outlet
  validates_presence_of :outlet_id, :url
end
