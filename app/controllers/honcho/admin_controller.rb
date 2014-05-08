require_dependency "honcho/application_controller"

module Honcho
  class AdminController < ApplicationController

    helper_method :klass

    respond_to :html

    before_action :load_resource, except: [:index, :new, :create]

    def index
      #@resources = if params[:search].present?
      #  klass.search(params[:search]).page params[:page]
      #else
      @resources = klass.page params[:page]
    #  end
    end

    def new
      @resource = klass.new
    end

    def create
      @resource = klass.new(model_params)
      respond_to do |format|
        if @resource.save
          format.html { redirect_to :index, notice: "#{klass.name} was successfully created." }
        else
          flash.now[:alert] = "Error while creating #{klass}"
          format.html { render action: :new }
        end
      end
    end

    def edit
    end

    alias_method :show, :edit

    def update
      respond_to do |format|
        if @resource.update_attributes(model_params)
          format.html { redirect_to :index, notice: "#{klass.name} was successfully updated." }
        else
          flash.now[:alert] = "Error while updating #{klass}"
          format.html { render action: :edit }
        end
      end

    end

    def destroy
      if @resource.destroy
        flash[:waring] = "#{klass.name} deleted successfully."
      else
        flash[:info] = "Error deleting #{klass.name}."
      end
      redirect_to :back
    end

    def klass
      @klass ||= model_name_symbolized.constantize
    end

    private

      def model_name_symbolized
        @model_name ||= params[:controller].split('/').last.singularize.capitalize
      end

      def params_attr
        @params_attr ||= params[:controller].split('/').last.singularize.downcase
      end

      def load_resource
        @resource ||= klass.find params[:id]
      end

      def index_url
        "/honcho/#{params[:controller].split('/').last}/"
      end

      def show_url
        ["/honcho/#{params[:controller].split('/').last.singularize}/",load_resource]
      end

      def model_params
        params.require(params_attr).permit( *klass.table_attributes)
      end

  end
end
