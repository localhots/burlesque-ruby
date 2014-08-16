module Burlesque
  class Config
    attr_accessor :host, :port, :timeout

    def initialize
      @host = '127.0.0.1'
      @port = 4401
      @timeout = 30
    end
  end

  module Configurable
    def configure
      @config ||= Config.new

      yield @config if block_given?
    end

    def config
      configure unless instance_variable_defined?(:@config)

      @config
    end
  end

  extend Configurable
end
