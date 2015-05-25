class OrdersController < ApplicationController
  include CommonResourceController

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
    elsif curent_vendor && current_vendor.id == @order_vendor_id
      render 'vendor/orders/show'
    else
      render json: {errors: ["You are not authorized to see this order"]}, status: 422
    end
  end

  def create
    offer = Offer.find(params[:id])
    if offer.nil?
      render json: {errors: ["Offer does not exist"]}, status: 422
      return
    end
    if offer.isExpired?
      render json: {errors: ["This deal has been expired"]}, status: 422
      return
    end
    if current_user.nil?
      render json: {errors: ["Not authorized"]}, status: 422
      return
    end
    if current_user.alreadyBoughtTheOffer? (offer)
      render json: {errors: ["You have already availed this offer"]}, status: 422
      return
    end

    vendor_id = offer.deal.vendor.id
    length = Rails.configuration.x.order_no_length
    order_no = rand(36**length).to_s(36).upcase
    order = Order.new(order_params.merge(offer_id: offer.id, user_id: current_user.id, vendor_id: vendor_id, what_you_get: offer.what_you_get,
                      fine_print: offer.fine_print, instruction: offer.instruction, redeemed: false,
                                         expire_at: offer.expire_at,order_no: order_no))
    if order.save
      render json: {success: true}
    else
      render json: {errors: order.errors.full_messages}, status: 422
    end

  end

  def order_params
    params.require(:order).permit(:outlet_id)
  end
end