Checkintimer::Application.routes.draw do


  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users
  match "/callback/foursquare/push", :to => "callback#foursquare_push", :as => :foursquare_push_callback
  match "/callback/foursquare", :to => "callback#foursquare", :as => :foursquare_callback

  root :to => "home#index"
  get "/dashboard", :to => "dashboard/base#index", :as => :dashboard


  namespace :dashboard do
    get "/account", :to => "account#show", :as => :account
    match "/checkin/now", :to => "checkin#now", :as => :checkin_now
    #match "/checkin/schedule", :to => "checkin#schedule", :as => :checkin_schedule
    #match "/checkin/schedules", :to => "checkin#schedules", :as => :checkin_schedules
    get "/checkins", :to => "checkin#index", :as => :checkins
    get "/leaderboard", :to => "base#leaderboard", :as => :leaderboard
    get "/badges", :to => "base#badges", :as => :badges

    resources :checkin_schedules, :path => "/checkin/schedules"
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
