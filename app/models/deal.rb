class Deal < ActiveRecord::Base
    include Vendor::VendorResource
    include FriendlyId

    has_many :offers
    has_many :deals_outlet
    has_many :outlets, through: :deals_outlet
    belongs_to :vendor

    validates_presence_of :title, :vendor_id
    validates_associated :offers

    friendly_id :slug_candidates, use: [:slugged, :history]

    after_save :update_outlets

    def outletsCount
      outlets.count
    end

    def offerLimitReached?
      offers.count == 5
    end

    #Slug candidate in sequence of priority
    def slug_candidates
      [
          "#{title}",
          "#{vendor.name} #{title}"
      ]
    end

    def update_outlets
      for outlet in outlets
        CacheService.update_entity(outlet, true)
      end
    end

    def open_offers
      self.offers.select {
          |o| o.is_closed != 1
      }
    end

end

