# frozen_string_literal: true

module Emasser
  class Error < StandardError; end

  class ConfigurationMissingError < Error
    attr_reader :config_option

    def initialize(message: 'No configuration was provided for', config: 'an option')
      @config = config
      super("#{message} #{@config}")
    end
  end
end
