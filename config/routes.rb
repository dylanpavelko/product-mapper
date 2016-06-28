Rails.application.routes.draw do

  resources :issue_exists_in_google_sheets

  resources :google_sheet_has_mappings

  resources :google_sheets

  resources :native_issue_has_impacts

  resources :customers

  resources :native_issue_has_jiras

  resources :jira_issues

  resources :jira_repos

  resources :inbox_items

  get 'activities/index'

  resource :activities

  resources :native_issue_has_responses

  resources :node_has_themes

  resources :themes

  resources :native_issue_has_asanas

  resources :asana_tasks

  resources :asana_auth_end_points

  resources :asana_workspaces

  post '/add_response_to_question' => 'responses#add_response_to_question'

  post '/add_response_to_native_issue' => 'responses#add_response_to_native_issue'

  post '/add_jira_to_native_issue' =>  'native_issues#add_jira_to_native_issue'

  post '/add_customer_impact_to_native_issue' =>  'native_issues#add_customer_impact_to_native_issue'

  post '/mark_inbox_item_as_read' => 'inbox_items#mark_inbox_item_as_read'

  post '/import_new_native_issue_from_google_sheet' => 'google_sheets#import_new_native_issue_from_google_sheet'

  resources :question_has_responses

  resources :responses

  resources :node_histories

  resources :user_has_role_for_nodes

  resources :roles

  resources :node_has_functional_design_documents

  resources :functional_design_documents

  resources :native_issues

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

  #post 'phase/set_status' => 'phases#set_phase_status'

  post 'phase/set_progress_status' => 'phases#set_progress_status'



  post 'add_filter' => 'sessions#add_filter'
  post 'remove_filter' => 'sessions#remove_filter'

  resources :nodes do
    post :update_row_order, on: :collection
  end

  resources :node_types

  get 'sessions/login'
  post 'sessions/login'
  get "logout" => "sessions#logout"
  get 'sessions/home'
  get 'change_photo(/:id)' => 'users#change_photo' , as: :change_photo
  post 'set_photo' => 'users#set_photo'

  get 'sessions/profile'


  get 'chooser_get' => 'nodes#chooser_get' , as: :chooser_get

  get 'sessions/setting'

  get 'backlog(/:id)' => 'nodes#backlog' , as: :backlog

  get 'diagram(/:id)' => 'nodes#diagram' , as: :diagram

  get 'team(/:id)' => 'nodes#team' , as: :team

  get 'change_password(/:id)' => 'users#change_password', as: :change_password

  get 'show_node_history(/:id)' => 'node_histories#show_node_history' , as: :show_node_history

  get 'delivery_schedule(/:id)' => 'nodes#delivery_schedule' , as: :delivery_schedule
  get 'feature_inventory(/:id)' => 'nodes#feature_inventory' , as: :feature_inventory
  get 'in_progress(/:id)' => 'nodes#in_progress' , as: :in_progress

  get 'users/new'

  get 'my_product_feed' => 'activities#product_feed' , as: :product_feed

  post 'search', to: 'application#header_search'

  get 'search_results', to: 'nodes#search_results'

  get '/get_asana_task_from_url', to: 'asana_tasks#get_from_url'

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
