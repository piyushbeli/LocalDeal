module CommonResourceController
  extend ActiveSupport::Concern
  include DeviseTokenAuth::Concerns::SetUserByToken

  included do
    devise_token_auth_group :member, contains: [:user, :vendor, :god]
    before_action :authenticate_member!
  end

end