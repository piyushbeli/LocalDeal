class PublicController < ApplicationController
  #This controler does not require any authentication

  def user
    user_id = params[:slug]
    @user =  User.friendly.find(user_id)
    render '/public/user/show'
    rescue ActiveRecord::RecordNotFound => e
      render :json=> {errors: ["user not found"], status: 404}
  end

  def vendor
    vendor_id = params[:slug]
    @vendor = Vendor.friendly.find(vendor_id)
    render 'public/vendor/show'
    rescue ActiveRecord::RecordNotFound => e
      render :json=> {errors: ["vendor not found"], status: 404}
  end

  def heartbeat
    render json: {success: true}
  end

end