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

  # The Systems endpoints provide the ability to view system information.
  #
  # Endpoint:
  #    /api/systems            - Get system information
  #    /api/systems/{systemId} - Get system information for a specific system
  class System < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'id [--system-name [SYSTEM_NAME]] [--system-owner [SYSTEM_OWNER]]',
         'Attempts to provide system ID of a system with name [NAME] and owner [SYSTEM_OWNER]'
    # desc 'id', 'Get a system ID given "name" or "owner"'

    # Required parameters/fields
    option :system_name
    option :system_owner

    def id
      if options[:system_name].nil? && options[:system_owner].nil?
        raise ArgumentError,
              'SYSTEM_NAME or SYSTEM_OWNER is required'
      end

      begin
        results = SwaggerClient::SystemsApi.new.get_systems.data
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

    desc "byId \[options\]", 'Retrieve a system - filtered by [options] params'
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
        result = SwaggerClient::SystemsApi.new.get_system(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling SystemsApi->get_systems'.red
        puts to_output_hash(e)
      end
    end
  end

  class Systems < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc "all \[options\]", 'Retrieves all available system(s) - filtered by [options] params'
    # Optional parameters/fields
    option :registrationType,
           type: :string, required: false,
           enum: %w[assessAndAuthorize assessOnly guest regular functional cloudServiceProvider commonControlProvider]
    option :ditprId, type: :string,  required: false,
                     desc: 'DoD Information Technology (IT) Portfolio Repository (DITPR) string Id'
    option :coamsId, type: :string,  required: false,
                     desc: 'Cyber Operational Attributes Management System (COAMS) string Id'
    option :policy, type: :string,  required: false, enum: %w[diacap rmf reporting]

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
        result = SwaggerClient::SystemsApi.new.get_systems(optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
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

    desc "byCategory \[options\]", 'Retrieves role(s) - filtered by [options] params'
    # Required parameters/fields
    option :roleCategory, type: :string, required: true, enum: %w[PAC CAC Other]
    option :role,         type: :string, required: true,
                          enum: ['AO', 'Auditor', 'Artifact Manager', 'C&A Team', 'IAO',
                                 'ISSO', 'PM/IAM', 'SCA', 'User Rep (View Only)', 'Validator (IV&V)']
    # Optional parameters/fields
    option :policy, type: :string, required: false, enum: %w[diacap rmf reporting]
    option :includeDecommissioned, type: :boolean, required: false, desc: 'BOOLEAN - true or false.'

    def byCategory
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = SwaggerClient::SystemRolesApi.new.get_system_roles_by_category_id(options[:roleCategory],
                                                                                   options[:role], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
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
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :acronyms, type: :string,  required: false,
                      desc: 'The system acronym(s) e.g "AC-1, AC-2" - if not provided all controls for systemId are' \
                            ' returned'

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = SwaggerClient::ControlsApi.new.get_system_controls(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
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
        result = SwaggerClient::TestResultsApi.new.get_system_test_results(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
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
    option :systemId, type: :numeric,  required: true,
                      desc: 'A numeric value representing the system identification'
    # Optional parameters/fields
    option :scheduledCompletionDateStart, type: :numeric,  required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd,   type: :numeric,  required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'
    option :controlAcronyms, type: :string,  required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :ccis,            type: :string,  required: false, desc: 'The system CCIS string numerical value'
    option :systemOnly,      type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = SwaggerClient::POAMApi.new.get_system_poams(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling POAMApi->get_system_poams'.red
        puts to_output_hash(e)
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
      result = SwaggerClient::POAMApi.new.get_system_poams_by_poam_id(options[:systemId], options[:poamId])
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
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
        result = SwaggerClient::MilestonesApi.new.get_system_milestones_by_poam_id(options[:systemId],
                                                                                   options[:poamId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling MilestonesApi->get_system_milestones_by_poam_id'.red
        puts to_output_hash(e)
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
      result = SwaggerClient::MilestonesApi.new.get_system_milestones_by_poam_id_and_milestone_id(
        options[:systemId], options[:poamId], options[:milestoneId]
      )
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling MilestonesApi->get_system_milestones_by_poam_id_and_milestone_id'.red
      puts to_output_hash(e)
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

    desc 'system', 'Get all system artifacts for a system Id'
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
        result = SwaggerClient::ArtifactsApi.new.get_system_artifacts(options[:systemId],
                                                                      optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ArtifactsApi->get_system_artifacts'.red
        puts to_output_hash(e)
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

      result = SwaggerClient::ArtifactsExportApi.new.get_system_artifacts_export(
        options[:systemId], options[:filename], optional_options
      )
      if options[:compress]
        p result.green
      else
        begin
          puts JSON.pretty_generate(JSON.parse(result)).green
        rescue StandardError
          puts result.red
        end
      end
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling ArtifactsApi->get_system_artifacts_export'.red
      puts to_output_hash(e)
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
                             desc: 'The system acronym(s) e.g "AC-1, AC-2" - if not provided all CACs for systemId' \
                                   ' are returned'

    def controls
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get location of one or many controls in CAC
        result = SwaggerClient::CACApi.new.get_system_cac(options[:systemId], optional_options)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ApprovalChainApi->get_system_cac'.red
        puts to_output_hash(e)
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
      result = SwaggerClient::PACApi.new.get_system_pac(options[:systemId])
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_system_'.red
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
    option :sinceDate, type: :string, required: true, desc: 'The CMMC date. Unix date format'

    def assessments
      result = SwaggerClient::CMMCAssessmentsApi.new.get_cmmc_assessments(options[:sinceDate])
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_cmmc_assessments'.red
      puts to_output_hash(e)
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

      result = SwaggerClient::WorkflowDefinitionsApi.new.get_workflow_definitions(optional_options)
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
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

    desc 'forSystem', 'Get workflow instances in a system'
    # Required parameters/fields
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'

    # Optional parameters/fields
    option :includeComments, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    option :pageIndex, type: :numeric, required: false, desc: 'The page number to be returned'
    option :sinceDate, type: :string, required: false, desc: 'The workflow instance date. Unix date format'
    option :status, type: :string, required: false, enum: %w[active inactive all]

    def forSystem
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      result = SwaggerClient::WorkflowInstancesApi.new.get_system_workflow_instances(
        options[:systemId], optional_options
      )
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_system_workflow_instances'.red
      puts to_output_hash(e)
    end

    # Workflow by workflowInstanceId ---------------------------------------------------------
    desc 'byWorkflowInstanceId', 'Get workflow instance by ID in a system'

    # Required parameters/fields
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :workflowInstanceId, type: :numeric, required: true,
                                desc: 'A numeric value representing the workflowInstance identification'

    def byWorkflowInstanceId
      result = SwaggerClient::WorkflowInstancesApi.new.get_system_workflow_instances_by_workflow_instance_id(
        options[:systemId], options[:workflowInstanceId]
      )
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->get_system_workflow_instances_by_workflow_instance_id'.red
      puts to_output_hash(e)
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
  end
end
# rubocop:enable Naming/MethodName
