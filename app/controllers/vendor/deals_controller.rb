class Vendor::DealsController < ApplicationController
  before_action :find_deal, except: [:create]
  before_action :verify_ownership, only: [:update]

  caches_action :find_deal

  respond_to :json

  def find_deal
    @deal = Deal.find_by_id(params[:id])
    render json: {errors: ["Deal not found"]},status: 422 if @deal.nil?
  end

  def index
    render json: Deal.All
  end

  def show
    render json: @deal
  end

  def create
    deal = Deal.new(deal_params.merge(vendor_id: current_vendor.id))
    outlets = Outlet.where(:id => params[:outlets_ids])
    deal.outlets << outlets
    if deal.save
      render json: deal
    else
      render json: {errors: deal.errors.full_messages}, status: 422
    end
  end

  def update

  end

  def destroy

  end

  def verify_ownership
    if @deal.vendor.id != current_vendor.id
      render json: {errors: ["Not authorized"]}, status: 401
    end
  end

  def deal_params
    params.require(:deal).permit!
  end
end