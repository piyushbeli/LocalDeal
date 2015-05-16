class OffersController < ApplicationController
  include VendorResourceController

  before_action :find_offer, only: [:show, :update]
  before_action :verify_ownership, only: [:update, :destroy]

  def find_offer
    @offer = Offer.All(:deal_id => params[:deal_id])
  end

  def show
    render 'vendor/offers/show'
  end

  def create
    @offer = Offer.new(offer_params.merge(:vendor_id => current_vendor.id))
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
    if @deal.vendor.id != current_vendor.id
      render json: {errors: ["Not authorized"]}, status: 401
    end
  end

  def offer_params
    params.require(:offer).permit!
  end
end