AngularRails::Application.routes.draw do
  resources :posts	

  post "/posts/:id/data" => "posts#data"
  post "/posts/:id(.:format)/tweet(.:format)" => "posts#tweet"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end