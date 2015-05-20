require 'json'
class User::OutletsController < ApplicationController
  before_action :validateCriteria, only: [:index]
  respond_to :json

  def index
    city_id = params[:city_id]
    category_id = params[:category_id]
    subcategory_ids = params[:subcategory_ids]

    #For distance query
    current_location = params[:current_location]
    show_only_near_by = params[:show_only_near_by]
    near_by_distance = params[:near_by_distance] || 2
    #If user is searching by some particular locality
    street_location = params[:street_location]

=begin
    if !subcategory_ids.nil?
      subcategory_ids = JSON.parse(subcategory_ids)
    end
=end

    if current_location
      #origin for sorting by distance will always be user's current location, because we will show the distance form current location only
      current_location = JSON.parse(current_location)
    end

    if !street_location.nil?
      street_location = JSON.parse(street_location)
    end

    @outlets = Outlet.by_city(city_id)
    @outlets = @outlets.by_category(category_id) unless category_id.nil?
    @outlets = @outlets.by_sub_categories(subcategory_ids) unless subcategory_ids.nil?
    @outlets = @outlets.select('distinct outlets.*')

    #User can either search near by places or by locality/street
    if !show_only_near_by.nil?
      @outlets = @outlets.within(near_by_distance, :origin => current_location) unless current_location.nil?
    elsif !street_location.nil?
      @outlets = @outlets.within(near_by_distance, :origin => street_location)
    end
    @outlets = @outlets.by_distance(:origin => current_location, :units => :kms) unless current_location.nil?
    render 'user/outlets/index'
  end


  def validateCriteria
    if params[:city_id].nil?
      render json: {errors: ["Please select a city before searching the deals"]}, status: 422
    end
    if params[:subcategory_ids] && params[:category_id].nil?
      render json: {errors: ["Please select a category before filtering on subcategory"]}, status: 422
    end
  end
end
