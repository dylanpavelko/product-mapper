Rails.application.routes.draw do

  resources :delivery_dates

  resources :milestones

  resources :environments

  resources :node_has_phase_type_defaults

  resources :phase_type_default_has_phyase_types

  resources :phase_type_defaults

  resources :user_has_favorite_nodes

  resources :git_hub_issues

  resources :git_hub_accounts

  resources :git_hub_repos

  resources :phases

  resources :dependables

  resources :questions

  resources :tasks

  resources :phase_types

  resources :users

  get 'welcome/index'

  post 'phase/set_status' => 'phases#set_phase_status'

  resources :nodes do
    post :update_row_order, on: :collection
  end

  resources :node_types

  get 'sessions/login'
  post 'sessions/login'
  get "logout" => "sessions#logout"
  get 'sessions/home'

  get 'sessions/profile'

  get 'sessions/setting'

  get 'backlog(/:id)' => 'nodes#backlog' , as: :backlog
  get 'feature_inventory(/:id)' => 'nodes#feature_inventory' , as: :feature_inventory

  get 'users/new'

  post ':controller(/:action(/:id))(.:format)'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
