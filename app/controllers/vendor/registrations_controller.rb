class Vendor::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :authenticate_vendor!, only: [:update]

  def update
    if @resource
      subcategories = Subcategory.where(:id => params[:subcategory_ids])
      @resource.subcategories = subcategories
      super
    end
  end
end
