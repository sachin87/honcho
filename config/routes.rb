Honcho::Engine.routes.draw do

  get '/admin' => 'admin_dashboard#index'

  Honcho.configuration[:admin_models].each do |klass|
    resources klass.to_s.pluralize.to_sym
  end

end
