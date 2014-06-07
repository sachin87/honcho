Kaminari.configure do |config|
  config.default_per_page = 10
  config.page_method_name = :page
  config.param_name = :page
end

module Kaminari
  module Helpers
    class Tag
      def page_url_for(page)
        Honcho::Engine.routes.url_helpers.url_for @params.merge(@param_name => (page <= 1 ? nil : page), :only_path=>true).symbolize_keys
      end
    end
  end
end
