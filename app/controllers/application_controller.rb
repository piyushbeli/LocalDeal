class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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

end
