class User::UsersController < ApplicationController

  before_action :authenticate_user!

  def favorite_outlets
    current_location = params[:current_location]
    @outlets = Outlet.marked_as :favorite , :by => current_user
    @total_items = @outlets.count
    @outlets = @outlets.by_distance(:origin => current_location, :units => :kms) unless current_location.nil?
    render 'user/outlets/index'
  end

  def add_favortite_outlet
    outlet = Outlet.friendly.find(params[:outlet_id])
    if current_user.mark_as_favorite  outlet
      render json: {success: true}
    else
      render json:{errors: ['Some error occurred']}, status: 422
    end
  end

  def remove_favorite_outlet
    outlet = Outlet.friendly.find(params[:outlet_id])
    #Call unmark only if this guy has marked the outlet as favorite
    if outlet.marked_as? :favorite, :by => current_user
      outlet.unmark :favorite, :by => current_user
      render json: {success: true}
    else
      render json: {errors: ['This is already not a your favorite outlet'], status: 422}
    end
    #TODO Check if we can handle the error here.

  end

  def update_favorite_categories
    if params[:category_ids].blank?
      current_favorite_categories = current_user.categories_marked_as_favorite
      current_user.favorite_categories.delete current_favorite_categories
      render json: {success: true}
      return
    end

    current_favorite_category_ids = current_user.categories_marked_as_favorite.pluck(:id)
    input_categories = Category.friendly.find(params[:category_ids])
    new_categories = input_categories.select do
      |c|
      !current_favorite_category_ids.include?(c.id)
    end

    remove_categories = current_favorite_category_ids.select do
      |c|
      !params[:category_ids].include?(c)
    end
    remove_categories = Category.friendly.find(remove_categories)
    current_user.remove_mark :favorite,  remove_categories
    current_user.mark_as_favorite  new_categories
    render json: {success: true}
  end

  def update_outlet_rating
    dimension = "service" #this is constant for now because we are rating on overall basis
    outlet = Outlet.friendly.find(params[:outlet_id])
    stars = params[:stars]
    if outlet.nil?
      render json: {errors: ["Outlet not found"]}, status: 422
      return
    end
    if stars.blank?
      render json: {errors: ["Rating can not be empty"]}, status: 422
      return
    end
    if outlet.rate params[:stars].to_f, current_user, dimension
      render json: {success: true}
    else
      render json: {errors: ["Error occurred while rating"]}, status: 422
    end
  end

  def follow_user
    user = User.friendly.find(params[:user_id])
    if user == current_user
      render json: {erros: ['you can not follow yourself'], status: 422}
      return
    end
    if current_user.mark_as_following user
      render json: {success: true}
      return
    else
      render json: {errors: ['some error has occurred'], status: 422}
    end
  end

  def unfollow_user
    user = User.friendly.find(params[:user_id])
    if user.marked_as? :following, :by => current_user
      user.unmark :following, :by => current_user
      render json: {success: true}
    else
      render json: {errors: ['You are not following this user anyways'], status: 422}
    end
  end

  def filters
    @filters = current_user.myfilters
    render 'user/filters/index'
  end

end