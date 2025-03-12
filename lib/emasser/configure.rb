# frozen_string_literal: true

module Emasser::Configure
  require 'tty-prompt'
  require 'tty-cursor'

  class << self

    # Configures the eMASSER application by prompting the user for necessary
    # environment variables and updating the .env file with the provided values.
    #
    # The configuration process includes:
    # - Printing a summary of the current configuration.
    # - Checking if the process should continue.
    # - Generating the .env file if it does not exist.
    # - Prompting the user for required and optional environment variables.
    # - Updating the .env file with the provided values.
    #
    # Required environment variables:
    # - EMASSER_API_KEY: The eMASS API key.
    # - EMASSER_HOST_URL: The eMASS server FQDN URL.
    # - EMASSER_CERT_FILE_PATH: The path to the eMASS client certificate file (cert.pem).
    # - EMASSER_KEY_FILE_PATH: The path to the eMASS private encrypting file (key.pem).
    # - EMASSER_KEY_FILE_PASSWORD: The secret phrase used to protect the encryption key.
    #
    # Optional environment variables:
    # - EMASSER_USER_UID: The eMASS User unique identifier.
    # - EMASSER_CLIENT_SIDE_VALIDATION: Perform client-side validation (default: true).
    # - EMASSER_VERIFY_SSL: Verify SSL certificate when calling the server (default: false).
    # - EMASSER_VERIFY_SSL_HOST: Verify SSL host name when calling the server (default: true).
    # - EMASSER_DEBUGGING: Set debugging (outputs client-server interchange) (default: false).
    # - EMASSER_CLI_DISPLAY_NULL: Display null fields returned from the server (default: false).
    # - EMASSER_EPOCH_TO_DATETIME: Convert epoch date values to datetime (default: true).
    # - EMASSER_DOWNLOAD_DIR: Set the eMASSer download directory (default: eMASSerDownloads).
    def configure
      print_summary

      if !continue_process
        exit
      end         
      
      # -----------------------------------------------------------------------
      # Start the configuration process
      generate_env_file  # Create the .env file if it doesn't exist    
      
      answers = {}
      answers['EMASSER_API_KEY'] = get_required_variable('Provide the eMASS API key', default: 'EMASSER_API_KEY')
      answers['EMASSER_HOST_URL'] = get_required_variable('Provide the eMASS server FQDN URL', default: 'EMASSER_HOST_URL')
      answers['EMASSER_CERT_FILE_PATH'] = very_file_path_exist('Provide the eMASS client certificate file (cert.pem) - include the path', default: 'EMASSER_CERT_FILE_PATH')
      answers['EMASSER_KEY_FILE_PATH'] = very_file_path_exist('Provide the eMASS private encrypting file (key.pem) - include the path', default: 'EMASSER_KEY_FILE_PATH')
      answers['EMASSER_KEY_FILE_PASSWORD'] = get_optional_mask_variable('Provide the secret phrase used to protect the encryption key', default: 'EMASSER_KEY_FILE_PASSWORD')
      # Optional variables
      answers['EMASSER_USER_UID'] = get_optional_variable('Provide the eMASS User unique identifier', default: ENV['EMASSER_USER_UID'])
      answers['EMASSER_CLIENT_SIDE_VALIDATION'] = get_optional_variable('Perform client side validation', default: 'true')
      answers['EMASSER_VERIFY_SSL'] = get_optional_variable('Verify SSL certificate when calling the server', default: 'false')
      answers['EMASSER_VERIFY_SSL_HOST'] = get_optional_variable('Verify SSL host name when calling the server', default: 'true')
      answers['EMASSER_DEBUGGING'] = get_optional_variable('Set debugging (outputs client-server interchange)', default: 'false')
      answers['EMASSER_CLI_DISPLAY_NULL'] = get_optional_variable('Display null fields (returned from server)', default: 'false')
      answers['EMASSER_EPOCH_TO_DATETIME'] = get_optional_variable('Convert epoch date values to datetime', default: 'true')
      answers['EMASSER_DOWNLOAD_DIR'] = get_optional_variable('Set the eMASSer download directory (where exported files are sent)', default: 'eMASSerDownloads')

      # Update the .env file with the answers
      update_key_value_pairs('.env', answers)

    end

    private def print_summary
      puts 'Generate a configuration file (.env) for accessing an eMASS instances.'.blue
      puts 'Authentication to an eMASS instances requires a PKI-valid/trusted client certificate.'.blue
      puts 'The eMASSer CLI accepts a Key/Client pair certificates (.pem). A Unique user identifier (user-uid)'.blue
      puts 'is required by most (some do not require) eMASS integrations for actionable requests.'.blue
      puts

      puts 'Required eMASS configuration variables 👇'.yellow
      # set the output field separator ($) to a carriage return
      $\ = "\n"

      printf("%33s", "EMASSER_API_KEY".blue)
      printf("%55s", "<The eMASS API key (api-key)>\n".green)
      
      printf("%34s", "EMASSER_HOST_URL".blue)
      printf("%85s", "<The Full Qualified Domain Name (FQDN) for the eMASS server>\n".green)
      
      printf("%40s", "EMASSER_CERT_FILE_PATH".blue)
      printf("%72s", "<The eMASS client.pem certificate file in PEM format>\n".green)

      printf("%39s", "EMASSER_KEY_FILE_PATH".blue)
      printf("%70s", "<The eMASS key.pem private key file in PEM format>\n".green)

      printf("%43s", "EMASSER_KEY_FILE_PASSWORD".blue)
      printf("%66s", "<Secret phrase used to protect the encryption key>\n".green)

      puts 'Certain eMASS integrations may not require (most do) this variable 👇'.yellow
      printf("%34s", "EMASSER_USER_UID".blue)
      printf("%71s", "<The eMASS User Unique Identifier (user-uid)>\n\n".green)

      # Optional variables
      puts 'Optional eMASS configuration variables, if not provided defaults are used 👇'.yellow
      printf("%48s", "EMASSER_CLIENT_SIDE_VALIDATION".blue)
      printf("%65s", "<Perform client side validation (default: true)>\n".green)

      printf("%36s", "EMASSER_VERIFY_SSL".blue)
      printf("%94s", "<Verify SSL certificate when calling the server (default: false)>\n".green)

      printf("%41s", "EMASSER_VERIFY_SSL_HOST".blue)
      printf("%86s", "<Verify SSL host name when calling the server (default: true)>\n".green)

      printf("%35s", "EMASSER_DEBUGGING".blue)
      printf("%98s", "<Set debugging (outputs client-server interchange) (default: false)>\n".green)  

      printf("%42s", "EMASSER_CLI_DISPLAY_NULL".blue)
      printf("%86s", "<Display null fields returned from the server (default: false)>\n".green)

      printf("%43s", "EMASSER_EPOCH_TO_DATETIME".blue)
      printf("%77s", "<Convert epoch date values to datetime (default: true)>\n".green)

      printf("%38s", "EMASSER_DOWNLOAD_DIR".blue)
      printf("%91s", "<Set the eMASSer download directory (default: eMASSerDownloads)>\n".green)
      puts
      # Reset the output field separator
      $\ = nil
    end

    private def generate_env_file
      # Check if the file exists
      unless File.exist?('.env')
        # Create the file if it doesn't exist
        File.open('.env', 'w') do |file|
          file.puts "# -----------------------------------------------------------------------------"
          file.puts "# Required environment variables for eMASSer"
          file.puts "EMASSER_API_KEY=''"
          file.puts "EMASSER_HOST_URL=''"
          file.puts "EMASSER_CERT_FILE_PATH=''"
          file.puts "EMASSER_KEY_FILE_PATH=''"
          file.puts "EMASSER_KEY_FILE_PASSWORD=''"
          file.puts "# Required by most eMASS instances for actionable requests (post,put,delete)"
          file.puts "EMASSER_USER_UID=''" 
          file.puts "# -----------------------------------------------------------------------------" 
          file.puts "# Optional environment variables for eMASSer"
          file.puts "EMASSER_CLIENT_SIDE_VALIDATION='true'"
          file.puts "EMASSER_VERIFY_SSL='false'"
          file.puts "EMASSER_VERIFY_SSL_HOST='true'"
          file.puts "EMASSER_DEBUGGING='true'"
          file.puts "EMASSER_CLI_DISPLAY_NULL='false'"
          file.puts "EMASSER_EPOCH_TO_DATETIME='true'"
          file.puts "EMASSER_DOWNLOAD_DIR='eMASSerDownloads'"
        end
        # Load the file into the environment
        Dotenv.load('.env')
        puts '.env file created and loaded.'.green
      else
        puts '.env already exists.'.yellow
      end
    end

    private def continue_process
      prompt = TTY::Prompt.new
      prompt.yes?("Continue with .env configuration process?:".cyan, default: true)
    end
  
    private def get_required_variable(question, default: nil)
      prompt = TTY::Prompt.new(quiet: false, help_color: :yellow, interrupt: :exit)
      prompt.ask("#{question}?:".blue, default: ENV[default], required: true, active_color: :yellow)
    end

    private def very_file_path_exist(question, default: nil)
      prompt = TTY::Prompt.new(quiet: false, help_color: :yellow, interrupt: :exit)
      prompt.ask("#{question}?:".blue, default: ENV[default], required: true, active_color: :yellow, convert: :filepath) do |q|
        q.validate ->(v) { v =~ /.*\.(pem)$/ && File.exist?(v) }
        q.messages[:valid?] = "File does not exist or not a .pem?"
        q.messages[:required?] = "File path must not be empty"
      end 
    end
  
    private def get_optional_variable(question, default: nil)
      prompt = TTY::Prompt.new(quiet: false, help_color: :yellow, interrupt: :exit)
      prompt.ask("#{question}?:".blue, default: default, active_color: :yellow)
    end

    private def get_optional_mask_variable(question, default: nil)
      prompt = TTY::Prompt.new(quiet: false, help_color: :yellow, interrupt: :exit)
      prompt.mask("#{question}?:".blue, default: ENV[default], active_color: :yellow, mask: '*')
    end
  
    private def is_numeric?(value)
      # Check if the value is numeric
      true if Float(value) rescue false
    end
    
    # Updates key-value pairs in a given file.
    #
    # @param [String] file_path The path to the file to be updated.
    # @param [Hash] updates A hash containing key-value pairs to be updated in the file.
    #
    # @return [void]
    #
    # @raise [StandardError] If there is an error reading or writing the file.
    #
    # The method reads the content of the specified file, splits it into lines,
    # and iterates over each line to find and update key-value pairs based on
    # the provided updates hash. If a key from the updates hash is found in the
    # file, its value is updated. String values are wrapped with single quotes
    # if they are not already. The updated content is then written back to the file.
    private def update_key_value_pairs(file_path, updates)
      begin
        # Read the file content
        file_content = File.read(file_path)
    
        # Split the content into lines
        lines = file_content.split("\n")
    
        # Iterate over each line to find and update key-value pairs
        updated_lines = lines.map do |line|
          # Trim the line to remove any leading/trailing whitespace
          trimmed_line = line.strip
    
          # Check if the line contains a key-value pair (e.g., key=value)
          key, _value_ = trimmed_line.split('=', 2)
    
          # If the key exists in the updates hash, update the value
          if updates.has_key?(key)
            # Wrap string values with single-quotes
            updates_value = updates[key]
            if is_numeric?(updates_value)
              "#{key}=#{updates_value}"
            elsif updates_value.is_a?(String) && !updates_value.start_with?("'")
              "#{key}='#{updates_value}'"
            else
              "#{key}=#{updates_value}"
            end
          else
            # Return the original line if no update is needed
            line
          end
        end
    
        # Join the updated lines back into a single string
        updated_content = updated_lines.join("\n")
    
        # Write the updated content back to the file
        File.write(file_path, updated_content)
    
        puts "File (#{file_path}) updated successfully.".green
      rescue => error
        puts "Error reading or writing file: #{error}".red
        exit(1)
      end
    end
  end
end