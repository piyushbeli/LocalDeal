module UserResourceController
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!, except: [:show, :index]
  end


end