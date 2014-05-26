module Honcho
  class ApplicationController < ActionController::Base

    def klass
      @klass ||= model_name_symbolized.constantize
    end

  end
end
