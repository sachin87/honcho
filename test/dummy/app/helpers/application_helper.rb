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
  	  # content_tag(:ul, class: "right") do
  	  # 	content_tag(:li, class: "divider")
  		  models.each do |h|
  				# Check if nested resources
  				# if h.is_a?(Hash)  					
  				# 	content_tag(:li) do
  				# 		link_to	"#{h.to_s.capitalize}"
  				# 	end	      	    
  				options << h.to_s.capitalize
          #	content_tag(:li, class: "divider")
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
end
