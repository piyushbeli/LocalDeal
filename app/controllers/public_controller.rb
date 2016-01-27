class PublicController < ApplicationController
  #This controler does not require any authentication

  def user
    user_id = params[:slug]
    @user =  User.friendly.find(user_id)
    render '/public/user/show'
  end

  def vendor
    vendor_id = params[:slug]
    @vendor = Vendor.friendly.find(vendor_id)
    render 'public/vendor/show'
  end

end