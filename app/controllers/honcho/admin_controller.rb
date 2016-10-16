require_dependency 'honcho/application_controller'

module Honcho
  class AdminController < ApplicationController
    helper_method :klass, :sort_column, :sort_direction, :download_links

    respond_to :html, :xml

    before_action :load_resource, except: [:index, :new, :create, :import]

    def index
      respond_to do |format|
        if params[:format].blank?
          block = -> { html_response }
          format.send(:html, &block)
        else
          block = -> { eval "#{params[:format]}_response" }
          format.send(params[:format], &block)
        end
      end
    end

    def new
      @resource = klass.new
    end

    def create
      @resource = klass.new(model_params)
      respond_to do |format|
        if @resource.save
          format.html { redirect_to honcho.send("#{model_name}_path",@resource.id), notice: "#{klass.name} was successfully created." }
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
          format.html { redirect_to honcho.send("#{model_name}_path",@resource.id), notice: "#{klass.name} was successfully updated." }
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

    def import
      klass.import(params[:file])
      redirect_to root_url, notice: "#{klass.name.pluralize} imported."
    end

    private

    def model_name_symbolized
      @model_name_symbolized ||= model_name.capitalize
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
      ["/honcho/#{params[:controller].split('/').last.singularize}/", load_resource]
    end

    def model_params
      params.require(params_attr).permit(*klass.table_attributes)
    end

    def sort_column
      klass.column_names.include?(params[:sort]) ? params[:sort] : klass.primary_key
    end

    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
    end

    def resources
      @resources ||= klass.order(sort_column + ' ' + sort_direction).all
    end

    def html_response
      @resources = if params[:search].present?
                     klass.search(params[:search]).page(params[:page])
                   else
                     klass.order(sort_column + ' ' + sort_direction).page(params[:page])
                   end
    end

    def csv_response
      send_data klass.to_csv(resources)
    end

    def xls_response
      resources
    end

    def xml_response
      render xml: resources
    end

    def json_response
      render json: resources
    end

    def download_links
      formats = %w(CSV XLS XML JSON)
      value = Honcho.configuration[:supported_formats]
      if value.to_sym == :all
        formats
      elsif value.nil?
        []
      else
        value
      end
    end

    def model_name
      @model_name ||= params[:controller].split('/').last.singularize
    end
  end
end
