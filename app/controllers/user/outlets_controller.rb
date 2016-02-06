require 'json'
class User::OutletsController < ApplicationController
  before_action :validateCriteria, only: [:index]
  respond_to :json

  def index
    do_save = params[:save]
    category_id = params[:category_id]
    subcategory_ids = params[:subcategory_ids]

    #For distance query
    current_location = params[:current_location]
    show_only_near_by = params[:show_only_near_by]
    near_by_distance = params[:near_by_distance] || 2
    #If user is searching by some particular locality
    street_location = params[:street_location]
    street = params[:street]
    page = params[:page] || 1
    per_page = params[:per_page]  || Rails.configuration.x.per_page

    if !subcategory_ids.nil?
      subcategory_ids = subcategory_ids.split(",")
    end

    #Save this criteria in user's favorite filters
    if do_save
      success = save_criteria(street, street_location, category_id, subcategory_ids, near_by_distance)
      if !success
        return
      end
    end
    #If user wants to search the nearbuy location only then ignore the street-location even if it is coming in request
    if show_only_near_by == true
      street_location = current_location
    end
    search(street, street_location, current_location, category_id, subcategory_ids, near_by_distance, page, per_page)
  end

  def search (street, street_location, current_location, category_id, subcategory_ids, distance, page, per_page)
    #In cas of search by filters page no won't be available
    page = page || 1
    per_page = per_page  || Rails.configuration.x.per_page

    #Check if street location which has lat/lng is nil then street (text) is available, in this case there will an additional step to geocode the address
    if street_location.nil? && !street.blank?
      street_location = street
    end
    @outlets = Outlet.verified_vendors
    @outlets = @outlets.within(distance, :origin => street_location)
    @outlets = @outlets.by_category(category_id) unless category_id.nil?
    @outlets = @outlets.by_sub_categories(subcategory_ids) unless subcategory_ids.nil?
    @outlets = @outlets.by_distance(:origin => current_location, :units => :kms) unless current_location.nil?
    @total_items = @outlets.count('*')
    @outlets = @outlets.paginate(:page => page, :per_page => per_page)
    render 'user/outlets/index'
  end

  def save_criteria (street, street_location, category_id, subcategory_ids, distance)
    if current_user.nil?
      render json: {errors: ['Please login to save the filer'], status: 401}
      return false
    end
    criteria = {
        street_name: street,
        street_location: street_location,
        category_id: category_id,
        subcategory_ids: subcategory_ids,
        distance: distance
    }
    criteria = MultiJson.dump(criteria)
    myfiler = Myfilter.create(user: current_user, criteria: criteria)
    if myfiler.save
      return true
    else
      render json: {errors: myfiler.errors.full_messages}, status: 422
      return false
    end
  end

  def search_by_filter
    current_location = params[:current_location]
    filter = Myfilter.find(params[:filter_id])
    if filter.user != current_user
      render json: {errors: ['This filter does not belong to you'], status: 401}
      return
    end
    criteria = filter.criteria
    criteria = MultiJson.load(criteria.to_s)
    search(criteria['street_name'], criteria['street_location'], current_location, criteria['category_id'], criteria['subcategory_ids'], criteria['distance'], 1, nil)
  end

  def show
    #It's a hack over devise, can not make this route authenticated because it can be accessed by unauthenticated guys
    #also, calling authenticate_user! will render an error message so hacked those from authenticate_user! method
    set_user_by_token(:user)
    @current_user = current_user
    @outlet = Outlet.friendly.find(params[:id])
    current_location =  params[:current_location]
    #Can not use distance name because that is internally used by order_by_distance query.
    @outlet.distance_from_current_loc = @outlet.distance_from(current_location, :units => :kms) unless current_location.nil?
    render 'user/outlets/show'
    rescue ActiveRecord::RecordNotFound => e
      render :json=> {errors: ["outlet not found"], status: 404}
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
