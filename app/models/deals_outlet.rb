class DealsOutlet < ActiveRecord::Base
  belongs_to  :deal
  belongs_to  :outlet
  validates :outlet_id, uniqueness: {scope: :deal_id}
end