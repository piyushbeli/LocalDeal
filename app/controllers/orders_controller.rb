class OrdersController < ApplicationController
  include CommonResourceController

  #before_action :authenticate_user!, only: [:create]
  before_action :authenticate_member!, only: [:create, :show, :index]
  before_action :find_order, only: [:show, :destroy]

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

  def find_order
    #We are actually sending order_no from the client request in the id parameter.
    @order = Order.find_by_order_no(params[:id])
    if @order.nil?
      render json: {errors: ['Order not found'], status: 422}
    end
  end

  def show

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
    if offer.has_ended?
      return "Time finished to avail this deal"
    end
    if offer.limit_reached?
      return 'Sold out'
    end
    if current_user.has_active_order? (offer.deal.vendor.category)
      return 'You already have an active coupon'
    end
    if !current_user.is_verified
      return  'You can not buy the any deal before verifying your number.'
    end
  end

  def generateOrderNo
    length = Rails.configuration.x.order_no_length || 7
    rand(36**length).to_s(36).upcase
  end

  def destroy
    if !@order.is_active
      render json: {errors: ['Only active order can be cancelled'], status: 401}
      return
    end
    if current_user && current_user.id == @order.user_id
      @order.delete
      render json: {success: true}
    else
      render json: {errors: ['You are not the owner of this order'], status: 401}
    end
  end

end