# frozen_string_literal: true

# rubocop:disable Naming/MethodName

# Hack class that properly formats the CLI help
class SubCommandBase < Thor
  include OptionsParser
  include InputConverters
  include OutputConverters

  # We do not control the method declaration for the banner

  # rubocop:disable Style/OptionalBooleanParameter
  def self.banner(command, _namespace = nil, subcommand = false)
    # Use the $thor_runner (declared by the Thor CLI framework)
    # to properly format the help text of sub-sub-commands.

    # rubocop:disable Style/GlobalVars
    if ancestors[0].to_s.include? '::Get'
      "#{basename} #{command.formatted_usage(self, $thor_runner, subcommand)}"
    else
      "#{basename} get #{command.formatted_usage(self, $thor_runner, subcommand)}"
    end
    # rubocop:enable Style/GlobalVars
  end
  # rubocop:enable Style/OptionalBooleanParameter
end

module Emasser
  # The Test Connection endpoint is provided by eMASS to verify and troubleshoot the
  # connection to the web service.
  #
  # Endpoint:
  #   /api - Test connection to the API
  class Test < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'connection', 'Test connection to the API'

    def connection
      result = EmassClient::TestApi.new.test_connection
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling TestApi->test_connection'.red
      puts to_output_hash(e).split('\n').join('. ')
    end
  end

  # The Systems endpoints provide the ability to view system information.
  #
  # Endpoint:
  #    /api/systems            - Get system information
  #   /api/systems/{systemId} - Get system information for a specific system
  class System < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'id [--system-name [SYSTEM_NAME]] [--system-owner [SYSTEM_OWNER]]',
         'Attempts to provide system ID of a system with name [NAME] and owner [SYSTEM_OWNER]'
    # desc 'id', 'Get a system ID given "name" or "owner"'

    # Required parameters/fields
    option :system_name, aliases: '-n'
    option :system_owner, aliases: '-o'

    def id
      if options[:system_name].nil? && options[:system_owner].nil?
        raise ArgumentError,
              'SYSTEM_NAME or SYSTEM_OWNER is required'
      end

      begin
        results = EmassClient::SystemsApi.new.get_systems.data
        # Convert the Ruby Object (results) to a Hash (hash) and save each hash to an Array (hash_array)
        hash_array = []
        results.each do |element|
          hash = {}
          # instance_variables returns an array of object’s instance variables
          # instance_variable_get returns the value of the instance variable, given the variable name
          element.instance_variables.each do |v|
            hash[v.to_s.delete('@')] = element.instance_variable_get(v)
          end
          hash_array.push(hash)
        end
        # Filter the hash array based on provided options
        results = filter_systems(hash_array, options[:system_name], options[:system_owner])
        # Output the filtered results
        results.each { |result| puts "#{result['system_id']} - #{result['owning_organization']} - #{result['name']}" }
      rescue EmassClient::ApiError => e
        puts 'Exception when calling SystemsApi->get_systems'
        puts to_output_hash(e)
      end
    end

    no_commands do
      def filter_systems(results, system_name = nil, system_owner = nil)
        if system_owner.nil?
          results.filter { |result| result['name'].eql?(system_name) }
        elsif system_name.nil?
          results.filter { |result| result['owning_organization'].eql?(system_owner) }
        else
          results.filter { |result| result['name'].eql?(system_name) && result['owning_organization'].eql?(system_owner) }
        end
      end
    end

    desc 'byId [options]', 'Retrieve a system - filtered by [options] params'
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :policy, aliases: '-p', type: :string, required: false, enum: %w[diacap rmf reporting]

    def byId
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)
      # optional_options.merge!(Emasser::GET_SYSTEM_RETURN_TYPE)

      begin
        # Get system information matching provided parameters
        result = EmassClient::SystemsApi.new.get_system(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling SystemsApi->get_systems'.red
        puts to_output_hash(e).split('\n').join('. ')
      end
    end
  end

  class Systems < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'all [options]', 'Retrieves all available system(s) - filtered by [options] params'
    # Optional parameters/fields
    option :registrationType, aliases: '-r',
           type: :string, required: false,
           enum: %w[assessAndAuthorize assessOnly guest regular functional cloudServiceProvider commonControlProvider]
    option :ditprId, aliases: '-t', type: :string,  required: false,
                     desc: 'DoD Information Technology (IT) Portfolio Repository (DITPR) string Id'
    option :coamsId, aliases: '-c', type: :string,  required: false,
                     desc: 'Cyber Operational Attributes Management System (COAMS) string Id'
    option :policy, aliases: '-p', type: :string, required: false, enum: %w[diacap rmf reporting]
    option :includeDitprMetrics, aliases: '-M', type: :boolean, required: false, desc: 'BOOLEAN - true or false.'
    option :includeDecommissioned, aliases: '-D', type: :boolean, required: false, desc: 'BOOLEAN - true or false.'
    option :reportsForScorecard, aliases: '-S', type: :boolean, required: false, desc: 'BOOLEAN - true or false.'

    def all
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)
      # optional_options.merge!(Emasser::GET_SYSTEM_RETURN_TYPE)

      begin
        # Get system information matching provided parameters
        result = EmassClient::SystemsApi.new.get_systems(optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling SystemsApi->get_systems'.red
        puts to_output_hash(e)
      end
    end
  end

  # The System Roles endpoints provides the ability to access user data assigned to systems.
  # Notes:
  #    The endpoint can access three different role categories: PAC, CAC, and Other.
  #    If a system is dual-policy enabled, the returned system role information will default
  #    to the RMF policy information unless otherwise specified.
  #
  # Endpoint:
  #    /api/system-roles                - Get all available roles
  #   /api/system-roles/{roleCategory} - Get system roles for provided role catgory
  class Roles < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'all', 'Retrieves all available system roles'

    def all
      result = EmassClient::SystemRolesApi.new.get_system_roles
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemRolesApi->get_system_roles'.red
      puts to_output_hash(e)
    end

    desc 'byCategory [options]', 'Retrieves role(s) - filtered by [options] params'
    # Required parameters/fields
    option :roleCategory, aliases: '-c', type: :string, required: true, enum: %w[PAC CAC Other]
    option :role, aliases: '-r', type: :string, required: true,
                          desc: 'Accepts single value from options available at base system-roles endpoint e.g., SCA.'

    # Optional parameters/fields
    option :policy, aliases: '-p', type: :string, required: false, enum: %w[diacap rmf reporting]

    def byCategory
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = EmassClient::SystemRolesApi.new.get_system_roles_by_category_id(options[:roleCategory],
                                                                                 options[:role], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling SystemRolesApi->get_system_by_role_category_id'.red
        puts to_output_hash(e)
      end
    end
  end

  # The Controls endpoints provide the ability to view Security Control information
  # of a system for both the Implementation Plan and Risk Assessment.
  #
  # Endpoint:
  #    /api/systems/{systemId}/controls - Get control information in a system for one or many controls
  class Controls < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'forSystem', 'Get control information in a system for one or many controls (acronym)'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :acronyms, aliases: '-a', type: :string, required: false,
              desc: 'The system acronym(s) e.g "AC-1, AC-2" - if not provided all controls for systemId are returned'

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = EmassClient::ControlsApi.new.get_system_controls(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ControlsApi->get_system_controls'.red
        puts to_output_hash(e)
      end
    end
  end

  # The Test Results endpoints provide the ability to view test results for a
  # system's Assessment Procedures (CCIs) which determine Security Control compliance.
  #
  # Endpoint:
  #    /api/systems/{systemId}/test-results - Get one or many test results in a system
  class TestResults < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'forSystem', 'Get one or many test results in a system'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :controlAcronyms, aliases: '-a', type: :string, required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :assessmentProcedures, aliases: '-p', type: :string, required: false,
                                  desc: 'The system Security Control Assessment Procedure e.g "AC-1.1,AC-1.2"'
    option :ccis, aliases: '-c', type: :string,  required: false, desc: 'The system CCIS string numerical value'
    option :latestOnly, aliases: '-L', type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = EmassClient::TestResultsApi.new.get_system_test_results(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling TestResultsApi->get_system_test_results'.red
        puts to_output_hash(e)
      end
    end
  end

  # The POA&Ms endpoints provide the ability to view Plan of Action and Milestones (POA&M)
  # items and associated milestones for a system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams           - Get one or many POA&M items in a system
  #   /api/systems/{systemId}/poams/{poamId}  - Get POA&M item by ID in a system
  class Poams < SubCommandBase
    def self.exit_on_failure?
      true
    end

    # BY SYSTEM ID ------------------------------------------------------------------
    desc 'forSystem', 'Get one or many POA&M items in a system'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric,  required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :scheduledCompletionDateStart, aliases: '-d', type: :numeric, required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd, aliases: '-e', type: :numeric, required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'
    option :controlAcronyms, aliases: '-a', type: :string, required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :assessmentProcedures, aliases: '-p', type: :string, required: false,
                                  desc: 'The system Security Control Assessment Procedure e.g "AC-1.1,AC-1.2"'
    option :ccis, aliases: '-c', type: :string, required: false, desc: 'The system CCIS string numerical value'
    option :systemOnly, aliases: '-Y', type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = EmassClient::POAMApi.new.get_system_poams(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling POAMApi->get_system_poams'.red
        puts to_output_hash(e)
      end
    end

    # BY POAM ID --------------------------------------------------------------
    desc 'byPoamId', 'Get POA&M item for given systemId and poamId'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :poamId, aliases: '-p', type: :numeric, required: true,
                      desc: 'A numeric value representing the poam identification'

    def byPoamId
      result = EmassClient::POAMApi.new.get_system_poams_by_poam_id(options[:systemId], options[:poamId])
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling POAMApi->get_system_poams_by_poam_id'.red
      puts to_output_hash(e)
    end
  end

  # The Milestones endpoints provide the ability to view milestones that are associated
  # with Plan of Action and Milestones (POA&M) items for a system.
  #
  #   /api/systems/{systemId}/poams/{poamId}/milestones - Get milestones in one or many POA&M items in a system
  #   /api/systems/{systemId}/poams/{poamId}/milestones/{milestoneId} - Get milestone by ID in POA&M item in a system
  class Milestones < SubCommandBase
    def self.exit_on_failure?
      true
    end
    # MILSTONES by SYSTEM and POAM ID -----------------------------------------
    desc 'byPoamId', 'Get milestone(s) for given specified system and poam'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :poamId, aliases: '-p', type: :numeric, required: true,
                      desc: 'A numeric value representing the poam identification'
    # Optional parameters/fields
    option :scheduledCompletionDateStart, aliases: '-d', type: :numeric, required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd, aliases: '-e', type: :numeric, required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'

    def byPoamId
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get milestones in one or many poa&m items in a system
        result = EmassClient::MilestonesApi.new.get_system_milestones_by_poam_id(options[:systemId],
                                                                                 options[:poamId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling MilestonesApi->get_system_milestones_by_poam_id'.red
        puts to_output_hash(e)
      end
    end

    # MILSTONES by SYSTEM, POAM, and MILESTONE ID -----------------------------------------
    desc 'byMilestoneId', 'Get milestone(s) for given specified system, poam, and milestone Id'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                         desc: 'A numeric value representing the system identification'
    option :poamId, aliases: '-p', type: :numeric, required: true,
                         desc: 'A numeric value representing the poam identification'
    option :milestoneId, aliases: '-m', type: :numeric, required: true,
                         desc: 'A numeric value representing the milestone identification'

    def byMilestoneId
      result = EmassClient::MilestonesApi.new.get_system_milestones_by_poam_id_and_milestone_id(
        options[:systemId], options[:poamId], options[:milestoneId]
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling MilestonesApi->get_system_milestones_by_poam_id_and_milestone_id'.red
      puts to_output_hash(e)
    end
  end

  # The Artifact endpoints provide the ability to view Artifacts
  # (supporting documentation/evidence for Security Control Assessments
  # and system Authorization activities) for a system.
  #
  # Endpoints:
  #    /api/systems/{systemId}/artifacts        - Get one or many artifacts in a system
  #    /api/systems/{systemId}/artifacts-export - Get the file of an artifact in a system
  class Artifacts < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'forSystem', 'Get all system artifacts for a system Id'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :filename, aliases: '-f', type: :string,  required: false, desc: 'The artifact file name'
    option :controlAcronyms, aliases: '-a', type: :string, required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :assessmentProcedures, aliases: '-p', type: :string, required: false,
                                  desc: 'The system Security Control Assessment Procedure e.g "AC-1.1,AC-1.2"'
    option :ccis, aliases: '-c', type: :string, required: false, desc: 'The system CCIS string numerical value'
    option :systemOnly, aliases: '-Y', type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get one or many artifacts in a system
        result = EmassClient::ArtifactsApi.new.get_system_artifacts(options[:systemId],
                                                                    optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ArtifactsApi->get_system_artifacts'.red
        puts to_output_hash(e)
      end
    end

    desc 'export', 'Get artifact binary file associated with given filename'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :filename, aliases: '-f', type: :string,  required: true, desc: 'The artifact file name'
    option :compress, aliases: '-C', type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    option :printToStdout, aliases: '-o', required: false, desc: 'Output file content to terminal - not valid for zip files'
    # NOTE: compress is a required parameter, however Thor does not allow a boolean type to be required because it
    # automatically creates a --no-compress option, which is confusing in the help output:
    #     [--compress], [--no-compress]  # BOOLEAN - true or false.

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def export
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      if options[:printToStdout]
        optional_options.merge!(Emasser::GET_ARTIFACTS_RETURN_TYPE)
        if options[:compress]
          puts 'Output to stdout - compress'.yellow
        else
          puts 'Output to stdout - plain text'.yellow
        end
      else
        # The api method get_system_artifacts_export default return type is
        # file, and it will output the file to the configured EMASSER_DOWNLOAD_DIR
        # or to the default output folder 'eMASSerDownloads'
        export_dir = ENV.fetch('EMASSER_DOWNLOAD_DIR', '')
        export_dir = 'eMASSerDownloads' if export_dir.empty?
        puts "Output to #{export_dir} directory".yellow
      end

      result = EmassClient::ArtifactsExportApi.new.get_system_artifacts_export(
        options[:systemId], options[:filename], optional_options
      )

      unless File.extname(options[:filename]).eql? '.zip'
        # rubocop:disable Style/SoleNestedConditional, Metrics/BlockNesting
        if options[:printToStdout]
          if options[:compress]
            puts result.green
          else
            begin
              puts JSON.pretty_generate(JSON.parse(result)).green
            rescue StandardError
              puts result.red
            end
          end
        end
      end
      # rubocop:enable Style/SoleNestedConditional, Metrics/BlockNesting
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ArtifactsApi->get_system_artifacts_export'.red
      puts to_output_hash(e)
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  # The Control Approval Chain (CAC) endpoints provide the ability to view the status of
  # Security Controls and submit them to the second stage in the Control Approval Chain
  # Note:
  #  POST requests will only yield successful results if the Security Control is at the first
  #  stage of the CAC. If the control is not at the first stage, an error will be returned.
  #
  # Endpoints:
  #    /api/systems/{systemId}/approval/cac - Get location of one or many controls in CAC
  class CAC < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'controls', 'Get location of one or many controls in CAC'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :controlAcronyms, aliases: '-a', type: :string, required: false,
              desc: 'The system acronym(s) e.g "AC-1, AC-2" - if not provided all CACs for systemId are returned'

    def controls
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get location of one or many controls in CAC
        result = EmassClient::CACApi.new.get_system_cac(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling CACApi->get_system_cac'.red
        puts to_output_hash(e)
      end
    end
  end

  # The Package Approval Chain (PAC) endpoints provides the ability to view the
  # status of existing workflows and initiate new workflows for a system.
  #
  # Notes:
  #   - If the indicated system has any active workflows, the response will include
  #     information such as the workflow type and the current stage of each workflow.
  #   - If there are no active workflows, then a null data member will be returned.
  #
  # Endpoints:
  #    /api/systems/{systemId}/approval/pac - Get location of system package in PAC
  class PAC < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'package', 'Get location of system package in PAC'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'

    def package
      # Get location of system package in PAC
      result = EmassClient::PACApi.new.get_system_pac(options[:systemId])
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling PACApi->get_system_pac'.red
      puts to_output_hash(e)
    end
  end

  # The Hardware Baseline endpoints provides the ability to view the
  # hardware assets for a system.
  #
  # Endpoints:
  #    /api/systems/{systemId}/hw-baseline - Get one or many hardware assets in a system
  class Hardware < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'assets', 'Get one or many hardware assets in a system'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'

    # Optional parameters/fields
    option :pageIndex, aliases: '-i', type: :numeric, required: false, desc: 'The page number to be returned, if not specified starts at page 0'
    option :pageSize, aliases: '-s', type: :numeric, required: false, desc: 'The total entries per page, default is 20,000'

    def assets
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get hardware assets form provided system
        result = EmassClient::HardwareBaselineApi.new.get_system_hw_baseline(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling HardwareBaselineApi->get_system_hw_baseline'.red
        puts to_output_hash(e)
      end
    end
  end

  # The Software Baseline endpoints provides the ability to view the
  # software assets for a system.
  #
  # Endpoints:
  #    /api/systems/{systemId}/sw-baseline - Get one or many software assets in a system
  class Software < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'assets', 'Get one or many software assets in a system'
    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'

    # Optional parameters/fields
    option :pageIndex, aliases: '-i', type: :numeric, required: false, desc: 'The page number to be returned, if not specified starts at page 0'
    option :pageSize, aliases: '-s', type: :numeric, required: false, desc: 'The total entries per page, default is 20,000'

    def assets
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get software assets for given system
        result = EmassClient::SoftwareBaselineApi.new.get_system_sw_baseline(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling SoftwareBaselineApi->get_system_sw_baseline'.red
        puts to_output_hash(e)
      end
    end
  end

  # The Workflow Definitions endpoint provides the ability to view all workflow schemas
  # available on the eMASS instance. Every transition for each workflow stage is included.
  #
  # Endpoints:
  #    /api/workflow-definitions - Get workflow definitions in a site
  class WorkflowDefinitions < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'forSite', 'Get location of system package in PAC'

    # Optional parameters/fields
    option :includeInactive, aliases: '-I', type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    option :registrationType, aliases: '-r',
           type: :string, required: false,
           enum: %w[assessAndAuthorize assessOnly guest regular functional cloudServiceProvider commonControlProvider authorityToUse reciprocityAcceptance]

    def forSite
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::WorkflowDefinitionsApi.new.get_workflow_definitions(optional_options)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_workflow_definitions'.red
      puts to_output_hash(e)
    end
  end

  # The Workflow Instances endpoint provides the ability to view detailed information on all
  # active and historical workflows for a system.
  #
  # Endpoints:
  #    /api/systems/{systemId}/workflow-instances                      - Get workflow instances in a system
  #    /api/systems/{systemId}/workflow-instances/{workflowInstanceId} - Get workflow instance by ID in a system
  class WorkflowInstances < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'all', 'Get detailed information for all active and historical workflows'
    # Optional parameters/fields
    option :includeComments, aliases: '-C', type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    option :includeDecommissionSystems, aliases: '-D', type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    option :pageIndex, aliases: '-p', type: :numeric, required: false, desc: 'The page number to be returned'
    option :sinceDate, aliases: '-d', type: :string, required: false, desc: 'The workflow instance date. Unix date format'
    option :status, aliases: '-s', type: :string, required: false, enum: %w[active inactive all]

    def all
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::WorkflowInstancesApi.new.get_system_workflow_instances(optional_options)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_system_workflow_instances'.red
      puts to_output_hash(e)
    end

    # Workflow by workflowInstanceId ---------------------------------------------------------
    desc 'byInstanceId', 'Get workflow instance by ID in a system'

    # Required parameters/fields
    option :workflowInstanceId, aliases: '-w', type: :numeric, required: true,
                                desc: 'A numeric value representing the workflowInstance identification'

    def byInstanceId
      # opts = Emasser::GET_WORKFLOWINSTANCES_RETURN_TYPE

      result = EmassClient::WorkflowInstancesApi
               .new.get_system_workflow_instances_by_workflow_instance_id(options[:workflowInstanceId])
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_system_workflow_instances_by_workflow_instance_id'.red
      puts to_output_hash(e)
    end
  end

  # The Cybersecurity Maturity Model Certification (CMMC) Assessments endpoint provides
  # the ability to view CMMC assessment information. It is available to CMMC eMASS only.
  #
  # Endpoints:
  #    /api/cmmc-assessments - Get CMMC assessment information
  class CMMC < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'assessments', 'Get CMMC assessment information'
    long_desc Help.text(:cmmc_get_mapper)

    # Required parameters/fields
    option :sinceDate, aliases: '-d', type: :string, required: true, desc: 'The CMMC date. Unix date format'

    def assessments
      result = EmassClient::CMMCAssessmentsApi.new.get_cmmc_assessments(options[:sinceDate])
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_cmmc_assessments'.red
      puts to_output_hash(e)
    end
  end

  # The Dashboards endpoints provide the ability to view data contained in dashboard exports.
  # In the eMASS frontend, these dashboard exports are generated as Excel exports.
  # Each dashboard dataset available from the API is automatically updated with the current
  # configuration of the dashboard and the instance of eMASS as the dashboard changes.
  #
  # Endpoints: (57)
  # ---------------------------------------------------------------------------
  # System Status Dashboard
  #  /api/dashboards/system-status-details
  # ---------------------------------------------------------------------------
  # System Terms / Conditions Dashboards
  #  /api/dashboards/system-terms-conditions-summary
  #  /api/dashboards/system-terms-conditions-details
  # ---------------------------------------------------------------------------
  # System Connectivity/CCSD
  #  /api/dashboards/system-connectivity-ccsd-summary
  #  /api/dashboards/system-connectivity-ccsd-details
  # ---------------------------------------------------------------------------
  # System ATC/IATC
  #  /api/dashboards/system-atc-iatc-details
  # ---------------------------------------------------------------------------
  # System Questionnaire
  #   /api/dashboards/system-questionnaire-summary
  #   /api/dashboards/system-questionnaire-details
  # ---------------------------------------------------------------------------
  # System Workflows Dashboard
  #  /api/dashboards/system-workflows-history-summary
  #  /api/dashboards/system-workflows-history-details
  #  /api/dashboards/system-workflows-history-stage-details
  # ---------------------------------------------------------------------------
  # System Security Controls Dashboard
  #  /api/dashboards/system-control-compliance-summary
  #  /api/dashboards/system-security-controls-details
  #  /api/dashboards/system-assessment-procedures-details
  # ---------------------------------------------------------------------------
  # System POA&M Dashboards
  #  /api/dashboards/system-poam-summary
  #  /api/dashboards/system-poam-details
  # ---------------------------------------------------------------------------
  # System Artifacts Dashboards
  #  /api/dashboards/system-artifacts-summary
  #  /api/dashboards/system-artifacts-details
  # ---------------------------------------------------------------------------
  # System Hardware Dashboards
  #  /api/dashboards/system-hardware-summary
  #  /api/dashboards/system-hardware-details
  # ---------------------------------------------------------------------------
  # System Sensor Hardware Dashboards
  #  /api/dashboards/system-sensor-hardware-summary
  #  /api/dashboards/system-sensor-hardware-details
  # ---------------------------------------------------------------------------
  # System Software Dashboards
  #  /api/dashboards/system-software-summary
  #  /api/dashboards/system-software-details
  # ---------------------------------------------------------------------------
  # System Sensor Software Dashboards
  #  /api/dashboards/system-sensor-software-summary
  #  /api/dashboards/system-sensor-software-details
  #  /api/dashboards/system-sensor-software-counts
  #--------------------------------------------------------------------------
  # System Critical Assets
  #   /api/dashboards/system-critical-assets-summary
  #--------------------------------------------------------------------------
  # System Vulnerability Dashboards
  #   /api/dashboards/system-vulnerability-summary
  # ---------------------------------------------------------------------------
  # System Device Findings Dashboards
  #   /api/dashboards/system-device-findings-summary
  #   /api/dashboards/system-device-findings-details
  #--------------------------------------------------------------------------
  # System Applications Findings Dashboards
  #   /api/dashboards/system-application-findings-summary
  #   /api/dashboards/system-application-findings-details
  # ---------------------------------------------------------------------------
  # Ports and Protocols Dashboards
  #   /api/dashboards/system-ports-protocols-summary
  #   /api/dashboards/system-ports-protocols-details
  #----------------------------------------------------------------------------
  # System CONMON Integration Status Dashboard
  #   /api/dashboards/system-conmon-integration-status-summary
  #----------------------------------------------------------------------------
  # System Associations Dashboard
  #   /api/dashboards/system-associations-details
  #----------------------------------------------------------------------------
  # User System Assignments Dashboard
  #   /api/dashboards/user-system-assignments-details
  #----------------------------------------------------------------------------
  # Organization Migration Status
  #	  /api/dashboards/organization-migration-status-summary
  #----------------------------------------------------------------------------
  # System Migration Status
  #   /api/dashboards/system-migration-status-summary
  #----------------------------------------------------------------------------
  # System FISMA Metrics
  #   /api/dashboards/system-fisma-metrics
  #----------------------------------------------------------------------------
  # Coast Guard System FISMA Metrics
  #	  /api/dashboards/coastguard-system-fisma-metrics
  #----------------------------------------------------------------------------
  # System Privacy Dashboards
  #   /api/dashboards/system-privacy-summary
  #--------------------------------------------------------------------------
  # VA OMB FISMA
  #   /api/dashboards/va-omb-fisma-saop-summary
  #----------------------------------------------------------------------------
  # VA Systems Dashboard
  #   /api/dashboards/va-system-icamp-tableau-poam-details
  #   /api/dashboards/va-system-aa-summary
  #   /api/dashboards/va-system-a2-summary
  #   /api/dashboards/va-system-pl-109-reporting-summary
  #   /api/dashboards/va-system-fisma-inventory-summary
  #   /api/dashboards/va-system-fisma-inventory-crypto-summary
  #   /api/dashboards/va-system-threat-risks-summary
  #   /api/dashboards/va-system-threat-sources-details
  #   /api/dashboards/va-system-threat-architecture-details
  #----------------------------------------------------------------------------
  # CMMC Assessment Dashboards
  #   /api/dashboards/cmmc-assessment-status-summary
  #   /api/dashboards/cmmc-assessment-requirements-compliance-summary
  #   /api/dashboards/cmmc-assessment-security-requirements-details
  #   /api/dashboards/cmmc-assessment-requirement-objectives-details

  class Dashboards < SubCommandBase
    def self.exit_on_failure?
      true
    end

    # Required parameters/fields
    class_option :orgId, aliases: '-o', type: :numeric, required: true,
                 desc: 'A numeric value representing the system identification'

    # Optional parameters/fields
    class_option :excludeinherited, aliases: '-I', type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false, default false.'
    class_option :pageIndex, aliases: '-i', type: :numeric, required: false, desc: 'The page number to be returned, if not specified starts at page 0'
    class_option :pageSize, aliases: '-s', type: :numeric, required: false, desc: 'The total entries per page, default is 20,000'

    #--------------------------------------------------------------------------
    # System Status Dashboard
    # /api/dashboards/system-status-details
    desc 'status_details', 'Get systems status detail dashboard information'
    def status_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemStatusDashboardApi.new.get_system_status_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemStatusDashboardApi->get_system_status_details'.red
      puts to_output_hash(e)
    end

    #----------------------------------------------------------------------------
    # System Terms / Conditions Dashboards
    #  /api/dashboards/system-terms-conditions-summary
    desc 'terms_conditions_summary', 'Get systems terms conditions summary dashboard information'
    def terms_conditions_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemTermsConditionsDashboardsApi.new.get_system_terms_conditions_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemTermsConditionsDashboardsApi->get_system_terms_conditions_summary'.red
      puts to_output_hash(e)
    end

    #  /api/dashboards/system-terms-conditions-details
    desc 'terms_conditions_details', 'Get systems terms conditions details dashboard information'
    def terms_conditions_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemTermsConditionsDashboardsApi.new.get_system_terms_conditions_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemTermsConditionsDashboardsApi->get_system_terms_conditions_details'.red
      puts to_output_hash(e)
    end

    # ---------------------------------------------------------------------------
    # System Connectivity/CCSD
    #  /api/dashboards/system-connectivity-ccsd-summary
    desc 'connectivity_ccsd_summary', 'Get systems connectivity CCSD summary dashboard information'
    def connectivity_ccsd_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemConnectivityCCSDDashboardsApi.new.get_system_connectivity_ccsd_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemConnectivityCCSDDashboardsApi->get_system_connectivity_ccsd_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-connectivity-ccsd-details
    desc 'connectivity_ccsd_details', 'Get systems connectivity CCSD details dashboard information'
    def connectivity_ccsd_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemConnectivityCCSDDashboardsApi.new.get_system_connectivity_ccsd_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemConnectivityCCSDDashboardsApi->get_system_connectivity_ccsd_details'.red
      puts to_output_hash(e)
    end

    # ---------------------------------------------------------------------------
    # System ATC/IATC
    #  /api/dashboards/system-atc-iatc-details
    desc 'atc_iatc_details', 'Get systems ATC/IATC details dashboard information'
    def atc_iatc_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemATCIATCDashboardApi.new.get_system_atc_iatc_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemATCIATCDashboardApi->get_system_atc_iatc_details'.red
      puts to_output_hash(e)
    end

    # ---------------------------------------------------------------------------
    # System Questionnaire
    #   /api/dashboards/system-questionnaire-summary
    desc 'questionnaire_summary', 'Get systems connequestionnaire summary dashboard information'
    def questionnaire_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemQuestionnaireDashboardsApi.new.get_system_questionnaire_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemQuestionnaireDashboardsApi->get_system_questionnaire_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-questionnaire-details
    desc 'questionnaire_details', 'Get systems connequestionnaire details dashboard information'
    def questionnaire_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemQuestionnaireDashboardsApi.new.get_system_questionnaire_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemQuestionnaireDashboardsApi->get_system_questionnaire_details'.red
      puts to_output_hash(e)
    end

    # ---------------------------------------------------------------------------
    # System Workflows Dashboard
    #  /api/dashboards/system-workflows-history-summary
    desc 'workflows_history_summary', 'Get system workflows history summary dashboard information'
    def workflows_history_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemWorkflowsDashboardsApi.new.get_system_workflows_history_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemWorkflowsDashboardsApi->get_system_workflows_history_summary'.red
      puts to_output_hash(e)
    end
    #--------------------------------------------------------------------------
    #  /api/dashboards/system-workflows-history-details
    desc 'workflows_history_details', 'Get system workflows history details dashboard information'
    def workflows_history_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemWorkflowsDashboardsApi.new.get_system_workflows_history_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemWorkflowsDashboardsApi->get_system_workflows_history_details'.red
      puts to_output_hash(e)
    end
    #--------------------------------------------------------------------------
    #  /api/dashboards/system-workflows-history-stage-details
    desc 'workflows_history_stage_details', 'Get system workflows history stage detail dashboard information'
    def workflows_history_stage_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemWorkflowsDashboardsApi.new.get_system_workflows_history_stage_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemWorkflowsDashboardsApi->get_system_workflows_history_stage_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Security Controls Dashboards
    # /api/dashboards/system-control-compliance-summary
    desc 'control_compliance_summary', 'Get systems control compliance summary dashboard information'
    def control_compliance_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSecurityControlsDashboardsApi.new.get_system_control_compliance_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSecurityControlsDashboardsApi->get_system_control_compliance_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-security-controls-details
    desc 'security_control_details', 'Get systems security control details dashboard information'
    def security_controls_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSecurityControlsDashboardsApi.new.get_system_security_control_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSecurityControlsDashboardsApi->get_system_security_control_details'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-assessment-procedures-details
    desc 'assessment_procedures_details', 'Get systems assessement procdures details dashboard information'
    def assessment_procedures_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSecurityControlsDashboardsApi.new.get_system_assessment_procedures_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSecurityControlsDashboardsApi->get_system_assessment_procedures_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Ststem POA&M Dashboard
    # /api/dashboards/system-poam-summary
    desc 'poam_summary', 'Get systems POA&Ms summary dashboard information'
    def poam_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemPOAMDashboardsApi.new.get_system_poam_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemPOAMDashboardsApi->get_system_poam_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-poam-details
    desc 'poam_details', 'Get system POA&Ms details dashboard information'
    def poam_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemPOAMDashboardsApi.new.get_system_poam_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemPOAMDashboardsApi->get_system_poam_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Artifacts Dashboard
    # /api/dashboards/system-artifacts-summary
    desc 'artifacts_summary', 'Get systems artifacts summary dashboard information'
    def artifacts_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemArtifactsDashboardsApi.new.get_system_artifacts_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemArtifactsDashboardsApi->get_system_artifacts_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-artifacts-details
    desc 'artifacts_details', 'Get systems artifacts summary dashboard information'
    def artifacts_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemArtifactsDashboardsApi.new.get_system_artifacts_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemArtifactsDashboardsApi->get_system_artifacts_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Hardware Dashboard
    # /api/dashboards/system-hardware-summary
    desc 'hardware_summary', 'Get system hardware summary dashboard information'
    def hardware_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemHardwareDashboardsApi.new.get_system_hardware_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemHardwareDashboardsApi->get_system_hardware_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-hardware-details
    desc 'hardware_details', 'Get system hardware details dashboard information'
    def hardware_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemHardwareDashboardsApi.new.get_system_hardware_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemHardwareDashboardsApi->get_system_hardware_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Sensor Hardware Dashboard
    # /api/dashboards/system-sensor-hardware-summary
    desc 'sensor_hardware_summary', 'Get system sensor hardware summary dashboard information'
    def sensor_hardware_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSensorHardwareDashboardsApi.new.get_system_sensor_hardware_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSensorHardwareDashboardsApi->get_system_sensor_hardware_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-sensor-hardware-details
    desc 'sensor_hardware_details', 'Get system sensor hardware details dashboard information'
    def sensor_hardware_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSensorHardwareDashboardsApi.new.get_system_sensor_hardware_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSensorHardwareDashboardsApi->get_system_sensor_hardware_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Software Dashboards
    # /api/dashboards/system-software-summary
    desc 'software_summary', 'Get system software summary dashboard information'
    def software_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSoftwareDashboardsApi.new.get_system_software_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSoftwareDashboardsApi->get_system_software_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-software-details
    desc 'software_details', 'Get system software details dashboard information'
    def software_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSoftwareDashboardsApi.new.get_system_software_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSoftwareDashboardsApi->get_system_software_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Sensor Software Dashboards
    # /api/dashboards/system-sensor-software-summary
    desc 'sensor_software_summary', 'Get system sensor software summary dashboard information'
    def sensor_software_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSensorSoftwareDashboardsApi.new.get_system_sensor_software_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSensorSoftwareDashboardsApi->get_system_sensor_software_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-sensor-software-details
    desc 'sensor_software_details', 'Get system sensor software details dashboard information'
    def sensor_software_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSensorSoftwareDashboardsApi.new.get_system_sensor_software_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSensorSoftwareDashboardsApi->get_system_sensor_software_details'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-sensor-software-counts
    desc 'sensor_software_counts', 'Get system sensor software counts dashboard information'
    def sensor_software_counts
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemSensorSoftwareDashboardsApi.new.get_system_sensor_software_counts(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemSensorSoftwareDashboardsApi->get_system_sensor_software_counts'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Critical Assets
    # /api/dashboards/system-critical-assets-summary
    desc 'critical_assets_summary', 'Get system critical assets summary dashboard information'
    def critical_assets_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemCriticalAssetsDashboardApi.new.get_system_critical_assets_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemCriticalAssetsDashboardApi->get_system_critical_assets_summary'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Vulnerability Dashboards
    # /api/dashboards/system-vulnerability-summary
    desc 'vulnerability_summary', 'Get system vulnerability summary dashboard information'
    def vulnerability_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemVulnerabilityDashboardApi.new.get_system_vulnerability_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemVulnerabilityDashboardApi->get_system_vulnerability_summary'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Device Findings Dashboards
    # /api/dashboards/system-device-findings-summary
    desc 'device_findings_summary', 'Get system device findings summary dashboard information'
    def device_findings_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemDeviceFindingsDashboardsApi.new.get_system_device_findings_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemDeviceFindingsDashboardsApi->get_system_device_findings_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-device-findings-details
    desc 'device_findings_details', 'Get system device findings details dashboard information'
    def device_findings_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemDeviceFindingsDashboardsApi.new.get_system_device_findings_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemDeviceFindingsDashboardsApi->get_system_device_findings_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Applications Findings Dashboards
    # /api/dashboards/system-application-findings-summary
    desc 'application_findings_summary', 'Get system device findings summary dashboard information'
    def application_findings_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemApplicationFindingsDashboardsApi.new.get_system_application_findings_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemApplicationFindingsDashboardsApi->get_system_application_findings_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-application-findings-details
    desc 'application_findings_details', 'Get system device findings details dashboard information'
    def application_findings_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemApplicationFindingsDashboardsApi.new.get_system_application_findings_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemApplicationFindingsDashboardsApi->get_system_application_findings_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Ports and Protocols Dashboards
    # /api/dashboards/system-ports-protocols-summary
    desc 'ports_protocols_summary', 'Get system ports & portocols summary dashboard information'
    def ports_protocols_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemPortsProtocolsDashboardsApi.new.get_system_ports_protocols_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemPortsProtocolsDashboardsApi->get_system_ports_protocols_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-ports-protocols-details
    desc 'ports_protocols_details', 'Get system ports & portocols details dashboard information'
    def ports_protocols_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemPortsProtocolsDashboardsApi.new.get_system_ports_protocols_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemPortsProtocolsDashboardsApi->get_system_ports_protocols_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System CONMON Integration Status Dashboard
    # /api/dashboards/system-conmon-integration-status-summary
    desc 'integration_status_summary', 'Get system conmon integration status summary dashboard information'
    def integration_status_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemCONMONIntegrationStatusDashboardApi.new.get_system_common_integration_status_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemCONMONIntegrationStatusDashboardApi->get_system_common_integration_status_summary'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Associations Dashboard
    # /api/dashboards/system-associations-details
    desc 'associations_details', 'Get system associations details dashboard information'
    def associations_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemAssociationsDashboardApi.new.get_system_associations_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemAssociationsDashboardApi->get_system_associations_details'.red
      puts to_output_hash(e)
    end

    #----------------------------------------------------------------------------
    # User System Assignments Dashboard
    # /api/dashboards/user-system-assignments-details
    desc 'assignments_details', 'Get user system assignments details dashboard information'
    def assignments_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::UserSystemAssignmentsDashboardApi.new.get_user_system_assignments_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling UserSystemAssignmentsDashboardApi->get_user_system_assignments_details'.red
      puts to_output_hash(e)
    end

    #----------------------------------------------------------------------------
    # Organization Migration Status
    #	 /api/dashboards/organization-migration-status-summary
    desc 'organization_migration_status_summary', 'Get organization migration status summary dashboard information'
    def organization_migration_status_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::OrganizationMigrationStatusDashboardApi.new.get_organization_migration_status_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling OrganizationMigrationStatusDashboardApi->get_organization_migration_status_summary'.red
      puts to_output_hash(e)
    end

    #----------------------------------------------------------------------------
    # System Migration Status
    #  /api/dashboards/system-migration-status-summary
    desc 'system_migration_status_summary', 'Get system migration status summary dashboard information'
    def system_migration_status_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemMigrationStatusDashboardApi.new.get_system_migration_status_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemMigrationStatusDashboardApi->get_system_migration_status_summary'.red
      puts to_output_hash(e)
    end

    #----------------------------------------------------------------------------
    # System FISMA Metrics
    #  /api/dashboards/system-fisma-metrics
    desc 'fisma_metrics', 'Get FISMA metrics dashboard information'
    def fisma_metrics
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemFISMAMetricsDashboardApi.new.get_system_fisma_metrics(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemFISMAMetricsDashboardApi->get_system_fisma_metrics'.red
      puts to_output_hash(e)
    end

    #----------------------------------------------------------------------------
    # Coast Guard System FISMA Metrics
    #	  /api/dashboards/coastguard-system-fisma-metrics
    desc 'coastguard_fisma_metrics', 'Get coastguard FISMA metrics dashboard information'
    def coastguard_fisma_metrics
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::CoastGuardSystemFISMAMetricsDashboardApi.new.get_coast_guard_system_fisma_metrics(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling CoastGuardSystemFISMAMetricsDashboardApi->get_coast_guard_system_fisma_metrics'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Privacy Compliance Dashboard
    # /api/dashboards/system-privacy-summary
    desc 'privacy_summary', 'Get user system privacy summary dashboard information'
    def privacy_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::SystemPrivacyDashboardApi.new.get_system_privacy_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SystemPrivacyDashboardApi->get_system_privacy_summary'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # VA OMB FISMA
    # /api/dashboards/va-omb-fisma-saop-summary
    desc 'fisma_saop_summary', 'Get VA OMB-FISMA SAOP summary dashboard information'
    def fisma_saop_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VAOMBFISMADashboardApi.new.get_va_omb_fsma_saop_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VAOMBFISMADashboardApi->get_va_omb_fsma_saop_summary'.red
      puts to_output_hash(e).yellow
    end

    #----------------------------------------------------------------------------
    # VA Systems Dashboard
    # /api/dashboards/va-system-icamp-tableau-poam-details
    desc 'va_icamp_tableau_poam_details', 'Get VA ICAMP Tableau POA&M details dashboard information'
    def va_icamp_tableau_poam_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VASystemDashboardsApi.new.get_va_system_icamp_tableau_poam_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VASystemDashboardsApi->get_va_system_icamp_tableau_poam_details'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-aa-summary
    desc 'va_aa_summary', 'Get VA system A&A summary dashboard information'
    def va_aa_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VASystemDashboardsApi.new.get_va_system_aa_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VASystemDashboardsApi->get_va_system_aa_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-a2-summary
    desc 'va_a2_summary', 'Get VA system A2.0 summary dashboard information'
    def va_a2_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VASystemDashboardsApi.new.get_va_system_a2_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VASystemDashboardsApi->get_va_system_a2_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-pl-109-reporting-summary
    desc 'va_pl_109_summary', 'Get VA System P.L. 109 reporting summary dashboard information'
    def va_pl_109_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VASystemDashboardsApi.new.get_va_system_pl109_reporting_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VASystemDashboardsApi->get_va_system_pl109_reporting_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-fisma-inventory-summary
    desc 'fisma_inventory_summary', 'Get VA system FISMA inventory summary dashboard information'
    def fisma_inventory_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VASystemDashboardsApi.new.get_va_system_fisma_invetory_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VASystemDashboardsApi->get_va_system_fisma_invetory_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-fisma-inventory-crypto-summary
    desc 'fisma_inventory_crypto_summary', 'Get VA system FISMA inventory crypto summary dashboard information'
    def fisma_inventory_crypto_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VASystemDashboardsApi.new.get_va_system_fisma_invetory_crypto_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VASystemDashboardsApi->get_va_system_fisma_invetory_crypto_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-threat-risks-summary
    desc 'threat_risk_summary', 'Get VA System Threat Risks Summary dashboard information'
    def threat_risk_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VASystemDashboardsApi.new.get_va_system_threat_risk_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VASystemDashboardsApi->get_va_system_threat_risk_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-threat-sources-details
    desc 'threat_risk_details', 'Get VA System Threat Sources Details dashboard information'
    def threat_risk_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VASystemDashboardsApi.new.get_va_system_threat_source_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VASystemDashboardsApi->get_va_system_threat_source_details'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-threat-architecture-details
    desc 'threat_architecture_details', 'Get VA System Threat Architecture Detail dashboard information'
    def threat_architecture_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::VASystemDashboardsApi.new.get_va_system_threat_architecture_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling VASystemDashboardsApi->get_va_system_threat_architecture_details'.red
      puts to_output_hash(e).yellow
    end

    #----------------------------------------------------------------------------
    # CMMC Assessment Dashboards
    # /api/dashboards/cmmc-assessment-status-summary
    desc 'cmmc_status_summary', 'Get CMMC Assessment status summary dashboard information'
    def cmmc_status_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::CMMCAssessmentDashboardsApi.new.get_cmmc_assessment_status_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling CMMCAssessmentDashboardsApi->get_cmmc_assessment_status_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/cmmc-assessment-requirements-compliance-summary
    desc 'cmmc_compliance_summary', 'Get CMMC Assessment Requirements Compliance Summary dashboard information'
    def cmmc_compliance_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::CMMCAssessmentDashboardsApi.new.get_cmmc_assessment_requirements_compliance_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling CMMCAssessmentDashboardsApi->get_cmmc_assessment_requirements_compliance_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/cmmc-assessment-security-requirements-details
    desc 'cmmc_security_requirements_details', 'Get CMMC Assessment Security Requirements Details dashboard information'
    def cmmc_security_requirements_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::CMMCAssessmentDashboardsApi.new.get_cmmc_assessment_security_requirements_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling CMMCAssessmentDashboardsApi->get_cmmc_assessment_security_requirements_details'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/cmmc-assessment-requirement-objectives-details
    desc 'cmmc_requirement_objectives_details', 'Get CMMC Assessment Requirement Objectives Details dashboard information'
    def cmmc_requirement_objectives_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::CMMCAssessmentDashboardsApi.new.get_cmmc_assessment_requirement_objectives_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling CMMCAssessmentDashboardsApi->get_cmmc_assessment_requirement_objectives_details'.red
      puts to_output_hash(e).yellow
    end
  end

  class Get < SubCommandBase
    desc 'test', 'Test connection to the configured eMASS server'
    subcommand 'test', Test

    desc 'system', 'Get a system ID given name/owner, or get a system by ID'
    subcommand 'system', System

    desc 'systems', 'Get all systems'
    subcommand 'systems', Systems

    desc 'roles', 'Get all system roles or by category Id'
    subcommand 'roles', Roles

    desc 'controls', 'Get system Controls'
    subcommand 'controls', Controls

    desc 'test_results', 'Get system Test Results'
    subcommand 'test_results', TestResults

    desc 'poams', 'Get system Poams'
    subcommand 'poams', Poams

    desc 'milestones', 'Get system Milestones'
    subcommand 'milestones', Milestones

    desc 'artifacts', 'Get system Artifacts'
    subcommand 'artifacts', Artifacts

    desc 'cac', 'Get location of one or many controls in CAC'
    subcommand 'cac', CAC

    desc 'pac', 'Get status of active workflows in a system'
    subcommand 'pac', PAC

    desc 'hardware', 'Get one or many hardware assets in a system'
    subcommand 'hardware', Hardware

    desc 'software', 'Get one or many software assets in a system'
    subcommand 'software', Software

    desc 'workflow_definitions', 'Get workflow definitions in a site'
    subcommand 'workflow_definitions', WorkflowDefinitions

    desc 'workflow_instances', 'Get workflow instance by system and/or ID in a system'
    subcommand 'workflow_instances', WorkflowInstances

    desc 'cmmc', 'Get CMMC assessment information'
    subcommand 'cmmc', CMMC

    desc 'dashboards', 'Get dashboard information'
    subcommand 'dashboards', Dashboards
  end
end
# rubocop:enable Naming/MethodName
