class Vendor::OffersController < ApplicationController
  include Vendor::VendorResourceController

  before_action :find_offer, only: [:show, :update]
  before_action :verify_ownership, only: [:update, :destroy, :create]

  def find_offer
    @offer = Offer.find_by_id(params[:id])
  end

  def show
    render 'vendor/offers/show'
  end

  def create
    @offer = Offer.new(offer_params.merge(:deal_id => @deal.id))
    if @offer.save
      render 'vendor/offers/show'
    else
      render json: {errors: @offer.errors.full_messages}, status: 422
    end
  end

  def update
    if @offer.update(offer_params)
      render json: {success: true}
    else
      render json: {errors: @offer.errors.full_messages}, status: 422
    end
  end

  def verify_ownership
    @deal = Deal.friendly.find(params[:deal_id])
    if @deal.vendor.id != current_vendor.id
      render json: {errors: ["Not authorized"]}, status: 401
    end
    #Allow only 5 offers per deal
    if @deal.offerLimitReached?
      render json: {errors: ["You have reached limit of creating offers under this deal, but you can still update some older offer"]}, status: 422
      return
    end
  end

  def offer_params
    params.require(:offer).permit!
  end
end