Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  mount_devise_token_auth_for 'Vendor', at: 'auth_vendor',
                              skip: [:omniauth_callbacks, :confirmations],
                              controllers: {
                                          registrations: 'vendor/registrations'
                              }

  mount_devise_token_auth_for 'God', at: 'auth_god'

  devise_scope :user do
    post 'outlets/:outlet_id/favorite' => 'user/users#add_favortite_outlet'
    delete 'outlets/:outlet_id/favorite' => 'user/users#remove_favorite_outlet'
    get 'outlets/favorite' => 'user/users#favorite_outlets'
    post 'categories/favorite' => 'user/users#update_favorite_categories'
    delete 'categories/:category_id/favorite' => 'user/users#remove_favorite_category'
    post 'outlets/:outlet_id/rate' => 'user/users#update_outlet_rating'
  end

  devise_scope member: [:user, :god] do
    #Create an order
    post '/offers/:id/buy' => 'orders#create'

    #Fetch deals with different criteria which also does not need any authentication
    get "/outlets" => "user/outlets#index"
    get "/outlets/:id" => "user/outlets#show"

    #spam/unspam a vendor
    post  "/vendors/:vendor_id/spam"  => "spams#create"
    delete  "/vendors/:vendor_id/spam"  => "spams#destroy"

  end

  devise_scope :member => [:user, :vendor] do
    resources :orders, only: [:index, :show]
  end

  devise_scope :member => [:user, :vendor] do
    resources :outlets, only: [] do
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
      put 'deals/:id/outlets' => 'deals#addOutlets'
    end
  end

  devise_scope :god do
    # Define routes for God within this block.
  end


  #Reference data which does not require any authentication and common for all roles
  get '/categories' => 'reference_data#categories'
  get 'subcategories/:category_id' => 'reference_data#sub_categories'
  get 'offertypes' => 'reference_data#offer_types'
  get 'companysetting' => 'company_setting#show'


  # You can have the root of your site routed with "root"
  root 'application#index'
  #Below lines are important for using htmp5 mode of angularjs. For any resource after /app and /vendor/app we are
  # actually moving to some angular state (no REST url should have this format) so return the application layout.
  get "/vendor/app/*path" => "application#vendor"
  get "/vendor/*path" => "application#vendor"
  get "/app/*path" => "application#index"

end
