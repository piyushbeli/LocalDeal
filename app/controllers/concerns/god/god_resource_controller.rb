module GodResourceController
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_god, except: [:show, :index]
  end

end