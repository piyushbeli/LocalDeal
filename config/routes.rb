Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  mount_devise_token_auth_for 'Vendor', at: 'auth_vendor',
                              skip: [:omniauth_callbacks],
                              controllers: {
                                          registrations: 'vendor/registrations'
                              }

  mount_devise_token_auth_for 'God', at: 'auth_god'


  devise_scope :user do
    resources :posts, only: [:show, :create, :index, :update] do
      resources :comments, only: [:show, :create, :index] do
        member do
          put '/upvote' => 'comment#upvote'
        end
      end

      member do
        put '/upvote' => 'posts#upvote'
      end
    end
  end


  devise_scope :vendor do
    get '/vendor' => 'application#vendor'
    namespace :vendor do
      resources :outlets, only: [:create, :update, :destroy, :index, :show]
      resources :deals, only: [:create, :update, :destroy, :index, :show] do
        resources :offers, only: [:create, :update, :destroy]
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
  get "user/outlets" => "user/outlets#index"


  # You can have the root of your site routed with "root"
  root 'application#index'
  get "/vendor/*path" => "application#vendor"
  get "/user/*path" => "application#index"
  get "*path" => "application#index"

end
