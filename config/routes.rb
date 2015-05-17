Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  as :user do
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

  mount_devise_token_auth_for 'Vendor', at: 'auth_vendor', skip: [:omniauth_callbacks]

  mount_devise_token_auth_for 'God', at: 'auth_god'
  as :god do
    # Define routes for God within this block.
  end

  devise_scope :vendor do
    get '/vendor' => 'application#vendor'
    namespace :vendor do
      resources :outlets , only: [:create, :update, :destroy, :index, :show]
      resources :deals, only: [:create, :update, :destroy, :index, :show] do
        resources :offers, only: [:create, :update, :destroy]
      end

      #Remove an outlet from deal.
      delete 'deals/:id/outlets/:outlet_id' => 'deals#removeOutlet'
    end
  end

  #Reference data which does not require any authentication and common for all roles
  get '/categories' => 'reference_data#categories'
  get 'subcategories/:category_id' => 'reference_data#sub_categories'
  get 'offertypes' => 'reference_data#offer_types'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
