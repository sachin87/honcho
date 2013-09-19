Rails.application.routes.draw do

  resources :comments

  resources :posts

  mount Honcho::Engine => "/honcho"

end
