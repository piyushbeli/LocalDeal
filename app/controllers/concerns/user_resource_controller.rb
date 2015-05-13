module UserResourceController
  extend ActiveSupport::Concern

  included do
    devise_token_auth_group :member, contains: [:user, :god]
    before_action :authenticate_member!, except: [:show, :index]
  end

end