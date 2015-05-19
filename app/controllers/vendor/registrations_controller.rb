class Vendor::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def update
    if @resource
      subcategories = Subcategory.where(:id => params[:subcategory_ids])
      @resource.subcategories = subcategories
      if @resource.update_attributes(account_update_params)
        render json: {
                   status: 'success',
                   data: @resource.as_json
               }
      else
        render json: {
                   status: 'error',
                   errors: @resource.errors
               }, status: 403
      end
    else
      render json: {
                 status: 'error',
                 errors: ["User not found."]
             }, status: 404
    end
  end
end