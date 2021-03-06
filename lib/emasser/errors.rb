# frozen_string_literal: true

module Emasser
  class Error < StandardError; end

  class ConfigurationMissingError < Error
    attr_reader :config

    def initialize(config = 'an option', message = 'No configuration was provided for variable:')
      @config = config
      super("#{message} #{@config}")
    end
  end
end
