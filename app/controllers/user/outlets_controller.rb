require 'json'
class User::OutletsController < ApplicationController
  before_action :validateCriteria, only: [:index]
  respond_to :json

  def index
    category_id = params[:category_id]
    subcategory_ids = params[:subcategory_ids]

    #For distance query
    current_location = params[:current_location]
    show_only_near_by = params[:show_only_near_by]
    near_by_distance = params[:near_by_distance] || 2
    #If user is searching by some particular locality
    street_location = params[:street_location]
    page = params[:page] || 1
    per_page = params[:per_page]  || 10

    if !subcategory_ids.nil?
      subcategory_ids = subcategory_ids.split(",")
    end

    #If city_id is null then check if
    #Check if street location which has lat/lng is nil then street (text) is available, in this case there will an additional step to geocode the address
    if street_location.nil? && !params[:street].blank?
      street_location = params[:street]
    end
    #User can either search near by places or by locality/street
    if show_only_near_by == true
      @outlets = Outlet.within(near_by_distance, :origin => current_location).distinct unless current_location.nil?
    else
      @outlets = Outlet.within(near_by_distance, :origin => street_location).distinct
    end
    @outlets = @outlets.by_category(category_id) unless category_id.nil?
    @outlets = @outlets.by_sub_categories(subcategory_ids) unless subcategory_ids.nil?

    #@outlets = @outlets.select('distinct')
    @outlets = @outlets.by_distance(:origin => current_location, :units => :kms) unless current_location.nil?
    @outlets = @outlets.paginate(:page => page, :per_page => per_page)
    render 'user/outlets/index'
  end

  def show
    #It's a hack over devise, can not make this route authenticated because it can be accessed by unauthenticated guys
    #also, calling authenticate_user! will render an error message so hacked thos from authenticate_user! method
    set_user_by_token(:user)
    @current_user = current_user
    @outlet = Outlet.friendly.find(params[:id])
    current_location =  params[:current_location]
    #Can not use distance name because that is internally used by order_by_distance query.
    @outlet.distance_from_current_loc = @outlet.distance_from(current_location, :units => :kms) unless current_location.nil?
    render 'user/outlets/show'
  end


  def validateCriteria
    if params[:street_location].nil? && params[:street].blank?
      render json:{errors: ["Invalid criteria"]}, status: 422
    end
    if params[:subcategory_ids] && params[:category_id].nil?
      render json: {errors: ["Please select a category before filtering on subcategory"]}, status: 422
    end
  end
end
