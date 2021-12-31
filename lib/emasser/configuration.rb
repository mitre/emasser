# frozen_string_literal: true

module Emasser
  require 'emasser/errors'

  class Configuration
    # rubocop: disable Style/RaiseArgs
    def self.raise_unless_present(env)
      ENV.fetch(env) { raise Emasser::ConfigurationMissingError.new(env) }
    rescue Emasser::ConfigurationMissingError => e
      if (ARGV[0].to_s.include? "-v") || (ARGV[0].to_s.include? "-V") 
        puts Emasser::VERSION.green
        exit
      else
        puts "\n", e.message.red
        puts 'Create a .env file with the necessary variables, place it in the root directory where the emasser command'.yellow
        puts 'is executed. See emasser environment variables requirements in emasser CLI Features for more information'.yellow, "\n"
        exit
      end
    end
    # rubocop: enable Style/RaiseArgs

    # rubocop: disable Style/TernaryParentheses, Style/IfWithBooleanLiteralBranches
    SwaggerClient.configure do |config|
      config.api_key['api-key'] = raise_unless_present('EMASSER_API_KEY_API_KEY')
      config.api_key['user-uid'] = raise_unless_present('EMASSER_API_KEY_USER_UID')
      config.scheme = 'https'
      config.base_path = '/'
      config.host = raise_unless_present('EMASSER_HOST')
      config.key_file = raise_unless_present('EMASSER_KEY_FILE_PATH')
      config.cert_file = raise_unless_present('EMASSER_CERT_FILE_PATH')
      config.key_password = raise_unless_present('EMASSER_KEY_PASSWORD')
      # config.client_side_validation = (raise_unless_present('EMASSER_CLIENT_SIDE_VALIDATION') == 'false') ? false : true
      # config.verify_ssl = (raise_unless_present('EMASSER_VERIFY_SSL') == 'false') ? false : true
      # config.verify_ssl_host = (raise_unless_present('EMASSER_VERIFY_SSL_HOST') == 'false') ? false : true
      config.client_side_validation = (ENV.fetch('EMASSER_CLIENT_SIDE_VALIDATION', false) == 'false') ? false : true
      config.verify_ssl = (ENV.fetch('EMASSER_VERIFY_SSL', false) == 'false') ? false : true
      config.verify_ssl_host = (ENV.fetch('EMASSER_VERIFY_SSL_HOST', false) == 'false') ? false : true
      config.debugging = (ENV.fetch('EMASSER_DEBUGGING', false) == 'true') ? true : false
    end
    # rubocop: enable Style/TernaryParentheses, Style/IfWithBooleanLiteralBranches
  end
end
