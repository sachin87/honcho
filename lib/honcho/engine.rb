module Honcho
  class Engine < ::Rails::Engine
    isolate_namespace Honcho
  end

  def self.configure(&block)
    unless block_given?
      raise 'No Block Found.'
    end
  end
end
