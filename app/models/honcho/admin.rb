module Honcho
  module Admin
    MAGIC_COLUMNS = ['id', 'created_at', 'updated_at']  

    def self.included(base)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      # Instance method for showing attributes without magic_columns in Views
      define_method(:object_attributes) do
        self.attributes.reject! { |x| MAGIC_COLUMNS.include?(x) }
      end
    end

    Honcho.configuration[:admin_models].each do |model|
      klass = model.to_s.capitalize.constantize
      class << klass
        define_method(:table_attributes) do
          self.attribute_names - (Honcho.configuration[:auto_managed] ? [] : MAGIC_COLUMNS)
        end

        def search(query)
          where(query.reject { |k, v| v.blank? })
        end

        def to_csv(resources, options = {})
          CSV.generate(options) do |csv|
            csv << column_names
            resources.each do |resource|
              csv << resource.attributes.values_at(*column_names)
            end
          end
        end

        def import(file)
          spreadsheet = open_spreadsheet(file)
          header = spreadsheet.row(1)
          (2..spreadsheet.last_row).each do |i|
            row = Hash[[header, spreadsheet.row(i)].transpose]
            resource = find_by_id(row['id']) || new
            resource.attributes = row.to_hash.slice(*accessible_attributes)
            resource.save!
          end
        end

        def open_spreadsheet(file)
          case File.extname(file.original_filename)
            when '.csv' then CSV.new(file.path, nil, :ignore)
            when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
            when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
            else raise "Unknown file type: #{file.original_filename}"
          end
        end
      end
    end
  end
end
