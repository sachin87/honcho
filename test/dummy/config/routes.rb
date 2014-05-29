Rails.application.routes.draw do

  mount Honcho::Engine => "/honcho"

  root to: 'honcho/admin_dashboard#index'

end
