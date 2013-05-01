Happiness::Application.routes.draw do
  
  resources :users

  root :to => "home#index"
  match "/about", to: "home#about"
  match "/logout" => "sessions#destroy", as: :logout
  match "/auth/:provider/callback" => "sessions#create"
end
