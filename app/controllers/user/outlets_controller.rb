require 'json'
class User::OutletsController < ApplicationController
  devise_token_auth_group :member, contains: [:user, :god]
  before_action :validateCriteria, only: [:index]
  respond_to :json

  def index
    do_save = params[:save]
    category_id = params[:category_id]
    if params[:category]
      category_id = Category.friendly.find(params[:category])['id']
    end
    subcategory_ids = params[:subcategory_ids]

    #For distance query
    current_location = params[:current_location]
    show_only_near_by = params[:show_only_near_by]
    near_by_distance = params[:near_by_distance]
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
    if street_location.nil?
      if !street.blank?
        street_location = street
      else
        street_location = current_location
      end
    end
    @outlets = Outlet.verified_vendors
    @outlets = @outlets.within(distance, :origin => street_location) unless (street_location.nil? || distance.nil?)
    @outlets = @outlets.by_category(category_id) unless category_id.nil?
    @outlets = @outlets.by_sub_categories(subcategory_ids) unless subcategory_ids.nil?
    @outlets = @outlets.by_distance(:origin => current_location, :units => :kms) unless current_location.nil?
    @total_items = @outlets.count('*')
    @outlets = @outlets.paginate(:page => page, :per_page => per_page)
    @current_user = current_user
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
    my_filter = Myfilter.create(user: current_user, criteria: criteria)
    if my_filter.save
      return true
    else
      render json: {errors: my_filter.errors.full_messages}, status: 422
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
    #Disable the outlet caching for now. It's creating inconsistency.
    #outlet = CacheService.fetch_entity('Outlet', params[:id])
    outlet = Outlet.includes(:deals, :vendor, :outlet_images).friendly.find(params[:id])
=begin
    if outlet.nil?
      outlet = Outlet.includes(:deals, :vendor, :outlet_images).friendly.find(params[:id])
      outlet = CacheService.add_entity(outlet, true)
    else
      puts 'outlet from cache: ' + params[:id]
    end
    outlet = JSON.parse(outlet)
=end

    current_location =  params[:current_location]
    current_geo_code = Geokit::Geocoders::GoogleGeocoder.geocode(current_location)
    outlet_geo_code = Geokit::Geocoders::GoogleGeocoder.geocode([outlet['latitude'], outlet['longitude']].join(','))
    distance_from_current_loc = current_geo_code.distance_to(outlet_geo_code)
    #outlet_instance = Outlet.new({id: outlet['id']})
    #current_user_rating = outlet_instance.user_rating(current_user) unless current_user.nil?
    outlet['distance'] = distance_from_current_loc
    current_user_rating = outlet.user_rating(current_user) unless current_user.nil?
    outlet['user_rating'] = current_user_rating
    #outlet['marked_as_favorite'] = outlet_instance.marked_as? :favorite, :by => current_user unless current_user.nil?
    outlet['marked_as_favorite'] = outlet.marked_as? :favorite, :by => current_user unless current_user.nil?
    render json: outlet
  end


  def validateCriteria
    if params[:subcategory_ids] && params[:category_id].nil?
      render json: {errors: ['Please select a category before filtering on subcategory']}, status: 422
    end
  end

  def offer_count_by_categories
    offer_deal_join = Offer.joins(deal: {vendor: {category: {}}})
    offer_count_by_category = offer_deal_join.select('categories.id, categories.name, count(offers.id) as no_of_offers ').group('categories.id').where('offers.expire_at > ?', DateTime.now)
    all_categories = Category.all.as_json
    offer_count_by_category = offer_count_by_category.as_json
    offer_count_by_category_map = {}
    offer_count_by_category.each do |offer_count|
      offer_count_by_category_map[offer_count['name']] = offer_count['no_of_offers']
    end
    result = []
    all_categories.each do |category|
      category = category.except('id', 'subcategories')
      category['offer_count'] = offer_count_by_category_map[category['name']] || 0
      result.push(category)
    end
    render json: {data: result, success: true}
  end

  def outlet_images
    outlet_id = params[:outlet_id]
    outlet = Outlet.friendly.find(outlet_id)
    comment_id = params[:comment_id]
    offer_id = params[:offer_id]
    key = 'Outlet-' + outlet.slug + '-images'
    key = (key + '-offer-' + offer_id.to_s) unless offer_id.nil?
    key = (key + '-comment-' + comment_id.to_s) unless comment_id.nil?
    #TODO: For now lets not cache the outlet images
    output = nil
    #output = CacheService.fetch_key(key)
    #per_page = params[:per_page] || Rails.configuration.x.per_page
    #page = params[:page] || 1
    if output.nil?
      @images = OutletImage.where(:outlet => outlet)
      @images = @images.where(:comment_id => comment_id) unless comment_id.nil?
      @images = @images.where(:offer_id => offer_id) unless offer_id.nil?
      output = Rabl::Renderer.new('user/outlets/images', @images).render
      CacheService.update_key(key, output)
    end

    #Lets not paginate the images, we can fetch all image urls in once.
    #@images = @images.paginate(:per_page => per_page, :page => page)
    render json:output
  end

  def outlet_menus
    outlet_id = params[:outlet_id]
    outlet = Outlet.friendly.find(outlet_id)
    key = 'Outlet-' + outlet.slug + '-menus'
    #TODO: For now lets not cache the outlet menus
    output = nil
    #output = CacheService.fetch_key(key)
    if output.nil?
      @menus = OutletMenu.where(:outlet => outlet)
      output = Rabl::Renderer.new('user/outlets/menus', @menus).render
      CacheService.update_key(key, output)
    end
    render json:output
  end

end
