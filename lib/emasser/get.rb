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
  #    /api - Test connection to the API
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
      puts to_output_hash(e).yellow
    end
  end

  # The Systems endpoints provide the ability to view system information.
  #
  # Endpoint:
  #    /api/systems            - Get system information
  #    /api/systems/{systemId} - Get system information for a specific system
  class System < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'id [--system_name [SYSTEM_NAME]] [--system_owner [SYSTEM_OWNER]]',
         'Attempts to provide system ID of a system with name [NAME] and owner [SYSTEM_OWNER]'

    # Required parameters/fields
    option :system_name
    option :system_owner

    def id
      if options[:system_name].nil? && options[:system_owner].nil?
        raise ArgumentError,
              'SYSTEM_NAME or SYSTEM_OWNER is required'
      end

      begin
        results = EmassClient::SystemsApi.new.get_systems
        results = filter_systems(results, options[:system_name], options[:system_owner])
        results.each { |result| puts "#{result[:systemId]} - #{result[:systemOwner]} - #{result[:name]}" }
      rescue EmassClient::ApiError => e
        puts 'Exception when calling SystemsApi->get_systems'
        puts to_output_hash(e).yellow
      end
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    no_commands do
      def filter_systems(results, system_name = nil, system_owner = nil)
        results = results.to_body if results.respond_to?(:to_body)
        if system_owner.nil?
          results[:data].filter { |result| result[:name].eql?(system_name) }
        elsif system_name.nil?
          results[:data].filter { |result| result[:systemOwner].eql?(system_owner) }
        else
          results[:data].filter { |result| result[:name].eql?(system_name) && result[:systemOwner].eql?(system_owner) }
        end
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    desc 'byId [options]', 'Retrieve a system - filtered by [options] params'
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :includePackage, type: :boolean, required: false, desc: 'BOOLEAN - true or false.'
    option :policy,         type: :string,  required: false, enum: %w[diacap rmf reporting]

    def byId
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)
      # optional_options.merge!(Emasser::GET_SYSTEM_RETURN_TYPE)

      begin
        # Get system information matching provided parameters
        result = EmassClient::SystemsApi.new.get_system(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling SystemsApi->get_system'.red
        puts to_output_hash(e).yellow
      end
    end
  end

  class Systems < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'all [options]', 'Retrieves all available system(s) - filtered by [options] params'
    # Optional parameters/fields
    option :registrationType,
           type: :string, required: false,
           enum: %w[assessAndAuthorize assessOnly guest regular functional cloudServiceProvider commonControlProvider]
    option :ditprId, type: :string,  required: false,
                     desc: 'DoD Information Technology (IT) Portfolio Repository (DITPR) string Id'
    option :coamsId, type: :string,  required: false,
                     desc: 'Cyber Operational Attributes Management System (COAMS) string Id'
    option :policy, type: :string, required: false, enum: %w[diacap rmf reporting]

    option :includePackage, type: :boolean, required: false, desc: 'BOOLEAN - true or false.'
    option :includeDitprMetrics, type: :boolean, required: false, desc: 'BOOLEAN - true or false.'
    option :includeDecommissioned, type: :boolean, required: false, desc: 'BOOLEAN - true or false.'
    option :reportsForScorecard, type: :boolean, required: false, desc: 'BOOLEAN - true or false.'

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
        puts to_output_hash(e).yellow
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
  #    /api/system-roles/{roleCategory} - Get system roles for provided role catgory
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
      puts to_output_hash(e).yellow
    end

    desc 'byCategory [options]', 'Retrieves role(s) - filtered by [options] params'
    # Required parameters/fields
    option :roleCategory, type: :string, required: true, enum: %w[PAC CAC Other]
    option :role,         type: :string, required: true,
                          enum: ['AO', 'Auditor', 'Artifact Manager', 'C&A Team', 'IAO',
                                 'ISSO', 'PM/IAM', 'SCA', 'User Rep', 'Validator']
    # Optional parameters/fields
    option :policy, type: :string, required: false, default: 'rmf', enum: %w[diacap rmf reporting]
    option :includeDecommissioned, type: :boolean, required: false, desc: 'BOOLEAN - true or false.'

    def byCategory
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = EmassClient::SystemRolesApi.new.get_system_roles_by_category_id(options[:roleCategory],
                                                                                 options[:role], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling SystemRolesApi->get_system_by_role_category_id'.red
        puts to_output_hash(e).yellow
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
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :acronyms, type: :string,  required: false,
           desc: 'The system acronym(s) e.g "AC-1, AC-2" - if not provided all controls for systemId are returned'

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = EmassClient::ControlsApi.new.get_system_controls(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ControlsApi->get_system_controls'.red
        puts to_output_hash(e).yellow
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
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :controlAcronyms, type: :string,  required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :ccis,            type: :string,  required: false, desc: 'The system CCIS string numerical value'
    option :latestOnly,      type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = EmassClient::TestResultsApi.new.get_system_test_results(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling TestResultsApi->get_system_test_results'.red
        puts to_output_hash(e).yellow
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
    option :systemId, type: :numeric,  required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :scheduledCompletionDateStart, type: :numeric,  required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd,   type: :numeric,  required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'
    option :controlAcronyms, type: :string,  required: false, desc: 'The system acronym(s) e.g "AC-1" or "AC-1, AC-2"'
    option :ccis,            type: :string,  required: false, desc: 'The system CCIS string numerical value e.g "000123" or "000123,000069"'
    option :systemOnly,      type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = EmassClient::POAMApi.new.get_system_poams(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling POAMApi->get_system_poams'.red
        puts to_output_hash(e).yellow
      end
    end

    # BY POAM ID --------------------------------------------------------------
    desc 'byPoamId', 'Get POA&M item for given systemId and poamId'
    # Required parameters/fields
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :poamId,   type: :numeric, required: true,
                      desc: 'A numeric value representing the poam identification'

    def byPoamId
      result = EmassClient::POAMApi.new.get_system_poams_by_poam_id(options[:systemId], options[:poamId])
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling POAMApi->get_system_poams_by_poam_id'.red
      puts to_output_hash(e).yellow
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
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :poamId,   type: :numeric, required: true,
                      desc: 'A numeric value representing the poam identification'
    # Optional parameters/fields
    option :scheduledCompletionDateStart, type: :numeric,  required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd,   type: :numeric,  required: false,
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
        puts to_output_hash(e).yellow
      end
    end

    # MILSTONES by SYSTEM, POAM, and MILESTONE ID -----------------------------------------
    desc 'byMilestoneId', 'Get milestone(s) for given specified system, poam, and milestone Id'
    # Required parameters/fields
    option :systemId,    type: :numeric, required: true,
                         desc: 'A numeric value representing the system identification'
    option :poamId,      type: :numeric, required: true,
                         desc: 'A numeric value representing the poam identification'
    option :milestoneId, type: :numeric, required: true,
                         desc: 'A numeric value representing the milestone identification'

    def byMilestoneId
      result = EmassClient::MilestonesApi.new.get_system_milestones_by_poam_id_and_milestone_id(
        options[:systemId], options[:poamId], options[:milestoneId]
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling MilestonesApi->get_system_milestones_by_poam_id_and_milestone_id'.red
      puts to_output_hash(e).yellow
    end
  end

  # The Artifact endpoints provide the ability to add new Artifacts
  # (supporting documentation/evidence for Security Control Assessments
  # and system Authorization activities) to a system.
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
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :filename, type: :string,  required: false, desc: 'The artifact file name'
    option :controlAcronyms, type: :string,  required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :ccis,            type: :string,  required: false, desc: 'The system CCIS string numerical value'
    option :systemOnly,      type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

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
        puts to_output_hash(e).yellow
      end
    end

    desc 'export', 'Get artifact binary file associated with given filename'
    # Required parameters/fields
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :filename, type: :string,  required: true, desc: 'The artifact file name'
    option :compress, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    # NOTE: compress is a required parameter, however Thor does not allow a boolean type to be required because it
    # automatically creates a --no-compress option, which is confusing in the help output:
    #     [--compress], [--no-compress]  # BOOLEAN - true or false.

    def export
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)
      optional_options.merge!(Emasser::GET_ARTIFACTS_RETURN_TYPE)

      result = EmassClient::ArtifactsExportApi.new.get_system_artifacts_export(
        options[:systemId], options[:filename], optional_options
      )
      if options[:compress]
        pp result
      else
        begin
          puts JSON.pretty_generate(JSON.parse(result)).green
        rescue StandardError
          puts result.red
        end
      end
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ArtifactsApi->get_system_artifacts_export'.red
      puts to_output_hash(e).yellow
    end
  end

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
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :controlAcronyms, type: :string,  required: false,
           desc: 'The system acronym(s) e.g "AC-1, AC-2" - if not provided all CACs for systemId are returned'

    def controls
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get location of one or many controls in CAC
        result = EmassClient::CACApi.new.get_system_cac(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ApprovalChainApi->get_system_cac'.red
        puts to_output_hash(e).yellow
      end
    end
  end

  # The Package Approval Chain (PAC) endpoints provide the ability to view the
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
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'

    def package
      # Get location of system package in PAC
      result = EmassClient::PACApi.new.get_system_pac(options[:systemId])
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_system_'.red
      puts to_output_hash(e).yellow
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
    option :sinceDate, type: :string, required: true, desc: 'The CMMC date. Unix date format'

    def assessments
      result = EmassClient::CMMCAssessmentsApi.new.get_cmmc_assessments(options[:sinceDate])
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_cmmc_assessments'.red
      puts to_output_hash(e).yellow
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
    option :includeInactive, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    option :registrationType,
           type: :string, required: false,
           enum: %w[assessAndAuthorize assessOnly guest regular functional cloudServiceProvider commonControlProvider]

    def forSite
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::WorkflowDefinitionsApi.new.get_workflow_definitions(optional_options)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_workflow_definitions'.red
      puts to_output_hash(e).yellow
    end
  end

  # The Workflow Instances endpoint provides the ability to view detailed information on all
  # active and historical workflows for a system.
  #
  # Endpoints:
  #    /api/workflows/instances                      - Get workflow instances in a site
  #    /api/workflows/instances/{workflowInstanceId} - Get workflow instance by ID
  class WorkflowInstances < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'all', 'Get workflow instances in a site'

    # Optional parameters/fields
    option :includeComments, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    option :pageIndex, type: :numeric, required: false, desc: 'The page number to be returned'
    option :sinceDate, type: :string, required: false, desc: 'The workflow instance date. Unix date format'
    option :status, type: :string, required: false, enum: %w[active inactive all]

    def all
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::WorkflowInstancesApi.new.get_system_workflow_instances(optional_options)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_system_workflow_instances'.red
      puts to_output_hash(e).yellow
    end

    # Workflow by workflowInstanceId ---------------------------------------------------------
    desc 'byInstanceId', 'Get workflow instance by ID'

    # Required parameters/fields
    option :workflowInstanceId, type: :numeric, required: true,
                                desc: 'A numeric value representing the workflowInstance identification'

    def byInstanceId
      opts = Emasser::GET_WORKFLOWINSTANCES_RETURN_TYPE
      result = EmassClient::WorkflowInstancesApi.new
                                                .get_system_workflow_instances_by_workflow_instance_id(options[:workflowInstanceId], opts)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_system_workflow_instances_by_workflow_instance_id'.red
      puts to_output_hash(e).yellow
    end
  end

  # The Dashboards endpoints provide the ability to view data contained in dashboard exports.
  # In the eMASS front end, these dashboard exports are generated as Excel exports.
  # Each dashboard dataset available from the API is automatically updated with the current
  # configuration of the dashboard and the instance of eMASS as the dashboard changes.
  #
  # Endpoints:
  #  /api/dashboards/system-status-details                    - Get systems status detail dashboard information
  #  /api/dashboards/system-control-compliance-summary        - Get systems control compliance summary dashboard information
  #  /api/dashboards/system-security-controls-details         - Get systems security control details dashboard information
  #  /api/dashboards/system-assessment-procedures-details     - Get systems assessement procdures details dashboard information
  #  /api/dashboards/system-poam-summary                      - Get systems POA&Ms summary dashboard information
  #  /api/dashboards/system-poam-details                      - Get system POA&Ms details dashboard information
  #  /api/dashboards/system-artifacts-summary                 - Get system Artifacts summary information.
  #  /api/dashboards/system-artifacts-details                 - Get system Artifacts details information.
  #  /api/dashboards/system-hardware-summary                  - Get system hardware summary dashboard information
  #  /api/dashboards/system-hardware-details                  - Get system hardware details dashboard information
  #  /api/dashboards/system-sensor-hardware-summary           - Get system sensor hardware summary dashboard information
  #  /api/dashboards/system-sensor-hardware-details           - Get system sensor hardware details dashboard information
  #  /api/dashboards/system-software-summary                  - Get system software summary dashboard information
  #  /api/dashboards/system-software-details                  - Get system ssoftware details dashboard information
  #  /api/dashboards/system-ports-protocols-summary           - Get system ports and protocols summary dashboard information
  #  /api/dashboards/system-ports-protocols-details           - Get system ports and protocols details dashboard information
  #  /api/dashboards/system-conmon-integration-status-summary - Get system conmon integration status summary dashboard information
  #  /api/dashboards/system-associations-details              - Get system associations details dashboard information
  #  /api/dashboards/user-system-assignments-details          - Get user system assignments details dashboard information
  #  /api/dashboards/system-privacy-summary                   - Get user system privacy summary dashboard information
  #  /api/dashboards/va-omb-fisma-saop-summary                - Get VA OMB-FISMA SAOP summary dashboard information
  #  /api/dashboards/va-system-aa-summary                     - Get VA system A&A summary dashboard information
  #  /api/dashboards/va-system-a2-summary                     - Get VA system A2.0 summary dashboard information
  #  /api/dashboards/va-system-pl-109-reporting-summary       - Get workflow instance by ID in a system
  #  /api/dashboards/va-system-fisma-inventory-summary        - Get VA system FISMA inventory summary dashboard information
  #  /api/dashboards/va-system-fisma-inventory-crypto-summary - Get VA system FISMA inventory crypto summary dashboard information
  #  /api/dashboards/va-system-threat-risks-summary           - Get VA System Threat Risks Summary dashboard information
  #  /api/dashboards/va-system-threat-sources-details         - Get VA System Threat Sources Details dashboard information
  #  /api/dashboards/va-system-threat-architecture-details    - Get VA System Threat Architecture Details dashboard information

  class Dashboards < SubCommandBase
    def self.exit_on_failure?
      true
    end

    # Required parameters/fields
    class_option :orgId, aliases: '-o', type: :numeric,
                 desc: 'A numeric value representing the system identification'

    # Optional parameters/fields
    class_option :excludeinherited, aliases: '-I', type: :boolean, required: false, default: false,
                 desc: 'BOOLEAN - true or false, default false.'
    class_option :pageIndex, aliases: '-i', type: :numeric, required: false,
                 desc: 'The page number to be returned, if not specified starts at page 0'
    class_option :pageSize, aliases: '-s', type: :numeric, required: false,
                 desc: 'The total entries per page, default is 20,000'

    #--------------------------------------------------------------------------
    # System Status Dashboard
    # /api/dashboards/system-status-details
    desc 'status_details', 'Get systems status detail dashboard information'
    def status_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_status_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_status_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Enterprise Security Controls Dashboard
    # /api/dashboards/system-control-compliance-summary
    desc 'control_compliance_summary', 'Get systems control compliance summary dashboard information'
    def control_compliance_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_control_compliance_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_control_compliance_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-security-controls-details
    desc 'security_control_details', 'Get systems security control details dashboard information'
    def security_control_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_security_control_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_security_control_details'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-assessment-procedures-details
    desc 'assessment_procedures_details', 'Get systems assessement procdures details dashboard information'
    def assessment_procedures_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_assessment_procedures_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_assessment_procedures_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Enterprise POA&M Dashboard
    # /api/dashboards/system-poam-summary
    desc 'poam_summary', 'Get systems POA&Ms summary dashboard information'
    def poam_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_poam_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_poam_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-poam-details
    desc 'poam_details', 'Get system POA&Ms details dashboard information'
    def poam_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_poam_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_poam_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Enterprise Artifacts Dashboard
    # /api/dashboards/system-artifacts-summary
    desc 'artifacts_summary', 'Get systems artifacts summary dashboard information'
    def artifacts_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_artifacts_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_artifacts_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-artifacts-details
    desc 'artifacts_details', 'Get systems artifacts summary dashboard information'
    def artifacts_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_artifacts_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_artifacts_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Hardware Baseline Dashboard
    # /api/dashboards/system-hardware-summary
    desc 'hardware_summary', 'Get system hardware summary dashboard information'
    def hardware_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_hardware_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_hardware_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-hardware-details
    desc 'hardware_details', 'Get system hardware details dashboard information'
    def hardware_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_hardware_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_hardware_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Enterprise Sensor-based Hardware Resources Dashboard
    # /api/dashboards/system-sensor-hardware-summary
    desc 'sensor_hardware_summary', 'Get system sensor hardware summary dashboard information'
    def sensor_hardware_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_sensor_hardware_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_sensor_hardware_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-sensor-hardware-details
    desc 'sensor_hardware_details', 'Get system sensor hardware details dashboard information'
    def sensor_hardware_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_sensor_hardware_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_sensor_hardware_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Software Baseline Dashboards
    # /api/dashboards/system-software-summary
    desc 'software_summary', 'Get system software summary dashboard information'
    def software_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_software_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_software_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-software-details
    desc 'software_details', 'Get system software details dashboard information'
    def software_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_software_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_software_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Ports and Protocols Dashboard
    # /api/dashboards/system-ports-protocols-summary
    desc 'ports_protocols_summary', 'Get system ports & portocols summary dashboard information'
    def ports_protocols_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_ports_protocols_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_ports_protocols_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/system-ports-protocols-details
    desc 'ports_protocols_details', 'Get system ports & portocols details dashboard information'
    def ports_protocols_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_ports_protocols_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_ports_protocols_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System CONMON Integration Status Dashboard
    # /api/dashboards/system-conmon-integration-status-summary
    desc 'common_integration_status_summary', 'Get system conmon integration status summary dashboard information'
    def common_integration_status_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_common_integration_status_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_common_integration_status_summary'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # System Associations Dashboard
    # /api/dashboards/system-associations-details
    desc 'associations_details', 'Get system associations details dashboard information'
    def associations_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_associations_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_associations_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Users Dashboard
    # /api/dashboards/user-system-assignments-details
    desc 'assignments_details', 'Get user system assignments details dashboard information'
    def assignments_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_user_system_assignments_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_user_system_assignments_details'.red
      puts to_output_hash(e)
    end

    #--------------------------------------------------------------------------
    # Privacy Compliance Dashboard
    # /api/dashboards/system-privacy-summary
    desc 'privacy_summary', 'Get user system privacy summary dashboard information'
    def privacy_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_system_privacy_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_system_privacy_summary'.red
      puts to_output_hash(e)
    end

    # /api/dashboards/va-omb-fisma-saop-summary
    desc 'fisma_saop_summary', 'Get VA OMB-FISMA SAOP summary dashboard information'
    def fisma_saop_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_va_omb_fsma_saop_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_va_omb_fsma_saop_summary'.red
      puts to_output_hash(e).yellow
    end

    #--------------------------------------------------------------------------
    # System A&A Summary Dashboard
    # /api/dashboards/va-system-aa-summary
    desc 'va_aa_summary', 'Get VA system A&A summary dashboard information'
    def va_aa_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_va_system_aa_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_va_system_aa_summary'.red
      puts to_output_hash(e).yellow
    end

    #--------------------------------------------------------------------------
    # System A2.0 Summary Dashboard
    # /api/dashboards/va-system-a2-summary
    desc 'va_a2_summary', 'Get VA system A2.0 summary dashboard information'
    def va_a2_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_va_system_a2_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_va_system_a2_summary'.red
      puts to_output_hash(e).yellow
    end

    #--------------------------------------------------------------------------
    # System P.L. 109 Reporting Summary Dashboard
    # /api/dashboards/va-system-pl-109-reporting-summary
    desc 'va_pl_109_summary', 'Get VA System P.L. 109 reporting summary dashboard information'
    def va_pl_109_summary
      optional_options = options.clone
      optional_options.delete('orgId')

      result = EmassClient::DashboardsApi.new.get_va_system_pl109_reporting_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_va_system_pl109_reporting_summary'.red
      puts to_output_hash(e).yellow
    end

    #--------------------------------------------------------------------------
    # FISMA Inventory Summary Dashboard
    # /api/dashboards/va-system-fisma-inventory-summary
    desc 'fisma_inventory_summary', 'Get VA system FISMA inventory summary dashboard information'
    def fisma_inventory_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_va_system_fisma_invetory_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_va_system_fisma_invetory_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-fisma-inventory-crypto-summary
    desc 'fisma_inventory_crypto_summary', 'Get VA system FISMA inventory crypto summary dashboard information'
    def fisma_inventory_crypto_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_va_system_fisma_invetory_crypto_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_va_system_fisma_invetory_crypto_summary'.red
      puts to_output_hash(e).yellow
    end

    #--------------------------------------------------------------------------
    # Threat Risks Dashboard
    # /api/dashboards/va-system-threat-risks-summary
    desc 'threat_risk_summary', 'Get VA System Threat Risks Summary dashboard information'
    def threat_risk_summary
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_va_system_threat_risk_summary(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_va_system_threat_risk_summary'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-threat-sources-details
    desc 'threat_risk_details', 'Get VA System Threat Sources Details dashboard information'
    def threat_risk_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_va_system_threat_source_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_va_system_threat_source_details'.red
      puts to_output_hash(e).yellow
    end

    # /api/dashboards/va-system-threat-architecture-details
    desc 'threat_architecture_details', 'Get VA System Threat Architecture Detail dashboard information'
    def threat_architecture_details
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = EmassClient::DashboardsApi.new.get_va_system_threat_architecture_details(
        options[:orgId], optional_options
      )
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling DashboardsApi->get_va_system_threat_architecture_details'.red
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

    desc 'cmmc', 'Get CMMC assessment information'
    subcommand 'cmmc', CMMC

    desc 'workflow_definitions', 'Get workflow definitions in a site'
    subcommand 'workflow_definitions', WorkflowDefinitions

    desc 'workflow_instances', 'Get workflow instance by system and/or ID in a system'
    subcommand 'workflow_instances', WorkflowInstances

    desc 'dashboards', 'Get dashboard information'
    subcommand 'dashboards', Dashboards
  end
end
# rubocop:enable Naming/MethodName
