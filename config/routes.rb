Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  mount_devise_token_auth_for 'Vendor', at: 'auth_vendor',
                              skip: [:omniauth_callbacks],
                              controllers: {
                                          registrations: 'vendor/registrations'
                              }

  mount_devise_token_auth_for 'God', at: 'auth_god'

  devise_scope :member => [:user, :vendor] do
    resources :deals, only: [] do
      resources :comments, only: [:index, :show, :create, :update, :destroy]
    end
    resources :comments, only: [] do
      resources :comments, only: [:index, :create, :update, :destroy]
    end
  end

  devise_scope :vendor do
    get '/vendor' => 'application#vendor'
    namespace :vendor do
      resources :outlets, only: [:create, :update, :destroy, :index, :show]
      resources :deals, only: [:create, :update, :destroy, :index, :show] do
        resources :offers, only: [:create, :update, :destroy]
        resources :comments, only: [:create, :update, :destroy, :index]
      end

      #Remove an outlet from deal.
      delete 'deals/:id/outlets/:outlet_id' => 'deals#removeOutlet'
    end
  end

  devise_scope :god do
    # Define routes for God within this block.
  end


  #Reference data which does not require any authentication and common for all roles
  get '/categories' => 'reference_data#categories'
  get 'subcategories/:category_id' => 'reference_data#sub_categories'
  get 'offertypes' => 'reference_data#offer_types'


  #Fetch deals with different criteria which also does not need any authentication
  get "/outlets" => "user/outlets#index"
  get "/outlets/:id" => "user/outlets#show"

  # You can have the root of your site routed with "root"
  root 'application#index'
  #Below 2 lines are important for using htmp5 mode of angularjs. For any resource after /app and /vendor/app we are
  # actually moving to some angular state (no REST url should have this format) so return the application layout.
  get "/vendor/app/*path" => "application#vendor"
  get "/app/*path" => "application#index"

end
