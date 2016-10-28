require 'rails/generators'
module Honcho
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def install
      # Rails.logger.info "generating configuration file if not exist"
      template 'initializer.erb', 'config/initializers/honcho.rb'
      # template "honcho_head.rb.erb", "app/views/layouts/honcho_head.html.erb"
    end
  end
end
