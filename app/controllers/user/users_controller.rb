class User::UsersController < ApplicationController

  before_action :authenticate_user!

  def favoriteOutlets
    current_location = params[:current_location]
    @outlets = Outlet.marked_as :favorite , :by => current_user
    @outlets = @outlets.by_distance(:origin => current_location, :units => :kms) unless current_location.nil?
    render 'user/outlets/index'
  end

  def addFavortiteOutlet
    outlet = Outlet.friendly.find(params[:outlet_id])
    if current_user.mark_as_favorite  outlet
      render json: {success: true}
    else
      render json:{errors: ["Some error occurred"]}, status: 422
    end
  end

  def removeFavoriteOutlet
    outlet = Outlet.friendly.find(params[:outlet_id])
    outlet.unmark :favorite, :by => current_user
    #TODO Check if we can handle the error here.
    render json: {success: true}
  end

end