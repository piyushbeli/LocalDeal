module CommonResourceController
  extend ActiveSupport::Concern
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected
  def check_valid_signin
    render json: [{errors: ['Unauthorized access']}, status: 401] unless member_signed_in?
  end

  included do
    devise_token_auth_group :member, contains: [:user, :vendor, :god]
    before_action :authenticate_member!
    before_action :check_valid_signin
  end

end