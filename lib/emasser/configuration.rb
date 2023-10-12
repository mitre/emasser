# frozen_string_literal: true

module Emasser
  require 'emasser/errors'

  class Configuration
    # rubocop: disable Style/RaiseArgs
    def self.raise_unless_present(env)
      ENV.fetch(env) { raise Emasser::ConfigurationMissingError.new(env) }
    rescue Emasser::ConfigurationMissingError => e
      if (ARGV[0].to_s.include? '-v') || (ARGV[0].to_s.include? '-V')
        puts "eMASSer version: #{Emasser::VERSION}".green
      else
        puts "\n", e.message.red
        puts 'Create a .env file containing required variables, place it in the root directory where the emasser command is executed'.yellow
        puts 'Required environment variables are:'.yellow
        puts '  export EMASSER_API_KEY=<API key>'.green
        puts '  export EMASSER_USER_UID=<unique identifier of the eMASS user EMASSER_API_KEY belongs to>'.green
        puts '  export EMASSER_HOST_URL=<FQDN of the eMASS server>'.green
        puts '  export EMASSER_KEY_FILE_PATH=<path to your eMASS key in PEM format>'.green
        puts '  export EMASSER_CERT_FILE_PATH=<path to your eMASS certficate in PEM format>'.green
        puts '  export EMASSER_KEY_FILE_PASSWORD=<password for the key given in EMASSER_KEY_FILE_PATH>'.green, "\n"
        puts 'See eMASSer environment variables requirements in eMASSer CLI Features for more information (https://mitre.github.io/emasser/docs/features.html).', "\n"
      end
      exit
    end
    # rubocop: enable Style/RaiseArgs

    # rubocop: disable Style/TernaryParentheses, Style/IfWithBooleanLiteralBranches
    EmassClient.configure do |config|
      # Required env variables
      config.api_key['api-key'] = raise_unless_present('EMASSER_API_KEY')
      config.api_key['user-uid'] = raise_unless_present('EMASSER_USER_UID')
      config.scheme = 'https'
      config.base_path = '/'
      config.server_index = nil
      config.host = raise_unless_present('EMASSER_HOST_URL')
      config.key_file = raise_unless_present('EMASSER_KEY_FILE_PATH')
      config.cert_file = raise_unless_present('EMASSER_CERT_FILE_PATH')
      config.key_password = raise_unless_present('EMASSER_KEY_FILE_PASSWORD')
      # Optional env variables
      config.client_side_validation = (ENV.fetch('EMASSER_CLIENT_SIDE_VALIDATION', 'true').eql? 'true') ? true : false
      config.verify_ssl = (ENV.fetch('EMASSER_VERIFY_SSL', 'true').eql? 'true') ? true : false
      config.verify_ssl_host = (ENV.fetch('EMASSER_VERIFY_SSL_HOST', 'true').eql? 'true') ? true : false
      config.debugging = (ENV.fetch('EMASSER_DEBUGGING', 'false') == 'false') ? false : true
    end
    # rubocop: enable Style/TernaryParentheses, Style/IfWithBooleanLiteralBranches
  end
end
