Honcho::Engine.routes.draw do
  get '/admin' => 'admin_dashboard#index'

  config = Honcho.configuration[:admin_models] || []
  config.each do |klass|
    resources klass.to_s.pluralize.to_sym do
      collection do
        get 'page/:page', action: :index
        post :import
      end
    end
  end
end
