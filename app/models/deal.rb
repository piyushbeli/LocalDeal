class Deal < ActiveRecord::Base
    include Vendor::VendorResource
    include Commentable

    has_many :offers
    has_many :deal_outlets
    has_and_belongs_to_many :outlets, through: :deal_outlets
    belongs_to :vendor

    validates_presence_of :title, :vendor_id
    validates_associated :offers

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
      outlets.length
    end

    def offerCountLimitReached?
      offers.length == 5
    end

end