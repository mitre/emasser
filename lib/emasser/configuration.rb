# frozen_string_literal: true

module Emasser
  class Configuration
    def self.raise_unless_present(env)
      ENV.fetch(env) { raise Emasser::ConfigurationMissingError.new(config: env) }
    end

    SwaggerClient.configure do |config|
      config.api_key['api-key'] = raise_unless_present('EMASSER_API_KEY_API_KEY')
      config.api_key['user-uid'] = raise_unless_present('EMASSER_API_KEY_USER_UID')
      config.scheme = 'https'
      config.base_path = '/'
      config.host = raise_unless_present('EMASSER_HOST')
      config.key_file =  raise_unless_present('EMASSER_KEY_FILE_PATH')
      config.cert_file = raise_unless_present('EMASSER_CERT_FILE_PATH')
      config.key_password = raise_unless_present('EMASSER_KEY_PASSWORD')
      config.client_side_validation = true
      config.verify_ssl = false
      config.verify_ssl_host = true
      config.debugging = ENV.fetch('EMASSER_DEBUGGING', false)
    end
  end
end
