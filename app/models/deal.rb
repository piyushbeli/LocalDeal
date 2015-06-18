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

    def as_json(options={})
      super(options.merge(
                       except: [:created_at, :updated_at],
                       include: {
                           outlets: {
                               except: [:created_at, :updated_at]
                           },
                           offers: {
                               except: [:created_at, :updated_at, :deal_id]
                           }
                       }
            ))
    end

    def outletsCount
      outlets.count
    end

    def offerLimitReached?
      offers.count == 5
    end

    #Slug candidate in sequence of priority
    def slug_candidates
      [
          "#{vendor.name} #{title}",
          "#{title}"
      ]
    end

end