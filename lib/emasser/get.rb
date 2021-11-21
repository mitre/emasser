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
      "exe/#{basename} #{command.formatted_usage(self, $thor_runner, subcommand)}"
    else
      "exe/#{basename} get #{command.formatted_usage(self, $thor_runner, subcommand)}"
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
  #    /api - Test connection to the API
  class Test < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'connection', 'Test connection to the API'

    def connection
      result = SwaggerClient::TestApi.new.test_connection
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling TestApi->test_connection'.red
      puts to_output_hash(e)
    end
  end

  # The System Roles endpoints provide the ability to access user data assigned to systems.
  # Notes:
  # * If a system is dual-policy enabled, the returned system role information default to
  #   the RMF policy information unless otherwise specified.
  #
  # Endpoint:
  #    /api/system-roles                - Get all available roles
  #    /api/system-roles/{roleCategory} - Get system roles for provided role catgory
  class Roles < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'all', 'Retrieves all available system roles'

    def all
      result = SwaggerClient::SystemRolesApi.new.get_system_roles
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling SystemRolesApi->get_system_roles'.red
      puts to_output_hash(e)
    end

    desc "byCategory \[options\]", 'Retrieves system(s) - filtered by [options] params'
    option :roleCategory, type: :string, required: true,  enum: %w[PAC CAC Other]
    option :role,         type: :string, required: true,
                          enum: ['AO', 'Auditor', 'Artifact Manager', 'C&A Team', 'IAO',
                                 'ISSO', 'PM/IAM', 'SCA', 'User Rep (View Only)', 'Validator (IV&V)']
    option :policy,       type: :string, required: false, enum: %w[diacap rmf reporting]

    def byCategory
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = SwaggerClient::SystemRolesApi.new.get_system_by_role_category_id(options[:roleCategory],
                                                                                  options[:role], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling SystemRolesApi->get_system_by_role_category_id'.red
        puts to_output_hash(e)
      end
    end
  end

  # The GET Control endpoint provides the ability to retrieve Security Control information from a
  # system for both the Implementation Plan and Risk Assessment.
  #
  # Endpoint:
  #    /api/systems/{systemId}/controls - Get control information in a system for one or many controls
  class Controls < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'system', 'Get control information in a system for one or many controls (acronym)'
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :acronyms, type: :string,  required: false,
                      desc: 'The system acronym(s) e.g "AC-1, AC-2" - if not provided all controls for systemId are' \
                            ' returned'

    def system
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = SwaggerClient::ControlsApi.new.get_system_by_system_id(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ControlsApi->get_system_by_system_id'.red
        puts to_output_hash(e)
      end
    end
  end

  # The Test Result endpoints provide the ability to add test results for a system's DoD
  # Assessment Procedures (CCIs) which determines NIST SP 80-53 Revision 4 Security
  # Control Compliance (Compliant, Non-Compliant, Not Applicable). The endpoints also
  # provide the ability to retrieve test results.
  #
  # Endpoint:
  #    /api/systems/{systemId}/test-results - Get one or many test results in a system
  class TestResults < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'system', 'Get one or many test results in a system'
    option :systemId,        type: :numeric, required: true,
                             desc: 'A numeric value representing the system identification'
    option :controlAcronyms, type: :string,  required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :cci,             type: :string,  required: false, desc: 'The system CCIS string numerical value'
    option :latestOnly,      type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def system
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = SwaggerClient::TestResultsApi.new.get_test_results_by_system_id(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling TestResultsApi->get_test_results_by_system_id'.red
        puts to_output_hash(e)
      end
    end
  end

  # These endpoints provide the ability to add Plan of Action and Milestones (POA&M)
  # items to a system. The endpoint also provides the ability to view, update and/or remove
  # existing POA&M items and associated milestones in a system
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams                     - Get one or many poa&m items in a system
  #   /api/systems/{systemId}/poams/{poamId}            - Get poa&m item by id in a system
  #   /api/systems/{systemId}/poams/{poamId}/milestones - Get milestones in one or many poa&m items in a system
  #   /api/systems/{systemId}/poams/{poamId}/milestones/{milestoneId} - Get milestone by id in poa&m item in a system
  class Poams < SubCommandBase
    def self.exit_on_failure?
      true
    end

    # SYSTEM ------------------------------------------------------------------
    desc 'system', 'Get one or many POA&M items in a system'
    option :systemId,                     type: :numeric,  required: true,
                                          desc: 'A numeric value representing the system identification'
    option :scheduledCompletionDateStart, type: :numeric,  required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd,   type: :numeric,  required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'
    option :controlAcronyms, type: :string,  required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :ccis,            type: :string,  required: false, desc: 'The system CCIS string numerical value'
    option :systemOnly,      type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def system
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = SwaggerClient::POAMApi.new.api_systems_system_id_poams_get(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling POAMApi->api_systems_system_id_poams_get'.red
        puts to_output_hash(e)
      end
    end

    # BY POAM ID --------------------------------------------------------------
    desc 'byPoamId', 'Get system Poams for given systemId and poamId'
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :poamId,   type: :numeric, required: true,
                      desc: 'A numeric value representing the poam identification'

    def byPoamId
      result = SwaggerClient::POAMApi.new.get_poam_by_system_id_and_poam_id(options[:systemId], options[:poamId])
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling POAMApi->get_poam_by_system_id_and_poam_id'.red
      puts to_output_hash(e)
    end

    # MILSTONES by SYSTEM and POAM ID -----------------------------------------
    desc 'milestones', 'Get milestone(s) for given specified system and poam'
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :poamId,   type: :numeric, required: true,
                      desc: 'A numeric value representing the poam identification'
    option :scheduledCompletionDateStart, type: :numeric,  required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd,   type: :numeric,  required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'

    def milestones
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get milestones in one or many poa&m items in a system
        result = SwaggerClient::POAMApi.new.get_milestones_by_system_id_and_poam_id(options[:systemId],
                                                                                    options[:poamId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling POAMApi->get_milestones_by_system_id_and_poam_id'.red
        puts to_output_hash(e)
      end
    end

    # MILSTONES by SYSTEM, POAM, and MILESTONE ID -----------------------------------------
    desc 'byMilestoneId', 'Get milestone(s) for given specified system, poam, and milestone Id'
    option :systemId,    type: :numeric, required: true,
                         desc: 'A numeric value representing the system identification'
    option :poamId,      type: :numeric, required: true,
                         desc: 'A numeric value representing the poam identification'
    option :milestoneId, type: :numeric, required: true,
                         desc: 'A numeric value representing the milestone identification'

    def byMilestoneId
      result = SwaggerClient::POAMApi.new.get_milestones_by_system_id_and_poam_id_andf_milestone_id(
        options[:systemId], options[:poamId], options[:milestoneId]
      )
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling POAMApi->get_milestones_by_system_id_and_poam_id_andf_milestone_id'.red
      puts to_output_hash(e)
    end
  end

  # The Artifact endpoints provide the ability to add new Artifacts
  # (supporting documentation/evidence for Security Control Assessments
  # and system Authorization activities) to a system.
  #
  # Endpoints:
  #    /api/systems/{systemId}/artifacts - Get one or many artifacts in a system
  #    /api/systems/{systemId}/artifacts-export - Get the file of an artifact in a system
  class Artifacts < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'system', 'Get all system artifacts for a system Id'
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :filename, type: :string,  required: false, desc: 'The artifact file name'
    option :controlAcronyms, type: :string,  required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :ccis,            type: :string,  required: false, desc: 'The system CCIS string numerical value'
    option :systemOnly,      type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def system
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get one or many artifacts in a system
        result = SwaggerClient::ArtifactsApi.new.api_systems_system_id_artifacts_get(options[:systemId],
                                                                                     optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ArtifactsApi->api_systems_system_id_artifacts_get'.red
        puts to_output_hash(e)
      end
    end

    desc 'export', 'Get artifact binary file associated with given filename'
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :filename, type: :string,  required: true, desc: 'The artifact file name'
    option :compress, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    # NOTE: compress is a required parameter, however Thor does not allow a boolean type to be required because it
    # automatically creates a --no-compress option, which is confusing in the help output:
    #     [--compress], [--no-compress]  # BOOLEAN - true or false.

    def export
      # Get the file of an artifact in a system
      result = SwaggerClient::ArtifactsApi.new.api_systems_system_id_artifacts_export_get(
        options[:systemId], options[:filename], options[:compress], Emasser::GET_ARTIFACTS_RETURN_TYPE
      )
      if options[:compress]
        p result
      else
        begin
          puts JSON.pretty_generate(JSON.parse(result)).green
        rescue StandardError
          puts result.green
        end
      end
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling ArtifactsApi->api_systems_system_id_artifacts_export_get'.red
      puts to_output_hash(e)
    end
  end

  # The Approval Chain endpoints provide the ability to view Security Controls' locations in
  # the Control Approval Chain (CAC) in a system and submit them to the 2nd role of the CAC
  # for independent verification and validation. These endpoints also provide the ability to
  # view the location of a system's package in the Package Approval Chain (PAC) and submit
  # a new package for assessment and authorization.
  #
  # Endpoints:
  #    /api/systems/{systemId}/approval/cac - Get location of one or many controls in CAC
  #    /api/systems/{systemId}/approval/pac - Get location of system package in PAC
  class Approval < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'cac', 'Get all system CAC for a system Id'
    option :systemId,        type: :numeric, required: true,
                             desc: 'A numeric value representing the system identification'
    option :controlAcronyms, type: :string,  required: false,
                             desc: 'The system acronym(s) e.g "AC-1, AC-2" - if not provided all CACs for systemId' \
                                   ' are returned'

    def cac
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get location of one or many controls in CAC
        result = SwaggerClient::ApprovalChainApi.new.get_cac_approval_by_system_id(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ApprovalChainApi->get_cac_approval_by_system_id'.red
        puts to_output_hash(e)
      end
    end

    desc 'pac', 'Get all system PAC for a system Id'
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'

    def pac
      # Get location of system package in PAC
      result = SwaggerClient::ApprovalChainApi.new.get_pac_approval_by_system_id(
        options[:systemId], Emasser::GET_SYSTEM_RETURN_TYPE
      )
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_pac_approval_by_system_id'.red
      puts to_output_hash(e)
    end
  end

  class Get < SubCommandBase
    desc 'test', 'Test connection to the configured eMASS server'
    subcommand 'test', Test

    desc 'roles', 'Get all system roles or by category Id'
    subcommand 'roles', Roles

    desc 'controls', 'Get system Controls'
    subcommand 'controls', Controls

    desc 'test_results', 'Get system Test Results'
    subcommand 'test_results', TestResults

    desc 'poams', 'Get system Poams'
    subcommand 'poams', Poams

    desc 'artifacts', 'Get system Artifacts'
    subcommand 'artifacts', Artifacts

    desc 'approval', 'Get Contorls or Packages (CAC/PAC) security content'
    subcommand 'approval', Approval

    desc 'system [--system-name [SYSTEM_NAME]] [--system-owner [SYSTEM_OWNER]]',
         'Attempts to provide system ID of a system with name [NAME] and owner [SYSTEM_OWNER]'

    option :system_name
    option :system_owner

    def system
      if options[:system_name].nil? && options[:system_owner].nil?
        raise ArgumentError,
              'SYSTEM_NAME or SYSTEM_OWNER is required'
      end

      begin
        results = SwaggerClient::SystemsApi.new.get_systems(Emasser::GET_SYSTEM_ID_QUERY_PARAMS).data
        results = filter_systems(results, options[:system_name], options[:system_owner])
        results.each { |result| puts "#{result[:systemId]} - #{result[:systemOwner]} - #{result[:name]}" }
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling SystemsApi->get_systems'
        puts to_output_hash(e)
      end
    end

    no_commands do
      def filter_systems(results, system_name = nil, system_owner = nil)
        if system_owner.nil?
          results.filter { |result| result[:name].eql?(system_name) }
        elsif system_name.nil?
          results.filter { |result| result[:systemOwner].eql?(system_owner) }
        else
          results.filter { |result| result[:name].eql?(system_name) && result[:systemOwner].eql?(system_owner) }
        end
      end
    end

    desc "systems \[options\]", 'Retrieves all available system(s) - filtered by [options] params'

    option :includePackage,       type: :boolean, required: false, desc: 'BOOLEAN - true or false.'
    option :registrationType,     type: :string,  required: false,
                                  enum: %w[assessAndAuthorize assessOnly guest regular functional cloudServiceProvider]
    option :ditprId,              type: :string,  required: false,
                                  desc: 'DoD Information Technology (IT) Portfolio Repository (DITPR) string Id'
    option :coamsId,              type: :string,  required: false,
                                  desc: 'Cyber Operational Attributes Management System (COAMS) string Id'
    option :policy,               type: :string,  required: false, enum: %w[diacap rmf reporting]
    option :includeDitprMetrics,  type: :boolean, required: false, desc: 'BOOLEAN - true or false.'
    option :includeDecommissioned, type: :boolean, required: false, desc: 'BOOLEAN - true or false.'

    def systems
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)
      optional_options.merge!(Emasser::GET_SYSTEM_RETURN_TYPE)

      begin
        # Get system information matching provided parameters
        result = SwaggerClient::SystemsApi.new.get_systems(optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling SystemsApi->get_systems'.red
        puts to_output_hash(e)
      end
    end
  end
end
# rubocop:enable Naming/MethodName
