module Honcho
  module ApplicationHelper

    # Dashboard Title can be configured in config/honcho.rb
  	def application_title
  		Honcho.configuration[:title] || "Admin Dashboard"
  	end	

    # Resources, you want to manage unde admin panel, 
    # can be configured in config/honcho.rb
    def nav_bar_options
  		options = []
  		models = Honcho.configuration[:admin_models]
  		unless models.empty?
	  		models.each do |h|
	  			options << h.to_s.capitalize
	  		end
	  	end	
  		return options
  	end

    # Main content  
  	def main_content
  		yield
  	end

    # Side Bar
  	def side_bar
  		yield :sidebar
  	end
  end
end
