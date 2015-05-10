module Vendor::VendorResource
  extend ActiveSupport::Concern

  included do
    belongs_to :vendor
  end
end