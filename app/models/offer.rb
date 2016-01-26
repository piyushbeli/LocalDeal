class Offer < ActiveRecord::Base
  belongs_to :deal
  belongs_to :offer_type
  validates_presence_of :deal_id, :offer_type_id, :discount, :what_you_get, :fine_print, :start_at, :expire_at
  validates :discount, numericality: {less_than_or_equal_to: 100}  unless :flat_discount?
  validates_datetime :start_at #, :on_or_after => :today
  validates_datetime :expire_at, :after => :start_time

  #For Elastic search
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  def as_indexed_json(options={})
    self.as_json({
                     only: [:what_you_get, :id]
                 })
  end

  def flat_discount?
    offer_type.upcase == 'FLAT'
  end

  def isExpired?
    expire_at <= Date.today
  end

end