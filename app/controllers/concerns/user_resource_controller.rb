module UserResourceController
  extend ActiveSupport::Concern
  include DeviseTokenAuth::Concerns::SetUserByToken

  included do
    devise_token_auth_group :member, contains: [:user, :god]
    before_filter :authenticate_member!, except: [:show, :index]
  end

end