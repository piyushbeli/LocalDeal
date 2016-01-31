class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  respond_to :json

  def index
    render layout: 'application'
  end

  def vendor
    render layout: 'application'
  end

  protected

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else resource_class == Vendor
      Vendor::ParameterSanitizer.new(Vendor, :vendor, params)
    end
  end

  def record_not_found (e)
    render json: {errors: e.message, status: 404}
  end

end
