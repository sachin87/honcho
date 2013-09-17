module Honcho

  require 'debugger'

  mattr_accessor :configuration

  class Engine < ::Rails::Engine
    isolate_namespace Honcho
  end

  def self.admin_models(val)
    self.configuration[:admin_models] = val
  end

  def self.default_theme(val)
    self.configuration[:default_theme] = val
  end

  def self.config
    self.configuration ||= {}
    if block_given?
      yield(self)
    else
      raise 'No configuration block found.'
    end
  end

end





=begin

Honcho.configure do |config|

  config.resources [:posts, :comments]
end

=end
