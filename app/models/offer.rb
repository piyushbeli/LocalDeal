class Offer < ActiveRecord::Base
  belongs_to :deal
  validates_presence_of :deal_id, :offer_type_id, :discount, :what_you_get, :start_time, :end_time
  validates :discount, numericality: {less_than_or_equal_to: 100}, if: :flat_discount?

  def flat_discount
    offer_type.upcase == 'FLAT'
  end
end