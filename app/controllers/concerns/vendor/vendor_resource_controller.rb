module Vendor::VendorResourceController
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_vendor!
  end

end