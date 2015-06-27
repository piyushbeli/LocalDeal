class OrdersController < ApplicationController
  include CommonResourceController

  before_filter :authenticate_user!, only: [:create]
  before_filter :authenticate_member!, only: [:show, :index]

  def index
    #Filter and order criteria
    sort_by = params[:sort_by]
    sort_order = params[:sort_order]
    order_status = params[:order_status]
    @orders = current_member.orders
    page = params[:page]

    #Filter orders based on order status
    if order_status == 'active'
      @orders = @orders.where("expire_at > ? and redeemed = false", DateTime.now)
    elsif order_status == 'redeemed'
      @orders = @orders.where("redeemed = true")
    elsif order_status == 'expired'
      @orders = @orders.where("expire_at < ? and redeemed = false", DateTime.now)
    end

    #Sort orders based on criteria (default is different based on order status)
    if sort_by && sort_order
      @orders = @orders.order(sort_by + " " + sort_order)
    elsif order_status == 'active'
      @orders = @orders.order("expire_at ASC")
    elsif order_status == 'expired'
      @orders = @orders.order("expire_at DESC")
    elsif order_status == 'redeemed'
      @orders = @orders.order("created_at DESC")
    end
    per_page = Rails.configuration.x.per_page
    @orders = @orders.paginate(:page => page, :per_page => per_page)

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
                                         expire_at: offer.expire_at,order_no: order_no, created_at: DateTime.now)
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
    if offer.isExpired?
      return "This deal has been expired"
    end
    if current_user.alreadyBoughtTheOffer? (offer)
      return "You have already availed this offer"
    end
    if !current_user.isProfileComplete?
      return "Please complete your profile before buying any deal"
    end
  end

  def generateOrderNo
    length = Rails.configuration.x.order_no_length || 7
    rand(36**length).to_s(36).upcase
  end

end