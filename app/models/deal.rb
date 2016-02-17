class Deal < ActiveRecord::Base
    include Vendor::VendorResource
    include FriendlyId

    has_many :offers
    has_many :deals_outlet
    has_many :outlets, through: :deals_outlet
    belongs_to :vendor

    #For Elastic search
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    validates_presence_of :title, :vendor_id
    validates_associated :offers

    friendly_id :slug_candidates, use: [:slugged, :history]

    after_save :update_outlet

    def as_indexed_json(options={})
      self.as_json({
                       only: [:title, :id]
                   })
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
          "#{title}",
          "#{vendor.name} #{title}"
      ]
    end

    def self.search(query)
      __elasticsearch__.search(
          {
              query: {
                  multi_match: {
                      query: query,
                      fields: ['title^10', 'text']
                  }
              }
          }
      )
    end

    def update_outlet
      CacheService.update_entity(self.outlet, true)
    end

end

