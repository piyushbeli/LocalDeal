class OrdersController < ApplicationController
  include CommonResourceController

  before_filter :authenticate_user!, only: [:create]
  before_filter :authenticate_member!, only: [:show, :index]

  def index
    @orders = current_member.orders
    if current_user
      render 'user/orders/index'
    elsif
      render 'vendor/orders/index'
    end

  end

  def show
    #We are actually sending order_no from the client request in the id parameter.
    @order = Order.find_by_order_no(params[:id])
    if current_user && current_user.id == @order.user_id
      render 'user/orders/show'
    elsif current_vendor && current_vendor.id == @order.vendor_id
      render 'vendor/orders/show'
    else
      render json: {errors: ["You are not authorized to see this order"]}, status: 422
    end
  end

  def create
    offer = Offer.find(params[:id])
    message = validateOffer(offer)
    if !message.blank?
      render json: {errors: [message]}, status: 422
      return
    end

    vendor_id = offer.deal.vendor.id
    order_no = generateOrderNo
    order = Order.new(offer_id: offer.id, user_id: current_user.id, vendor_id: vendor_id, what_you_get: offer.what_you_get,
                      fine_print: offer.fine_print, instruction: offer.instruction, redeemed: false,
                                         expire_at: offer.expire_at,order_no: order_no)
    if order.save
      render json: {success: true}
    else
      render json: {errors: order.errors.full_messages}, status: 422
    end

  end

  def validateOffer(offer)
    if offer.nil?
      return "Offer does not exist"
    end
    if offer.isExpired?l
      return "This deal has been expired"
    end
    if current_user.alreadyBoughtTheOffer? (offer)
      return "You have already availed this offer"
    end
    if current_user.validateProfileCompletness?
      return "Please complete your profile before buying any dea"
    end
  end

  def generateOrderNo
    length = Rails.configuration.x.order_no_length || 7
    rand(36**length).to_s(36).upcase
  end

end