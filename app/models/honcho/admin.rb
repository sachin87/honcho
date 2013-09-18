module Honcho
  module Admin

    MAGIC_COLUMNS = ["id", "created_at", "updated_at"]

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      Honcho.configuration[:admin_models].each do |model|
        klass = model.to_s.capitalize.constantize
        define_method(:table_attributes) do
          klass.attribute_names - ( Honcho.configuration[:auto_managed] ? [] : MAGIC_COLUMNS)
        end
      end
    end

  end
end
