# frozen_string_literal: true

module Emasser
  class Error < StandardError; end

  class ConfigurationMissingError < Error
    attr_reader :config

    def initialize(config = 'an option', message = 'Required environment variable missing:')
      @config = config
      super("#{message} #{@config}")
    end
  end

  class ConfigurationEmptyValueError < Error
    attr_reader :config

    def initialize(config = 'an option', message = 'A value is expected for environment variable:')
      @config = config
      super("#{message} #{@config}")
    end
  end
end
