module Honcho
  module ApplicationHelper

    # get browser title for the Honcho Dashboard
    def browser_title
      Honcho.configuration[:browser_title] || 'Honcho'
    end

    # Dashboard Title can be configured in config/honcho.rb
  	def application_title
  		Honcho.configuration[:title] || "Honcho"
  	end	

    # Resources, you want to manage under admin panel,
    # can be configured in config/honcho.rb
    def nav_bar_options
      options = []
      models = Honcho.configuration[:admin_models]
      unless models.empty?
        # content_tag(:ul, class: "right") do
        #   content_tag(:li, class: "divider")
          models.each do |h|
            # Check if nested resources
            # if h.is_a?(Hash)            
            #   content_tag(:li) do
            #     link_to "#{h.to_s.capitalize}"
            #   end             
            options << h.to_s.capitalize
            # content_tag(:li, class: "divider")
            #end          
          end
        #end  
      end 
      options
    end

    # Main content  
  	def main_content
  		yield
  	end

    # Side Bar
  	def side_bar
  		yield :sidebar
  	end

    # get resource name from string like 'honcho/posts' => Posts
    def resource_name
      params[:controller].split("/").last.capitalize
    end 

    # create a path for a given resource and action
    def resource_url(action, resource)
      honcho.send("#{action}_#{singularize_resource}_path", resource)
    end

    # singularize and lowercase the resultant of method: resource_name
    def singularize_resource
      resource_name.singularize.downcase
    end

    def input_type(form_object, attribute, type = :string)
      type = @resource.column_for_attribute(attribute).type
      if attribute.include?('_id')
        :select
      elsif type == :boolean
        type
      elsif type == :datetime
        :datetime
      end
    end

    def input_options(form_object, attribute, type = :string)
      t = input_type(form_object, attribute, type = :string)
      options = {}
      options[:as] = t
      options[:label] = false
      options[:class] = 'error'
      options[:required] = Honcho.configuration[:html5_validations]
      if t == :select
        options[:collection] = Post.all
      end
      options
    end

    def label_options(attribute, f)
      value = [attribute.humanize]
      if f.object.errors[attribute].present?
        value << {class: 'error'}
      end
      value
    end

    def sortable(column, title = nil)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
      link_to title, honcho.send("#{resource_name.downcase}_path", {sort: column, direction: direction}), {class: css_class}
    end

    def download_links
      formats = [ "CSV", "Excel", "XML", "JSON"]
      value = Honcho.configuration[:supported_formats]
      if value.to_sym == :all
        [ "CSV", "Excel", "XML", "JSON"]
      elsif value.nil?
        []
      else
        value
      end
    end

  end
end
