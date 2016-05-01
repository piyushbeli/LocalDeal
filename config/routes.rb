Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth',
                              controllers: {
                                  :omniauth_callbacks => 'user/omniauth_callbacks'
                              }

  mount_devise_token_auth_for 'Vendor', at: 'auth_vendor',
                              controllers: {
                                          registrations: 'vendor/registrations'
                              }

  mount_devise_token_auth_for 'God', at: 'auth_god'

  devise_scope :user do
    post '/mobile/auth/:provider' => 'user/omniauth_callbacks#mobile_signin'
  end

  devise_scope :user do
    post 'outlets/:outlet_id/favorite' => 'user/users#add_favortite_outlet'
    delete 'outlets/:outlet_id/favorite' => 'user/users#remove_favorite_outlet'
    get 'outlets/favorite' => 'user/users#favorite_outlets'
    post 'categories/favorite' => 'user/users#update_favorite_categories'
    delete 'categories/:category_id/favorite' => 'user/users#remove_favorite_category'
    post 'outlets/:outlet_id/rate' => 'user/users#update_outlet_rating'
    delete 'outlets/:outlet_id/clear_rating' => 'user/users#clear_outlet_rating'
    post 'follow/:user_id' => 'user/users#follow_user'
    delete 'unfollow/:user_id' => 'user/users#unfollow_user'
    get 'filters' => 'user/users#filters'
    get 'search_by_filter/:filter_id' => 'user/outlets#search_by_filter'
  end

  devise_scope member: [:user, :god] do
    #Create an order
    post '/offers/:id/buy' => 'orders#create'
    delete '/orders/:id' => 'orders#destroy'

    #Fetch deals with different criteria which also does not need any authentication
    get "/outlets" => "user/outlets#index"
    get "/outlets/:id" => "user/outlets#show"

    #spam/unspam a vendor
    post  "/vendors/:vendor_id/spam"  => "spams#create"
    delete  "/vendors/:vendor_id/spam"  => "spams#destroy"

  end

=begin
  devise_scope :member => [:user, :vendor] do
    resources :orders, only: [:index, :show]
  end
=end

  devise_scope :member => [:user, :vendor] do
    resources :orders, only: [:index, :show]
    resources :outlets, only: [] do
      resources :comments, only: [:index, :show, :create, :update, :destroy, :like, :spam]
      post 'upload/image' => 'images#upload'
      get 'images' => 'user/outlets#outlet_images'
      get 'menus' => 'user/outlets#outlet_menus'
      post 'upload/menu' => 'images#upload_menu'
    end
    delete 'images/:image_id' => 'images#delete'
    get 's3_policy' => 'aws#get_s3_upload_key'
    #Below route is different then above, it gives you images uploaded by a member
    get 'images' => 'images#member_images'
    get 'menus' => 'images#member_menus'

    resources :comments, only: [] do
      resources :comments, only: [:index, :create, :update, :destroy]
      post 'like' => 'comments#like'
      delete 'like' => 'comments#clear_like'
      post 'spam' => 'comments#spam'
      delete 'spam' => 'comments#clear_spam'
    end

    post 'send_otp' => 'verify_otp#send_otp'
    post 'verify_mobile_no' => 'verify_otp#verify_mobile_no'
  end

  devise_scope :vendor do
    get '/vendor' => 'application#vendor'
    namespace :vendor do
      resources :outlets, only: [:create, :update, :destroy, :index, :show] do
        post 'upload/menu' => 'images#upload_menu'
      end
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
  get '/subcategories/:category_id' => 'reference_data#sub_categories'
  get '/offertypes' => 'reference_data#offer_types'
  get '/companysetting' => 'company_setting#show'
  get '/offer_count_by_categories' => 'user/outlets#offer_count_by_categories'

  #************APIs which does not require the login*************
  #Free text search for outlets, deals and offers
  get '/search' => 'user/search#search'

  #Show user's public profile
  get 'public//user/:slug' => 'public#user'
  get 'public/vendor/:slug' => 'public#vendor'
  get '/heartbeat' => 'public#heartbeat'


  # You can have the root of your site routed with "root"
  root 'application#index'
  #Below lines are important for using html5 mode of angularjs. For any resource after /app and /vendor/app we are
  # actually moving to some angular state (no REST url should have this format) so return the application layout.
  get "/vendor/app/*path" => "application#vendor"
  get "/vendor/*path" => "application#vendor"
  get "/app/*path" => "application#index"

end
