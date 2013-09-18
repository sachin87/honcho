module Honcho
  module Admin

    MAGIC_COLUMNS = ["id", "created_at", "updated_at"]    

    def self.included(base)
      base.extend ClassMethods
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      # Instance method for showing attributes without magic_columns in Views
      define_method(:table_attributes) do
        self.attributes.reject!{|x| MAGIC_COLUMNS.include?(x)}
      end
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
