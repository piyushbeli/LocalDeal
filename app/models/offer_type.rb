class OfferType < ActiveRecord::Base
  #has_many :offers

  validates_presence_of :type

end