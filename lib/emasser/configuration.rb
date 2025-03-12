# frozen_string_literal: true

module Emasser
  require 'emasser/errors'
  require 'emasser/version'
  require 'fileutils'

  class Configuration
    # rubocop: disable Style/GuardClause, Lint/NonAtomicFileOperation
    # rubocop: disable Style/RescueStandardError, Lint/DuplicateBranch, Style/RedundantReturn
    # rubocop: disable Style/RaiseArgs, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def self.raise_unless_present(env)
      env_value = ENV.fetch(env) { raise Emasser::ConfigurationMissingError.new(env) }
      if env_value.empty?
        raise Emasser::ConfigurationEmptyValueError.new(env)
      end

      return env_value
    rescue Emasser::ConfigurationEmptyValueError => e
      unless (ARGV[0].to_s.include? 'post') && (ARGV[1].to_s.include? 'register') && (env.include? 'EMASSER_API_KEY')
        puts "\n", e.message.red
        show = Configuration.new
        show.emasser_env_msg
        exit
      end
    rescue Emasser::ConfigurationMissingError => e
      unless (ARGV[0].to_s.include? 'post') && (ARGV[1].to_s.include? 'register') && (env.include? 'EMASSER_API_KEY')
        puts "\n", e.message.red
        show = Configuration.new
        show.emasser_env_msg
        exit
      end
    end

    def self.check_folder_exists(env)
      folder_path = ENV.fetch(env) # raises error if EMASSER_DOWNLOAD_DIR is missing
      if folder_path.empty?
        # Create a default downloads folder
        raise CreateDefaultDownloadDirectory
      else
        # Create the folder if does not exist
        unless Dir.exist?(folder_path)
          FileUtils.mkdir_p('eMASSerDownloads')
        end
        return folder_path
      end
    rescue # CreateDefaultDownloadDirectory
      # Create the default folder if does not exist
      unless Dir.exist?('eMASSerDownloads')
        FileUtils.mkdir_p('eMASSerDownloads')
      end
      return 'eMASSerDownloads'
    end
    # rubocop: enable Style/GuardClause, Lint/NonAtomicFileOperation
    # rubocop: enable Style/RescueStandardError, Lint/DuplicateBranch, Style/RedundantReturn
    # rubocop: enable Style/RaiseArgs, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    def emasser_env_msg
      puts 'Create (or update) the configuration (.env) file and place it in the root directory where the emasser command is executed'.yellow
      puts 'Required environment variables:'.yellow
      puts '  export EMASSER_API_KEY=<API key>'.green
      puts '  export EMASSER_HOST_URL=<FQDN of the eMASS server>'.green
      puts '  export EMASSER_KEY_FILE_PATH=<Path to your eMASS key in PEM format>'.green
      puts '  export EMASSER_CERT_FILE_PATH=<Path to your eMASS certficate in PEM format>'.green
      puts '  export EMASSER_KEY_FILE_PASSWORD=<password for the key given in EMASSER_KEY_FILE_PATH>'.green
      puts 'Note: '.yellow + 'EMASSER_API_KEY is acquired by invoking the "emasser post register cert" API command'.cyan, "\n"
      puts 'Actionable (POST,PUT,DELETE) variable required by some eMASS instances:'.yellow
      puts '  export EMASSER_USER_UID=<unique identifier of the eMASS user EMASSER_API_KEY belongs to>'.green
      puts "\n"
      puts 'See eMASSer environment variables requirements in eMASSer CLI Features for more information (https://mitre.github.io/emasser/docs/features.html).'.yellow
    end

    def emasser_pki_help
      puts 'eMASSer PKI Certificate Requirements:'.yellow
      puts 'eMASSer uses a client (signed certificate) and key (private key for the certificate) certificate for authenticating to eMASS.'.cyan
      puts 'Both files are a .pem (Privacy-Enhanced Mail) text-based containers using base-64 encoding. The key file requires a passphrase.'.cyan
      puts "\n"
      puts 'The following variables must be provided on the .env (configuration) file:'.yellow
      puts '  EMASSER_HOST_URL          - The eMASS host URL'.cyan
      puts '  EMASSER_CERT_FILE_PATH    - The client certificate (.pem) file (full path is required)'.cyan
      puts '  EMASSER_KEY_FILE_PATH     - The private key for the certificate (.pem) file (full path is required)'.cyan
      puts '  EMASSER_KEY_FILE_PASSWORD - The key file passphrase value if the key file password has been set'.cyan
      puts 'IMPORTANT: If using a self signed certificate in the certificate chain the optional "EMASSER_VERIFY_SSL" variable must be set to false.'.red
      puts "\n"
      puts 'Certain eMASS integrations may require this variable for actionable (POST,PUT,DELETE) endpoint calls:'.yellow
      puts '  EMASSER_USER_UID - The eMASS User Unique Identifier (user-uid)'.cyan
    end

    if (ARGV[0].to_s.downcase.include? '-v') || (ARGV[0].to_s.downcase.include? '--V')
      puts "emasser version: #{Emasser::VERSION}".green
      exit
    elsif ARGV[0].to_s.downcase.include? 'hello'
      users = %w{rookie greenhorn novice expert oracle maestro}
      user_name = ENV.fetch('USERNAME', users.sample)
      puts "Hello #{user_name} - enjoy using eMASSer version #{Emasser::VERSION}!".cyan
      exit
    elsif ARGV[0].to_s.downcase.include? 'auth'
      puts 'eMASS Authentication/Authorization Requirements:'.yellow
      puts 'Every call to the eMASS API (via eMASSer) requires the use of a client certificate and an API key.'.cyan
      puts 'A PKI-valid/trusted client certificate must be obtained from the owning eMASS instances that eMASSer is connecting to.'.cyan
      puts 'An API key is also required. To obtain the API key, after configuring the PKI certificate, than'.cyan
      print 'invoke the following API command to retrieve the API key: '.cyan
      print 'emasser post register cert'.underline.green
      puts "\n\n"
      puts 'eMASS Authentication Errors:'.red
      puts 'If the API receives an untrusted certificate, a 403 forbidden response code will be returned.'.cyan
      puts 'If an invalid api-key or combination of client certificate and api-key (from the registered account) is received, a 401 unauthorized response code will be returned.'.cyan
      puts "\n"
      show = Configuration.new
      show.emasser_pki_help
      exit
    elsif (ARGV[0].to_s.downcase.include? 'help') || (ARGV[0].to_s.include? '-')
      puts 'eMASSer Help'.yellow
      puts 'eMASSer makes use of an environment configuration (.env) file for required and optional variables.'.cyan
      puts 'The configuration file containing required variables must be located in the root directory where'.cyan
      print 'the eMASSer command is executed. To create a .env invoke the '.cyan, 'emasser configure'.underline.green, ' command'.cyan
      puts "\n"
      show = Configuration.new
      show.emasser_pki_help
      puts "\n"
      puts 'See eMASSer environment variables requirements in eMASSer CLI Features for more information (https://mitre.github.io/emasser/docs/features.html).'.yellow
      puts 'For eMASS Authentication Requirements invoke the eMASSer API command with the [auth]entication parameter (emasser auth)'.green
      exit
    elsif ARGV[0].to_s.downcase.include? 'configure'
      Configure.configure
      exit
    elsif ARGV.empty?
      puts 'eMASSer commands:'.yellow
      puts '  emasser [get, put, post, delete] or [-h, --h, -v, -V, --version, --Version] or [help, Authentication, Authorization] '.yellow
      exit
    else
      # rubocop: disable Style/TernaryParentheses, Style/IfWithBooleanLiteralBranches, Style/RedundantCondition
      EmassClient.configure do |config|
        # -----------------------------------------------------------------------
        # Required env variables
        config.scheme = 'https'
        config.base_path = '/'
        config.server_index = nil
        config.api_key['api-key'] = raise_unless_present('EMASSER_API_KEY')
        config.host = raise_unless_present('EMASSER_HOST_URL')
        config.key_file = raise_unless_present('EMASSER_KEY_FILE_PATH')
        config.cert_file = raise_unless_present('EMASSER_CERT_FILE_PATH')
        config.key_password = raise_unless_present('EMASSER_KEY_FILE_PASSWORD')

        # Some eMASS instances may not require this variable, others
        # may required for actionable (POST,PUT,DELETE) requests
        config.api_key['user-uid'] = ENV.fetch('EMASSER_USER_UID', '')

        # -----------------------------------------------------------------------
        # Optional env variables
        config.client_side_validation = (ENV.fetch('EMASSER_CLIENT_SIDE_VALIDATION', 'true').eql? 'true') ? true : false
        config.verify_ssl = (ENV.fetch('EMASSER_VERIFY_SSL', 'true').eql? 'true') ? true : false
        config.verify_ssl_host = (ENV.fetch('EMASSER_VERIFY_SSL_HOST', 'true').eql? 'true') ? true : false
        config.debugging = (ENV.fetch('EMASSER_DEBUGGING', 'false') == 'false') ? false : true
        config.temp_folder_path = check_folder_exists('EMASSER_DOWNLOAD_DIR')
      end
      # rubocop: enable Style/TernaryParentheses, Style/IfWithBooleanLiteralBranches, Style/RedundantCondition
    end
  end
end
