class Vendor::DealsController < ApplicationController
  #Commentout this line after development testing
  include Vendor::VendorResourceController

  before_action :find_deal, except: [:create, :index]
  before_action :verify_ownership, only: [:update, :destroy, :removeOutlet]

  caches_action :show, expires_in: 5.minutes #A deal rarely changes after creation so lets cache it for some time.
  caches_action :index, expires_in: 5.minutes

  respond_to :json

  def find_deal
    @deal = Deal.find_by_id(params[:id])
    render json: {errors: ["Deal not found"]},status: 422 if @deal.nil?
  end

  def index
    @deals =  Deal.where(:vendor_id => current_vendor.id)
    render 'vendor/deals/index'
  end

  def show
    render 'vendor/deals/show'
  end

  def create
    if current_vendor.dealCountLimitReached?
      render json: {errors: ["You have reached limit of creating deal under your account, but you can still update some older deal"]}, status: 422
      return
    end
    deal = Deal.new(deal_create_params.merge(vendor_id: current_vendor.id))
    outlets = Outlet.where(:id => params[:outlets])
    deal.outlets << outlets
    if deal.save
      render json: deal
    else
      render json: {errors: deal.errors.full_messages}, status: 422
    end
  end

  def update
    if @deal.update(deal_update_params)
      render json: {success:true}
    else
      render json: {errors: @deal.errors.full_messages}, status: 422
    end
  end

  def destroy
    render json: {errors: ["Not authorized to delete a deal"]}, status: 422
  end

  def removeOutlet
    outlet = Outlet.find_by_id(params[:outlet_id])
    @deal.outlets.delete(outlet)
    if @deal.save
      render json: {success: true}
    else
      render json: {errors: @deal.errors.full_messages}, status: 422
    end
  end

  def addOutlet
    outlet = Outlet.find_by_id(params[:outlet_id])
    @deal.outlets.add(outlet)
    if @deal.save
      render json: {success: true}
    else
      render json: {errors: @deal.errors.full_messages}, status: 422
    end
  end

  def verify_ownership
    if @deal.vendor.id != current_vendor.id
      render json: {errors: ["Not authorized"]}, status: 401
    end
  end

  def deal_create_params
    params.require(:deal).permit!
  end

  def deal_update_params
    params.require(:deal).permit(:title, :description)
  end

end