module Honcho
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def klass
      @klass ||= model_name_symbolized.constantize
    end
  end
end