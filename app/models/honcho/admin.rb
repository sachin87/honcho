# frozen_string_literal: true
module Honcho
  module Admin
    MAGIC_COLUMNS = %w(id created_at updated_at).freeze

    extend ActiveSupport::Concern

    included do
      # Instance method for showing attributes without magic_columns in Views
      define_method(:object_attributes) do
        attributes.select { |x| self.class.index_columns.include?(x) || x == 'id' }
      end
    end

    class_methods do

      #attr_accessor :index_columns

      def table_attributes
        (attribute_names + ignored_columns) - (Honcho.configuration[:auto_managed] ? [] : MAGIC_COLUMNS)
      end

      def index_columns=(args)
        @index_columns = args
      end

      def index_columns
        @index_columns || table_attributes
      end

      def search(query)
        where(query.reject { |_k, v| v.blank? })
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
