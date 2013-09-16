require 'rails/generators'
require File.expand_path('../utils', __FILE__)
  
module Honcho
  module Generators
    class InstallGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      
      desc "Lets start the Honcho Magic"
      
      def install
        routes = File.open(Rails.root.join("config/routes.rb")).try :read
        initializer = (File.open(Rails.root.join("config/initializers/honcho.rb")) rescue nil).try :read
      end       
    end
  end
end