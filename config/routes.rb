TursPro::Application.routes.draw do

  resources :news, :only => [:index, :show]
  namespace :paid_service do
    get "pro"
    get "vip"
    get "site_link"
    get "recommended"
    get "selection"
    get "advertising_in_journal"
    get "advertising_in_site"

    get "activate_pro"
    get "activate_vip"
    get "activate_site_link"
    get "activate_recommended"
    get "activate_selection"
    get "activate_journal"
    get "activate_advertising_in_site"
  end

  #get "stend/edit"

  get "main/company_license"
  get "main/users_license"

  resources :turs

  resources :photos

  resources :videos

  resources :advertisements

  #get "videos/index"

  #get "photos/index"

  #get "tender/index"

  #devise_for :admins

  #devise_for :users

  resources :gallery

  resources :mention

  resources :catalog do
    collection do
      #resources :hotels , :controller => 'catalog', :action => 'hotels'#, :only =>[:index]
      #resources :tour_operators , :controller => 'catalog', :action => 'tour_operators'#, :only =>[:tour_operators]
      #resources :recreation_centers , :controller => 'catalog', :action => 'recreation_centers', :only =>[:recreation_centers]
      #resources :sanatorium , :controller => 'catalog', :action => 'sanatorium', :only =>[:sanatorium]
      #resources :hostel , :controller => 'catalog', :action => 'hostel', :only =>[:hostel]
      #resources :guide , :controller => 'catalog', :action => 'guide', :only =>[:guide]
      #resources :taxi , :controller => 'catalog', :action => 'taxi', :only =>[:taxi]
      #resources :mini_hotels , :controller => 'catalog', :action => 'mini_hotels', :only =>[:mini_hotels]

      get 'hotels'
      get 'tour_operators'
      get 'recreation_centers'
      get 'sanatorium'
      get 'hostel'
      get 'guide'
      get 'taxi'
      get 'mini_hotels'
      get 'tour_agencies'
    end
    # get 'catalog/index'
    # get 'catalog/show'
    #end
  end

  resources :categories do
    resources :journals
  end

  resources :journals do
    post "add_comment"
    collection do
      get 'drop_photo'
      post 'add_photo'
    end
  end
  resources :profiles
  resources :countries do
    collection do
      get 'phones'
    end
    member do
      get 'visa'
      get 'phrasebook'
      get 'embassy'
      get 'memo'
    end
  end


  resources :tender
  #resources :user_sessions
  #resources :users
  # map.resource :attachments


  match '/attachments/manage' => 'attachments#manage'
  match '/attachments/create' => 'attachments#create'
  # match "/journals/categories/:category_id/post/:post_id" => 'posts#show', :as => 'post_show'


  #map.root :controller => "main", :action => "index"
  match "search_rezult" => "main#search_rezult"
  #match "login" => 'user_sessions#new'
  #match "logout" => 'user_sessions#destroy'
  # devise_for :admins do
  namespace :admin do
    get "logout" => "devise/sessions#destroy"
    resources :news
    resources :categories do
      collection do
        post 'batch_action'
      end
    end

    resources :journals do
      collection do
        get 'drop_photo'
        post 'add_photo'
      end

    end
    resources :countries do
      collection do
        post 'batch_action'
      end
    end
    resource :settings, :only => [:edit, :update]
    resources :users do
      collection do
        post 'batch_action'
      end
    end
    root :controller => "main", :action => "index"
  end
  #end

  #map.company_profile_root '', :controller => 'user', :action => 'show', :conditions => { :subdomain => true }
  #constraints(Subdomain) do
  #devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"} do
  #devise_for :users  do
  get "/sign_up" => "registrations#new"

  match "/accept_command_call", :controller => "company/profiles", :action => "accept_command_call"
  match "/decline_command_call", :controller => "company/profiles", :action => "decline_command_call"
  match "/remove_favorite", :controller => "company/profiles", :action => "remove_favorite"
  match "/update_invoice", :controller => "company/finance", :action => "update_invoice"
  match "/pay_declined", :controller => "company/finance", :action => "pay_declined"
  match "/pay_successful", :controller => "company/finance", :action => "pay_successful"


  scope "/remote" do
    match "/show_pic" => "company/profiles#show_pic"
    match "/show_crop" => "company/profiles#show_crop"
  end


  namespace :company do
    resources :finance do
      member do
        get "pay_successful"
      end
    end

    resources :profiles do
      put "create_pic"
      put "update_pic"
      get "show_pic"
      resources :rewards
      member do
        get "command_index"
        get "add_to_command"
        get "recommendation_index"
        get "add_recommendation"
        get "add_favorite"
        get "favorite_index"
      end
      get 'directions'
      get 'contact_map'
      resources :turs
      member do
        resources :journals
        resources :comments do
          post "add_comment", :on => :collection
        end
        resource :stend
        resources :videos
        resources :photos do
          collection do
            get 'drop_photo'
            post 'add_photo'
            post 'change_order'
            get 'ordering'
            post 'update'
          end
        end

      end

    end
    root :controller => "main", :action => "index"
  end
  #match '/' => 'profiles#show', :as => :profile
  #end
  root :to => 'main#index'

  get '/session' => "sessions#create", :as => 'open_id_complete'

  resources :sites, :moderatorships, :monitorship

  resources :forums do
    resources :topics do
      resources :posts
      resource :monitorship
    end
    resources :posts
  end

  resources :posts do
    get :search, :on => :collection
  end
  resources :users do
    member do
      put :suspend, :make_admin, :unsuspend
      get :settings
      delete :purge
    end
    resources :posts, :only => [:index] do
      #      get :monitored, :on => :collection, :shallow => true
    end
  end
  match '/users/:user_id/monitored(.:format)' => 'posts#monitored', :as => 'monitored_posts'

  match '/activate/:activation_code' => 'users#activate', :activation_code => nil, :as => 'activate'
  match '/signup' => 'users#new', :as => 'signup'
  match '/settings' => 'users#settings', :as => 'settings'
  match '/login' => 'sessions#new', :as => 'login'
  match '/logout' => 'sessions#destroy', :as => 'logout'

  resource :session

  resources :companion
end
