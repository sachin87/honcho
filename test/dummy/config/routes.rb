Rails.application.routes.draw do

  devise_for :users
  mount Honcho::Engine => "/honcho"

  root to: 'honcho/admin_dashboard#index'

end
