require 'csv'
require 'simple_form'
require 'haml-rails'
require 'kaminari'
require 'jquery-rails'
require 'roo'

module Honcho
  mattr_accessor :configuration do
    {}
  end

  class Engine < ::Rails::Engine
    isolate_namespace Honcho
  end

  def self.admin_models(val)
    self.configuration[:admin_models] = val
  end

  def self.default_theme(val)
    configuration[:default_theme] = val
  end

  def self.title(val)
    configuration[:title] = val
  end

  def self.browser_title(val)
    configuration[:browser_title] = val
  end

  def self.auto_managed(val)
    configuration[:auto_managed] = val
  end

  def self.import_form_for(val)
    configuration[:import_form_for] = val
  end

  def self.html5_validations(val)
    configuration[:html5_validations] = val
  end

  def self.supported_formats(val)
    configuration[:supported_formats] = val
  end

  def self.config
    self.configuration ||= {}
    if block_given?
      yield(self)
      include_modules
      create_controllers
    else
      raise 'No configuration block found.'
    end
  end

  private

  def self.create_controllers
    configuration[:admin_models].each do |klass|
      controller_name = (klass.to_s.pluralize.capitalize + "Controller")
      Honcho.const_set("#{controller_name}", Class.new(Honcho::AdminController))
    end
  end

  def self.include_modules
    ActiveRecord::Base.send(:include, Honcho::Admin)
  end
end

=begin

Honcho.configure do |config|

  config.resources [:posts, :comments]
end

=end
