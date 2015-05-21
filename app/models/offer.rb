class Offer < ActiveRecord::Base
  belongs_to :deal
  belongs_to :offer_type
  validates_presence_of :deal_id, :offer_type_id, :discount, :what_you_get, :fine_print, :start_time, :expire_time
  validates :discount, numericality: {less_than_or_equal_to: 100} #, if: :flat_discount?
  validates_datetime :start_time, :expire_time
  validates_datetime :start_time, :on_or_after => :today
  validates_datetime :expire_time, :after => :start_time

  def flat_discount?
    offer_type.upcase == 'FLAT'
  end

end