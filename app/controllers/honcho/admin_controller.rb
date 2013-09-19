require_dependency "honcho/application_controller"

module Honcho
  class AdminController < ApplicationController

    helper_method :klass

    respond_to :html, :json

    before_action :load_resource, except: [:index, :new, :create]

    def index
      @resources = klass.all
      respond_with(@resources)
    end

    def new
      @resource = klass.new
      #respond_with([:honcho, @resource])
    end

    def create
      @resource = klass.new(params[@model_name])
      @resource.save
      respond_with(@resource)
    end

    def edit
    end

    alias_method :show, :edit

    def update
      @resource.update_attributes((params[@model_name]))
      respond_with(@resource)
    end

    def destroy
      @resource.destroy
      respond_with(@resource)
    end

    def klass
      @klass ||= model_name_symbolized.constantize
    end

    private

      def model_name_symbolized
        @model_name ||= params[:controller].split('/').last.singularize.capitalize
      end

      def load_resource
        @resource = klass.find params[:id]
      end

  end
end
