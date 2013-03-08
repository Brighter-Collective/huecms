Brighter::Application.routes.draw do

  root :to => 'contents#index'

  devise_for :users
  
  resources :users do
    resources :comments
  end
  resources :comments

  post "versions/:id/revert" => "versions#revert", :as => "revert_version"

  resources :folders, only: [:create, :update, :destroy]
  resources :contents, only: [:index, :edit, :new, :create, :destroy, :update] do
    get 'publish'
    resources :content_layouts, only: [:show, :new, :create, :destroy, :update, :edit]
  end
  post "content_layouts/publish" => "content_layouts#publish"
  resources :authentications, only: [:new, :create, :destroy, :index]
  resources :layouts, only: [:index, :new, :create, :destroy, :update, :edit]

  post "endpoints/register_social_app" => "endpoints#register_social_app"
  resources :endpoints, only: [:index, :new, :create, :destroy, :update, :edit]
  resources :ftp_endpoints, :controller => "endpoints", :type => "FtpEndpoint"
  resources :sftp_endpoints, :controller => "endpoints", :type => "SftpEndpoint"
  resources :html_layouts, :controller => "layouts", :type => "HtmlLayout"


  resources :facebook_endpoints,
            controller: 'endpoints',
            type: 'FacebookEndpoint',
            only: [:index, :new, :create, :destroy, :update, :edit]
  resources :twitter_endpoints,
            controller: 'endpoints',
            type: 'TwitterEndpoint',
            only: [:index, :new, :create, :destroy, :update, :edit]

  namespace :admin do
    resources :users do
      get 'lookup'
      put 'update_user'
      post 'update_user'
      post 'remove_user'
    end
  end
  resources :images

  match '/auth/:provider/callback' => 'authentications#create'
end
