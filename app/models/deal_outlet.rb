class DealOutlet < ActiveRecord::Base
  has_many :deals
  has_many :outlets
end