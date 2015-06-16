class Vendor::OutletsController < ApplicationController
  include Vendor::VendorResourceController

  before_action :fetch_outlet, only: [:show, :update]
  before_action :verify_ownership, except: [:create]


  def fetch_outlet
    @outlet = Outlet.friendly.find(params[:id])
  end

  def verify_ownership
    if @outlet.vendor.id != current_vendor.id
      render json: {succcess: false, errors: ["Not authorized"]}, status: 401
    end
  end

  def show
    render json: @outlet
  end

  def create
    outlet = Outlet.new(outlet_params.merge(vendor_id: current_vendor.id))
    if outlet.save()
      render json: outlet
    else
      render json: {errors: outlet.errors.full_messages}, status: 422
    end
  end

  def update
    if @outlet.update(outlet_params)
      render json: {success: true}, status:200
    else
      render json: {success: false, errors: @outlet.errors.full_messages}, status: 422
    end
  end

  def outlet_params
    params.require(:outlet).permit!
  end

end