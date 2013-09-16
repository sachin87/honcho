require 'rails/generators'
require File.expand_path('../utils', __FILE__)
  
module Honcho
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      
      desc "Lets start the Honcho Magic"
      
      def install
        routes = File.open(Rails.root.join("config/routes.rb")).try :read
        initializer = (File.open(Rails.root.join("config/initializers/honcho.rb")) rescue nil).try :read        
        unless initializer
          template "initializer.erb", "config/initializers/honcho.rb"
        else
          Rails.logger.info "generating configuration file"
          template "initializer.erb"
        end  
      end       
    end
end