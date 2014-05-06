Rails.application.routes.draw do

  mount Honcho::Engine => "/honcho"

  #TODO
    #/admin in host application should open honcho admin panel

  root to: 'posts#index'

end
