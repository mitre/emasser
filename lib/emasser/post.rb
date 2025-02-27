# frozen_string_literal: true

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
    if ancestors[0].to_s.include? '::Post'
      "#{basename} #{command.formatted_usage(self, $thor_runner, subcommand)}"
    else
      "#{basename} post #{command.formatted_usage(self, $thor_runner, subcommand)}"
    end
    # rubocop:enable Style/GlobalVars
  end
  # rubocop:enable Style/OptionalBooleanParameter
end

# Override thor's long_desc indentation behavior
class Thor
  module Shell
    class Basic
      def print_wrapped(message, _options = {})
        message = "\n#{message}\n" unless message[0] == "\n"
        stdout.puts message
      end
    end
  end
end

module Emasser
  # Common static messages
  POAMS_POST_HELP_MESSAGE = "\nInvoke \"emasser post poams help add\" for additional help"
  SCAN_POST_HELP_MESSAGE = "\nInvoke \"emasser post scan_findings help clear\" for additional help"

  # The Registration endpoint provides the ability to register a certificate & obtain an API-key.
  #
  # Endpoint:
  #    /api/api-key
  class Register < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'cert', 'Register a certificate & obtain an API-key'
    # rubocop:disable Style/RedundantBegin
    def cert
      begin
        result = EmassClient::RegistrationApi.new.register_user(Emasser::GET_REGISTER_RETURN_TYPE)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling RegistrationApi->register_user'.red
        puts to_output_hash(e).split('\n').join('. ')
      end
    end
    # rubocop:enable Style/RedundantBegin
  end

  # The Test Results endpoints provide the ability to add test results for a
  # system's Assessment Procedures (CCIs) which determine Security Control compliance.
  #
  # Endpoint:
  #    /api/systems/{systemId}/test-results
  class TestResults < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Post a test result for a system'
    long_desc Help.text(:testresults_post_mapper)

    # Required fields
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :assessmentProcedure, type: :string,  required: true, desc: 'The Security Control Assessment Procedure being assessed'
    option :testedBy,            type: :string,  required: true, desc: 'The person that conducted the test (Last Name, First)'
    option :testDate,            type: :numeric, required: true, desc: 'The date test was conducted, Unix time format.'
    option :description,         type: :string,  required: true, desc: 'The description of test result. 4000 Characters.'
    option :complianceStatus,    type: :string, required: true, enum: ['Compliant', 'Non-Compliant', 'Not Applicable']

    def add
      body = EmassClient::TestResultsGet.new
      body.assessment_procedure = options[:assessmentProcedure]
      body.tested_by = options[:testedBy]
      body.test_date = options[:testDate]
      body.description = options[:description]
      body.compliance_status = options[:complianceStatus]

      body_array = Array.new(1, body)

      begin
        result = EmassClient::TestResultsApi
                 .new.add_test_results_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling TestResultsApi->add_test_results_by_system_id'.red
        puts to_output_hash(e)
      end
    end
  end

  # The POA&M endpoints provide the ability to add Plan of Action and Milestones (POA&M)
  # items to a system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams
  class Poams < SubCommandBase
    def self.exit_on_failure?
      true
    end

    # POAM --------------------------------------------------------------------
    #
    # The following fields are required based on the contents of the status field
    # status          Required Fields
    # -------------------------------------------------------------------------
    # Risk Accepted   comments, resources
    # Ongoing         scheduledCompletionDate, resources, milestones (at least 1)
    # Completed       scheduledCompletionDate, comments, resources,
    #                 completionDate, milestones (at least 1)
    # Not Applicable  POAM can not be created
    #--------------------------------------------------------------------------
    # If a POC email is supplied, the application will attempt to locate a user
    # already registered within the application and pre-populate any information
    # not explicitly supplied in the request. If no such user is found, these
    # fields are required within the request:
    #     pocFirstName, pocLastName, pocPhoneNumber

    desc 'add', 'Add one or many POA&M items in a system'
    long_desc Help.text(:poam_post_mapper)

    # Required parameters/fields (the poamId and displayPoamId are generated by the PUT call)
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :status, type: :string, required: true, enum: ['Ongoing', 'Risk Accepted', 'Completed', 'Not Applicable', 'Archived']
    option :vulnerabilityDescription, type: :string, required: true, desc: 'POA&M vulnerability description'
    option :sourceIdentifyingVulnerability,
           type: :string, required: true, desc: 'Source that identifies the vulnerability'
    option :pocOrganization, type: :string, required: true, desc: 'Organization/Office represented'
    option :resources, type: :string, required: true, desc: 'List of resources used'

    # Some eMASS instances also require the Risk Analysis fields
    # Note: These are grouped here for identification only, they are not marked as required.
    option :severity, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :relevanceOfThreat, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :likelihood, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :impact, type: :string, required: false, desc: 'Description of Security Control’s impact'
    option :residualRiskLevel, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :mitigations, type: :string, required: false, desc: 'Mitigations explanation'

    # Conditional parameters/fields
    option :milestone, type: :hash, required: false, desc: 'key:values are: description and scheduledCompletionDate'
    option :pocFirstName, type: :string, required: false, desc: 'First name of POC'
    option :pocLastName, type: :string, required: false, desc: 'Last name of POC.'
    option :pocEmail, type: :string, required: false, desc: 'Email address of POC'
    option :pocPhoneNumber, type: :string, required: false, desc: 'Phone number of POC (area code) ***-**** format'
    # option :severity, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :scheduledCompletionDate,
           type: :numeric, required: false, desc: 'The scheduled completion date - Unix time format'
    option :completionDate,
           type: :numeric, required: false, desc: 'The schedule completion date - Unix time format'
    option :comments, type: :string, required: false, desc: 'Comments for completed and risk accepted POA&M items'
    # The next fields are Required for VA. Optional for Army and USCG.
    option :personnelResourcesFundedBaseHours, type: :numeric, required: false, desc: 'Funded based hours (125.34)'
    option :personnelResourcesCostCode, type: :string, required: false, desc: 'Values are specific per eMASS instance'
    option :personnelResourcesUnfundedBaseHours, type: :numeric, required: false, desc: 'Funded based hours (100.00)'
    option :personnelResourcesNonfundingObstacle, type: :string, required: false, desc: 'Values are specific per eMASS instance'
    option :personnelResourcesNonfundingObstacleOtherReason, type: :string, required: false, desc: 'Reason (text 2,000 char)'
    option :nonPersonnelResourcesFundedAmount, type: :numeric, required: false, desc: 'Funded based hours (100.00)'
    option :nonPersonnelResourcesCostCode, type: :string, required: false, desc: 'Values are specific per eMASS instance'
    option :nonPersonnelResourcesUnfundedAmount, type: :numeric, required: false, desc: 'Funded based hours (100.00)'
    option :nonPersonnelResourcesNonfundingObstacle, type: :string, required: false, desc: 'Values are specific per eMASS instance'
    option :nonPersonnelResourcesNonfundingObstacleOtherReason, type: :string, required: false, desc: 'Reason (text 2,000 char)'

    # Optional parameters/fields
    option :externalUid, type: :string, required: false, desc: 'External ID associated with the POA&M'
    option :controlAcronym, type: :string, required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :assessmentProcedure, type: :string, required: false, desc: 'The system CCIS string numerical value'
    option :securityChecks, type: :string, required: false, desc: 'Security Checks that are associated with the POA&M'
    option :rawSeverity, type: :string, required: false, enum: %w[I II III]
    # option :relevanceOfThreat, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    # option :likelihood, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    # option :impact, type: :string, required: false, desc: 'Description of Security Control’s impact'
    option :impactDescription, type: :string, required: false, desc: 'Description of the security control impact'
    # option :residualRiskLevel, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :recommendations, type: :string, required: false, desc: 'Recommendations'
    # option :mitigations, type: :string, required: false, desc: 'Mitigation explanation'
    # The next field is Required for VA. Optional for Army and USCG.
    option :identifiedInCFOAuditOrOtherReview, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    # The next fields are for Navy Only
    option :resultingResidualRiskLevelAfterProposedMitigations, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :predisposingConditions, type: :string, required: false, desc: 'Conditions (text 2,000 char)'
    option :threatDescription, type: :string, required: false, desc: 'Threat description (text 2,000 char)'
    option :devicesAffected, type: :string, required: false, desc: 'devicesAffected'

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize
    def add
      # Check if business logic is satisfied
      process_business_logic

      # Required fields
      require_fields = EmassClient::PoamRequiredFields.new
      require_fields.status = options[:status]
      require_fields.vulnerability_description = options[:vulnerabilityDescription]
      require_fields.source_identifying_vulnerability = options[:sourceIdentifyingVulnerability]
      require_fields.poc_organization = options[:pocOrganization]
      require_fields.resources = options[:resources]
      # Required for VA, optional for Army and USCG. - defaults to false
      require_fields.identified_in_cfo_audit_or_other_review = options[:identifiedInCFOAuditOrOtherReview] if options[:identifiedInCFOAuditOrOtherReview]

      # Add conditional fields
      conditional_fields = EmassClient::PoamConditionalFields.new
      conditional_fields.poc_first_name = options[:pocFirstName] if options[:pocFirstName]
      conditional_fields.poc_last_name = options[:pocLastName] if options[:pocLastName]
      conditional_fields.poc_email = options[:pocEmail] if options[:pocEmail]
      conditional_fields.poc_phone_number = options[:pocPhoneNumber] if options[:pocPhoneNumber]
      conditional_fields.severity = options[:severity] if options[:severity]
      conditional_fields.scheduled_completion_date = options[:scheduledCompletionDate] if options[:scheduledCompletionDate]
      conditional_fields.completion_date = options[:completionDate] if options[:completionDate]
      conditional_fields.comments = options[:comments] if options[:comments]
      conditional_fields.personnel_resources_funded_base_hours = options[:personnelResourcesFundedBaseHours] if options[:personnelResourcesFundedBaseHours]
      conditional_fields.personnel_resources_cost_code = options[:personnelResourcesCostCode] if options[:personnelResourcesCostCode]
      conditional_fields.personnel_resources_unfunded_base_hours = options[:personnelResourcesUnfundedBaseHours] if options[:personnelResourcesUnfundedBaseHours]
      conditional_fields.personnel_resources_nonfunding_obstacle = options[:personnelResourcesNonfundingObstacle] if options[:personnelResourcesNonfundingObstacle]
      conditional_fields.personnel_resources_nonfunding_obstacle_other_reason = options[:personnelResourcesNonfundingObstacleOtherReason] if options[:personnelResourcesNonfundingObstacleOtherReason]
      conditional_fields.non_personnel_resources_funded_amount = options[:nonPersonnelResourcesFundedAmount] if options[:nonPersonnelResourcesFundedAmount]
      conditional_fields.non_personnel_resources_cost_code = options[:nonPersonnelResourcesCostCode] if options[:nonPersonnelResourcesCostCode]
      conditional_fields.non_personnel_resources_unfunded_amount = options[:nonPersonnelResourcesUnfundedAmount] if options[:nonPersonnelResourcesUnfundedAmount]
      conditional_fields.non_personnel_resources_nonfunding_obstacle = options[:nonPersonnelResourcesNonfundingObstacle] if options[:nonPersonnelResourcesNonfundingObstacle]
      conditional_fields.non_personnel_resources_nonfunding_obstacle_other_reason = options[:nonPersonnelResourcesNonfundingObstacleOtherReason] if options[:nonPersonnelResourcesNonfundingObstacleOtherReason]

      # Add optional fields
      optional_fields = EmassClient::PoamOptionalFields.new
      optional_fields.external_uid = options[:externalUid] if options[:externalUid]
      optional_fields.control_acronym = options[:controlAcronym] if options[:controlAcronym]
      optional_fields.assessment_procedure = options[:assessmentProcedure] if options[:assessmentProcedure]
      optional_fields.security_checks = options[:securityChecks] if options[:securityChecks]
      optional_fields.raw_severity = options[:rawSeverity] if options[:rawSeverity]
      optional_fields.relevance_of_threat = options[:relevanceOfThreat] if options[:relevanceOfThreat]
      optional_fields.likelihood = options[:likelihood] if options[:likelihood]
      optional_fields.impact = options[:impact] if options[:impact]
      optional_fields.impact_description = options[:impactDescription] if options[:impactDescription]
      optional_fields.residual_risk_level = options[:residualRiskLevel] if options[:residualRiskLevel]
      optional_fields.recommendations = options[:recommendations] if options[:recommendations]
      optional_fields.mitigations = options[:mitigations] if options[:mitigations]
      optional_fields.resulting_residual_risk_level_after_proposed_mitigations = options[:resultingResidualRiskLevelAfterProposedMitigations] if options[:resultingResidualRiskLevelAfterProposedMitigations]
      optional_fields.predisposing_conditions = options[:predisposingConditions] if options[:predisposingConditions]
      optional_fields.threat_description = options[:threatDescription] if options[:threatDescription]
      optional_fields.devices_affected = options[:devicesAffected] if options[:devicesAffected]

      # Build the milestones object array
      milestone = {}
      milestone['description'] = options[:milestone]['description'] if options[:milestone]['description']
      milestone['scheduledCompletionDate'] = options[:milestone]['scheduledCompletionDate'].to_f if options[:milestone]['scheduledCompletionDate']
      milestone_array = Array.new(1, milestone)

      # Build the request body
      body = {}
      body = body.merge(require_fields)
      body = body.merge(optional_fields)
      body = body.merge(conditional_fields)
      body = body.merge({ milestones: milestone_array })
      body_array = Array.new(1, body)

      begin
        result = EmassClient::POAMApi.new.add_poam_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling POAMApi->add_poam_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize

    # rubocop:disable Metrics/BlockLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    no_commands do
      def process_business_logic
        #-----------------------------------------------------------------------------
        # Conditional fields based on the status field values
        # "Risk Accepted"   comments, resources
        # "Ongoing"         scheduledCompletionDate, resources, milestones (at least 1)
        # "Completed"       scheduledCompletionDate, comments, resources,
        #                   completionDate, milestones (at least 1)
        # "Not Applicable"  POAM can not be created
        #-----------------------------------------------------------------------------
        # rubocop:disable Style/CaseLikeIf, Style/StringLiterals
        if options[:status] == "Risk Accepted"
          if options[:comments].nil?
            puts 'When status = "Risk Accepted" the following parameters/fields are required:'.red
            puts '    comments'.red
            puts POAMS_POST_HELP_MESSAGE.yellow
            exit
          elsif !(options[:scheduledCompletionDate].nil? && options[:milestone].nil?)
            puts 'When status = "Risk Accepted" POA&M Item CAN NOT be saved with the following parameters/fields:'.red
            puts '    scheduledCompletionDate, or milestone'.red
            puts POAMS_PUT_HELP_MESSAGE.yellow
            exit
          end
        elsif options[:status] == "Ongoing"
          if options[:scheduledCompletionDate].nil? || options[:milestone].nil?
            puts 'When status = "Ongoing" the following parameters/fields are required:'.red
            puts '    scheduledCompletionDate, milestone'.red
            print_milestone_help
            puts POAMS_POST_HELP_MESSAGE.yellow
            exit
          elsif options[:milestone]["description"].nil? || options[:milestone]["scheduledCompletionDate"].nil?
            puts 'Missing milestone parameters/fields'.red
            print_milestone_help
            exit
          elsif options[:severity].nil? || options[:relevanceOfThreat].nil? ||
                options[:likelihood].nil? || options[:impact].nil? ||
                options[:residualRiskLevel].nil? || options[:mitigation].nil?
            puts 'Certain eMASS instances also require the Risk Analysis fields to be populated:'.yellow
            puts '    Severity, Relevance of Threat, Likelihood, Impact, Residual Risk Level, and Mitigations'.yellow
          end
        elsif options[:status] == "Completed"
          if options[:scheduledCompletionDate].nil? || options[:comments].nil? ||
             options[:completionDate].nil? || options[:milestone].nil?
            puts 'When status = "Completed" the following parameters/fields are required:'.red
            puts '    scheduledCompletionDate, comments, completionDate, or milestone'.red
            print_milestone_help
            puts POAMS_POST_HELP_MESSAGE.yellow
            exit
          end
        end

        # POC checks: If any poc information is provided all POC fields are required
        if options[:pocFirstName]
          if options[:pocLastName].nil? || options[:pocEmail].nil? || options[:pocPhoneNumber].nil?
            puts 'If a POC first name is given, then all POC information must be entered:'.red
            puts '    pocLastName, pocEmail, pocPhoneNumber'.red
            puts POAMS_POST_HELP_MESSAGE.yellow
            exit
          end
        elsif options[:pocLastName]
          if options[:pocFirstName].nil? || options[:pocEmail].nil? || options[:pocPhoneNumber].nil?
            puts 'If a POC last name is given, then all POC information must be entered:'.red
            puts '    pocFirstName, pocEmail, pocPhoneNumber'.red
            puts POAMS_POST_HELP_MESSAGE.yellow
            exit
          end
        elsif options[:pocEmail]
          if options[:pocFirstName].nil? || options[:pocLastName].nil? || options[:pocPhoneNumber].nil?
            puts 'If a POC email is given, then all POC information must be entered:'.red
            puts '    pocFirstName, pocLastName, pocPhoneNumber'.red
            puts POAMS_POST_HELP_MESSAGE.yellow
            exit
          end
        elsif options[:pocPhoneNumber]
          if options[:pocFirstName].nil? || options[:pocLastName].nil? || options[:pocEmail].nil?
            puts 'If a POC phone number is given, then all POC information must be entered:'.red
            puts '    pocFirstName, pocLastName, pocEmail'.red
            puts POAMS_POST_HELP_MESSAGE.yellow
            exit
          end
        end
        # rubocop:enable Style/CaseLikeIf, Style/StringLiterals
      end

      def print_milestone_help
        puts 'Milestone format is:'.yellow
        puts '    --milestone description:"[value]" scheduledCompletionDate:"[value]"'.yellow
      end
    end
    # rubocop:enable Metrics/BlockLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  # The Milestones endpoints provide the ability add milestones that are associated with
  # Plan of Action and Milestones (POA&M) items for a system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams/{poamId}/milestones
  class Milestones < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Add milestones to one or many POA&M items in a system'
    long_desc Help.text(:milestone_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :poamId, type: :numeric, required: true, desc: 'A numeric value representing the poam identification'
    option :description, type: :string, required: true, desc: 'The milestone description'
    option :scheduledCompletionDate, type: :numeric, required: true, desc: 'The scheduled completion date - Unix time format'

    def add
      body = EmassClient::MilestonesGet.new
      body.description = options[:description]
      body.scheduled_completion_date = options[:scheduledCompletionDate]
      body_array = Array.new(1, body)

      begin
        result = EmassClient::MilestonesApi
                 .new.add_milestone_by_system_id_and_poam_id(options[:systemId], options[:poamId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling MilestonesApi->add_milestone_by_system_id_and_poam_id'.red
        puts to_output_hash(e)
      end
    end
  end

  # Add one or many artifacts for a system (delivery method can be a file or a zip file)
  # Two Artifact POST methods are currently accepted: individual and bulk.
  # Filename uniqueness within an eMASS system will be enforced by the API for both methods.
  #
  # This method handles the upload of one or more files to the eMASS system.
  #   If a single file is provided (could be a file or zip file) the file is open (File.open)
  #     and passed to the API.
  #   It multiple files are provided, they are zipped into a single archive and sent to the API
  #
  # Endpoint:
  #    /api/systems/{systemId}/artifacts
  class Artifacts < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'upload SYSTEM_ID FILE [FILE ...]', 'Uploads [FILES] to the given [SYSTEM_ID] as artifacts'
    long_desc Help.text(:artifacts_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :files, type: :array, required: true, desc: 'Artifact file(s) to post to the given system'
    option :isBulk, type: :boolean, require: true, default: false, desc: 'Set to false for single file upload, true for multiple file upload, expects a .zip file'

    # Optional parameters/fields - if not provided, default values are used
    # These are the only options the backend will accept, all others are ignored
    option :type, type: :string, required: false, default: 'Other',
      desc: 'The type of artifact. Possible values are: Procedure, Diagram, Policy, Labor, Document, Image, Other, Scan Result, Auditor Report. May also accept other values set by system administrators.'
    option :category, type: :string, required: false, default: 'Evidence',
      desc: 'The category of artifact. Possible values are: Implementation Guidance, Evidence. May also accept other values set by system administrators.'
    option :isTemplate, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def upload
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)
      # Remove isBulk as it is an options parameter sent to the API.
      optional_options.delete(:is_bulk)

      # Options contain the default values (type, category, and isTemplate)
      # They are sent to the API in the form_params option
      opts = {}
      opts[:is_bulk] = options[:isBulk]
      opts[:form_params] = optional_options

      # Configure the upload file(s)
      remove_temp_file = false
      begin
        # If we have a single file, could be a zip file
        if options[:files].length == 1
          tempfile = File.open(options[:files][0], 'r')
        # if we have multiple files zip them into a zip file
        elsif options[:files].length > 1
          remove_temp_file = true
          tempfile = Tempfile.create(['artifacts', '.zip'])

          Zip::OutputStream.open(tempfile.path) do |z|
            options[:files].each do |file|
              # Add file name to the archive: Don't use the full path
              z.put_next_entry(File.basename(file))
              # Add the file to the archive
              z.print File.read(file)
            end
          end
        else
          puts 'No file(s) provided!'.yellow
        end
      rescue Errno::ENOENT => e
        warn "File open exception: #{e}".red
        exit 1
      end

      # Call the API
      begin
        result = EmassClient::ArtifactsApi
                 .new
                 .add_artifacts_by_system_id(options[:systemId], tempfile, opts)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ArtifactsApi->add_artifacts_by_system_id'.red
        puts to_output_hash(e)
      ensure
        # Close the file
        tempfile.close
        # Delete the temp file
        if remove_temp_file
          FileUtils.remove_file(tempfile, true)
        end
      end
    end
  end

  # Add a Control Approval Chain (CAC)
  #
  # Endpoints:
  #    /api/systems/{systemId}/approval/cac
  class CAC < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Submit control to second stage of CAC'
    long_desc Help.text(:approvalCac_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :controlAcronym, type: :string, required: true, desc: 'The system acronym "AC-1, AC-2"'

    # Conditional parameters/fields
    option :comments, type: :string, required: false, desc: 'The control approval chain comments'

    def add
      body = EmassClient::CacGet.new
      body.control_acronym = options[:controlAcronym]
      body.comments = options[:comments]

      body_array = Array.new(1, body)

      begin
        # Get location of one or many controls in CAC
        result = EmassClient::CACApi.new.add_system_cac(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ApprovalChainApi->add_system_cac'.red
        puts to_output_hash(e)
      end
    end
  end

  # Add a Package Approval Chain (PAC)
  #
  # Endpoints:
  #    /api/systems/{systemId}/approval/pac
  class PAC < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Initiate system workflow for review'
    long_desc Help.text(:approvalPac_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :workflow, type: :string, required: true, enum: ['Assess and Authorize', 'Assess Only', 'Security Plan Approval']
    option :name, type: :string, required: true, desc: 'The control package name'
    option :comments, type: :string, required: true, desc: 'Comments submitted upon initiation of the indicated workflow'

    def add
      body = EmassClient::PacGet.new
      body.name = options[:name]
      body.workflow = options[:workflow]
      body.comments = options[:comments]

      body_array = Array.new(1, body)

      result = EmassClient::PACApi.new.add_system_pac(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->add_system_pac'.red
      puts to_output_hash(e)
    end
  end

  # Add Hardware Baseline assets for a system
  #
  # Endpoints:
  #    /api/systems/{systemId}/hw-baseline - Add one or many hardware assets in a system
  class Hardware < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Add one or many hardware assets in a system'

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :assetName, type: :string, required: true, desc: 'Name of the hardware asset'

    # Conditional fields
    option :publicFacingFqdn, type: :string, required: false, desc: 'Public facing FQDN. Only applicable if Public Facing is set to true'
    option :publicFacingIpAddress, type: :string, required: false, desc: 'Public facing IP address. Only applicable if Public Facing is set to true'
    option :publicFacingUrls, type: :string, required: false, desc: 'Public facing URL(s). Only applicable if Public Facing is set to true'

    # Optional fields
    option :componentType, type: :string, required: false, desc: 'Component type of the hardware asset'
    option :nickname, type: :string, required: false, desc: 'Nickname of the hardware asset'
    option :assetIpAddress, type: :string, required: false, desc: 'IP address of the hardware asset'
    option :publicFacing, type: :boolean, required: false, desc: 'Public facing is defined as any asset that is accessible from a commercial connection'
    option :virtualAsset, type: :boolean, required: false, default: false, desc: 'Determine if this is a virtual hardware asset'
    option :manufacturer, type: :string, required: false, desc: 'Manufacturer of the hardware asset. Populated with “Virtual” by default if Virtual Asset is true'
    option :modelNumber, type: :string, required: false, desc: 'Model number of the hardware asset. Populated with “Virtual” by default if Virtual Asset is true'
    option :serialNumber, type: :string, required: false, desc: 'Serial number of the hardware asset. Populated with “Virtual” by default if Virtual Asset is true'
    option :OsIosFwVersion, type: :string, required: false, desc: 'OS/iOS/FW version of the hardware asset'
    option :memorySizeType, type: :string, required: false, desc: 'Memory size / type of the hardware asset'
    option :location, type: :string, required: false, desc: 'Location of the hardware asset'
    option :approvalStatus, type: :string, required: false, desc: 'Approval status of the hardware asset'
    option :criticalAsset, type: :boolean, required: false, default: false, desc: 'Indicates whether the asset is a critical information system asset'

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def add
      # Required fields
      require_field = EmassClient::HwBaselineRequiredFields.new
      require_field.asset_name = options[:assetName]

      # Conditional fields
      conditional_fields = EmassClient::HwBaselineConditionalFields.new
      conditional_fields.public_facing_fqdn = options[:publicFacingFqdn] if options[:publicFacingFqdn]
      conditional_fields.public_facing_ip_address = options[:publicFacingIpAddress] if options[:publicFacingIpAddress]
      conditional_fields.public_facing_urls = options[:publicFacingUrls] if options[:publicFacingUrls]

      # Optional fields
      optional_fields = EmassClient::HwBaselineOptionalFields.new
      optional_fields.component_type = options[:componentType] if options[:componentType]
      optional_fields.nickname = options[:nickname] if options[:nickname]
      optional_fields.asset_ip_address = options[:assetIpAddress] if options[:assetIpAddress]
      optional_fields.public_facing = options[:publicFacing] if options[:publicFacing]
      optional_fields.virtual_asset = options[:virtualAsset] if options[:virtualAsset]
      optional_fields.manufacturer = options[:manufacturer] if options[:manufacturer]
      optional_fields.model_number = options[:modelNumber] if options[:modelNumber]
      optional_fields.serial_number = options[:serialNumber] if options[:serialNumber]
      optional_fields.os_ios_fw_version = options[:OsIosFwVersion] if options[:OsIosFwVersion]
      optional_fields.memory_size_type = options[:memorySizeType] if options[:memorySizeType]
      optional_fields.location = options[:location] if options[:location]
      optional_fields.approval_status = options[:approvalStatus] if options[:approvalStatus]
      optional_fields.critical_asset = options[:criticalAsset] if options[:criticalAsset]

      # Build the body array
      body = {}
      body = body.merge(require_field)
      body = body.merge(conditional_fields)
      body = body.merge(optional_fields)
      body_array = Array.new(1, body)

      # Call the API
      result = EmassClient::HardwareBaselineApi.new.add_hw_baseline_assets(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling HardwareBaselineApi->add_hw_baseline_assets'.red
      puts to_output_hash(e)
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  # Add Software Baseline assets for a system
  #
  # Endpoints:
  #    /api/systems/{systemId}/sw-baseline
  class Software < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Add one or many software assets into a system'

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :softwareVendor, type: :string, required: true, desc: 'Vendor of the software asset'
    option :softwareName, type: :string, required: true, desc: 'Name of the software asset'
    option :version, type: :string, required: true, desc: 'Version of the software asset'

    # Conditional field
    # If Approval Status is set to “Unapproved” or “In Progress”, Approval Date will be set to null.
    option :approvalDate, type: :numeric, required: false, desc: 'Approval date of the software asset.'

    # Optional fields
    option :softwareType, type: :string, required: false, desc: 'Type of the software asset'
    option :parentSystem, type: :string, required: false, desc: 'Parent system of the software asset'
    option :subsystem, type: :string, required: false, desc: 'Subsystem of the software asset'
    option :network, type: :string, required: false, desc: 'Network of the software asset'
    option :hostingEnvironment, type: :string, required: false, desc: 'Hosting environment of the software asset'
    option :softwareDependencies, type: :string, required: false, desc: 'Dependencies for the software asset'
    option :cryptographicHash, type: :string, required: false, desc: 'Cryptographic hash for the software asset'
    option :inServiceData, type: :string, required: false, desc: 'In service data for the software asset'
    option :itBudgetUii, type: :string, required: false, desc: 'IT budget UII for the software asset'
    option :fiscalYear, type: :string, required: false, desc: 'Fiscal year (FY) for the software asset'
    option :popEndDate, type: :numeric, required: false, desc: 'Period of performance (POP) end date for the software asset'
    option :licenseOrContract, type: :string, required: false, desc: 'License or contract for the software asset'
    option :licenseTerm, type: :string, required: false, desc: 'License term for the software asset'
    option :costPerLicense, type: :numeric, required: false, desc: 'Cost per license for the software asset'
    option :totalLicenses, type: :numeric, required: false, desc: 'Number of total licenses for the software asset'
    option :totalLicenseCost, type: :numeric, required: false, desc: 'Total cost of the licenses for the software asset'
    option :licensesUsed, type: :numeric, required: false, desc: 'Number of licenses used for the software asset'
    option :licensePoc, type: :string, required: false, desc: 'Point of contact (POC) for the software asset'
    option :licenseRenewalDate, type: :numeric, required: false, desc: 'License renewal date for the software asset'
    option :licenseExpirationDate, type: :numeric, required: false, desc: 'License expiration date for the software asset'
    option :approvalStatus, type: :string, required: false, desc: 'Approval status of the software asset'
    option :approvalDate, type: :numeric, required: false, desc: 'Approval date of the software asset'
    option :releaseDate, type: :numeric, required: false, desc: 'Release date of the software asset'
    option :maintenanceDate, type: :numeric, required: false, desc: 'Maintenance date of the software asset'
    option :retirementDate, type: :numeric, required: false, desc: 'Retirement date of the software asset'
    option :endOfLifeSupportDate, type: :numeric, required: false, desc: 'End of life/support date of the software asset'
    option :extendedEndOfLifeSupportDate, type: :numeric, required: false, desc: 'Extended End of Life/Support Date cannot occur prior to the End of Life/Support Date'
    option :criticalAsset, type: :boolean, required: false, default: false, desc: 'Indicates whether the asset is a critical information system asset'
    option :location, type: :string, required: false, desc: 'Location of the software asset'
    option :purpose, type: :string, required: false, desc: 'Purpose of the software asset'
    # VA only
    option :unsupportedOperatingSystem, type: :boolean, required: false, default: false, desc: 'Unsupported operating system'
    option :unapprovedSoftwareFromTrm, type: :boolean, required: false, default: false, desc: 'Unapproved software from TRM'
    option :approvedWaiver, type: :boolean, required: false, default: false, desc: 'Approved waiver'

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def add
      # Required fields
      require_field = EmassClient::SwBaselineRequiredFields.new
      require_field.software_vendor = options[:softwareVendor]
      require_field.software_name = options[:softwareName]
      require_field.version = options[:version]

      # Conditional fields
      conditional_fields = EmassClient::SwBaselineConditionalFields.new
      conditional_fields.approval_date = options[:approvalDate] if options[:approvalDate]

      # Optional fields
      optional_fields = EmassClient::SwBaselineOptionalFields.new
      optional_fields.software_type = options[:softwareType] if options[:softwareType]
      optional_fields.parent_system = options[:parentSystem] if options[:parentSystem]
      optional_fields.subsystem = options[:subsystem] if options[:subsystem]
      optional_fields.network = options[:network] if options[:network]
      optional_fields.hosting_environment = options[:hostingEnvironment] if options[:hostingEnvironment]
      optional_fields.software_dependencies = options[:softwareDependencies] if options[:softwareDependencies]
      optional_fields.cryptographic_hash = options[:cryptographicHash] if options[:cryptographicHash]
      optional_fields.in_service_data = options[:inServiceData] if options[:inServiceData]
      optional_fields.it_budget_uii = options[:itBudgetUii] if options[:itBudgetUii]
      optional_fields.fiscal_year = options[:fiscalYear] if options[:fiscalYear]
      optional_fields.pop_end_date = options[:popEndDate] if options[:popEndDate]
      optional_fields.license_or_contract = options[:licenseOrContract] if options[:licenseOrContract]
      optional_fields.license_term = options[:licenseTerm] if options[:licenseTerm]
      optional_fields.cost_per_license = options[:costPerLicense] if options[:costPerLicense]
      optional_fields.total_licenses = options[:totalLicenses] if options[:totalLicenses]
      optional_fields.total_license_cost = options[:totalLicenseCost] if options[:totalLicenseCost]
      optional_fields.licenses_used = options[:licensesUsed] if options[:licensesUsed]
      optional_fields.license_poc = options[:licensePoc] if options[:licensePoc]
      optional_fields.license_renewal_date = options[:licenseRenewalDate] if options[:licenseRenewalDate]
      optional_fields.license_expiration_date = options[:licenseExpirationDate] if options[:licenseExpirationDate]
      optional_fields.approval_status = options[:approvalStatus] if options[:approvalStatus]
      optional_fields.release_date = options[:releaseDate] if options[:releaseDate]
      optional_fields.maintenance_date = options[:maintenanceDate] if options[:maintenanceDate]
      optional_fields.retirement_date = options[:retirementDate] if options[:retirementDate]
      optional_fields.end_of_life_support_date = options[:endOfLifeSupportDate] if options[:endOfLifeSupportDate]
      optional_fields.extended_end_of_life_support_date = options[:extendedEndOfLifeSupportDate] if options[:extendedEndOfLifeSupportDate]
      optional_fields.critical_asset = options[:criticalAsset] if options[:criticalAsset]
      optional_fields.location = options[:location] if options[:location]
      optional_fields.purpose = options[:purpose] if options[:purpose]
      # VA only.
      optional_fields.unsupported_operating_system = options[:unsupportedOperatingSystem] if options[:unsupportedOperatingSystem]
      optional_fields.unapproved_software_from_trm = options[:unapprovedSoftwareFromTrm] if options[:unapprovedSoftwareFromTrm]
      optional_fields.approved_waiver = options[:approvedWaiver] if options[:approvedWaiver]

      # Build the body array
      body = {}
      body = body.merge(require_field)
      body = body.merge(conditional_fields)
      body = body.merge(optional_fields)
      body_array = Array.new(1, body)

      # Call the API
      result = EmassClient::SoftwareBaselineApi.new.add_sw_baseline_assets(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SoftwareBaselineApi->add_sw_baseline_assets'.red
      puts to_output_hash(e)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  # Upload device scans (delivery method can be a file or a zip file)
  #
  # The body of a request for this endpoint accepts a single binary file.
  # Specific file extensions are expected depending upon the scanType parameter.
  # For example, .ckl or .cklb files are accepted when using scanType is set to
  # disaStigViewerCklCklb.
  #
  # When set to acasAsrArf or policyAuditor, a .zip file is expected which
  # should contain a single scan result (for example, a single pair of .asr and
  # .arf files).
  #
  # Single files are expected for all other scan types as this endpoint requires
  # files to be uploaded consecutively as opposed to in bulk.
  #
  # Current scan types that are supported:
  # • ACAS: ASR/ARF
  # • ACAS: NESSUS
  # • DISA STIG Viewer: CKL/CKLB
  # • DISA STIG Viewer: CMRS
  # • Policy Auditor
  # • SCAP Compliance Checker
  #
  # Endpoint:
  #   /api/systems/{systemId}/device-scan-results
  class DeviceScans < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'upload', 'Uploads device scans into a system'

    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :filename, aliases: '-f', type: :string, required: true, desc: 'The device scan file'
    option :scanType, aliases: '-t', type: :string, required: true, desc: 'The device scan type to upload',
      enum: %w{acasAsrArf acasNessus disaStigViewerCklCklb disaStigViewerCmrs policyAuditor scapComplianceChecker}

    # Optional parameters/fields - if not provided, default values are used
    option :isBaseline, aliases: '-B', type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def upload
      # Check if business logic is satisfied
      process_business_logic

      # Options contain the default values (type, category, and isTemplate)
      # They are sent to the API in the form_params option
      opts = {}
      opts[:isBaseline] = options[:isBaseline] if options[:isBaseline]

      # Configure the upload file
      begin
        # If we have a single file, could be a zip file
        if options[:filename]
          tempfile = File.open(options[:filename], 'r')
        else
          puts 'One (1) file is expected!'.yellow
        end
      rescue Errno::ENOENT => e
        warn "File open exception: #{e}".red
        exit 1
      end

      # Call the API
      begin
        result = EmassClient::DeviceScanResultsApi
                 .new
                 .add_scan_results_by_system_id(options[:systemId], options[:scanType], tempfile, opts)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling DeviceScanResultsApi->add_scan_results_by_system_id'.red
        puts to_output_hash(e)
      end
    end

    # rubocop:disable Style/MultipleComparison
    no_commands do
      def process_business_logic
        # If scanType is set to disaStigViewerCklCklb a .ckl or .cklb file is expect
        if options[:scanType] == 'disaStigViewerCklCklb' && !options[:filename].index('.ckl')
          puts 'If the scan type is "disaStigViewerCklCklb" a .ckl or .cklb file is expected'.red
          exit
        # If scanType is set to acasAsrArf or policyAuditor a .zip file is expect
        elsif options[:scanType] == 'acasAsrArf' || options[:scanType] == 'policyAuditor'
          if !options[:filename].index('.zip')
            puts 'If the scan type is "acasAsrArf or policyAuditor" a .zip file is expected'.red
            exit
          end
        end
      end
      # rubocop:enable Style/MultipleComparison
    end
  end

  # The Cloud Resources endpoint provides the ability to upload (add)
  # cloud resources and their scan results in the assets module for a system.
  #
  #
  # Endpoint:
  #   /api/systems/{systemId}/cloud-resources-results
  class CloudResource < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Upload cloud resources and their scan results'
    long_desc Help.text(:cloudresource_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :provider, type: :string, required: true, desc: 'Cloud service provider name'
    option :resourceId, type: :string, required: true, desc: 'Unique identifier/resource namespace for policy compliance result'
    option :resourceName, type: :string, required: true, desc: 'Friendly name of Cloud resource'
    option :resourceType, type: :string, required: true, desc: 'Type of Cloud resource'
    # compliance_results Array Objects (booleans cannot be required)
    option :cspPolicyDefinitionId, type: :string, required: true, desc: 'Unique identifier/compliance namespace for CSP/Resource\'s policy definition/compliance check'
    option :isCompliant, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false'
    option :policyDefinitionTitle, type: :string, required: true, desc: 'Friendly policy/compliance check title. Recommend short title'

    # Optional parameter/fields
    option :initiatedBy, type: :string, required: false, desc: 'Email of POC'
    option :cspAccountId, type: :string, required: false, desc: 'System/owner\'s CSP account ID/number'
    option :cspRegion, type: :string, required: false, desc: 'CSP region of system'
    option :isBaseline, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false'
    # Tags Object
    option :test, type: :string, required: false, desc: 'The test tag'
    # compliance_results Array Objects
    option :assessmentProcedure, type: :string, required: false, desc: 'Comma separated correlation to Assessment Procedure (i.e. CCI number for DoD Control Set)'
    option :complianceCheckTimestamp, type: :numeric, required: false, desc: 'The compliance timestamp Unix date format.'
    option :complianceReason, type: :string, required: false, desc: 'Reason/comments for compliance result'
    option :control, type: :string, required: false, desc: 'Comma separated correlation to Security Control (e.g. exact NIST Control acronym)'
    option :policyDeploymentName, type: :string, required: false, desc: 'Name of policy deployment'
    option :policyDeploymentVersion, type: :string, required: false, desc: 'policyDeploymentVersion'
    option :severity, type: :string, required: false, enum: %w[Low Medium Moderate High Critical]

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def add
      # Required and Optional main fields
      body = {}
      body[:provider] = options[:provider]
      body[:resourceId] = options[:resourceId]
      body[:resourceName] = options[:resourceName]
      body[:resourceType] = options[:resourceType]

      body[:initiatedBy] = options[:initiatedBy] if options[:initiatedBy]
      body[:cspAccountId] = options[:cspAccountId] if options[:cspAccountId]
      body[:cspRegion] = options[:cspRegion] if options[:cspRegion]
      body[:isBaseline] = options[:isBaseline] if options[:isBaseline]

      # Optional tags field
      tags = {}
      tags[:test] = options[:test] if options[:test]

      # Required and Optional compliances results fields
      compliance_results = {}
      compliance_results[:cspPolicyDefinitionId] = options[:cspPolicyDefinitionId]
      compliance_results[:isCompliant] = options[:isCompliant]
      compliance_results[:policyDefinitionTitle] = options[:policyDefinitionTitle]
      # Optional fields
      compliance_results[:assessmentProcedure] = options[:assessmentProcedure] if options[:assessmentProcedure]
      compliance_results[:complianceCheckTimestamp] = options[:complianceCheckTimestamp] if options[:complianceCheckTimestamp]
      compliance_results[:complianceReason] = options[:complianceReason] if options[:complianceReason]
      compliance_results[:control] = options[:control] if options[:control]
      compliance_results[:policyDeploymentName] = options[:policyDeploymentName] if options[:policyDeploymentName]
      compliance_results[:policyDeploymentVersion] = options[:policyDeploymentVersion] if options[:policyDeploymentVersion]
      compliance_results[:severity] = options[:severity] if options[:severity]
      compliance_results_array = Array.new(1, compliance_results)

      # Build the body array
      body[:tags] = tags
      body[:complianceResults] = compliance_results_array
      body_array = Array.new(1, body)

      # Call the API
      begin
        result = EmassClient::CloudResourceResultsApi
                 .new.add_cloud_resources_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling StaticCodeScansApi->add_cloud_resources_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  # The Containers endpoint provides the ability to upload (add)
  # containers and their scan results in the assets module for a system.
  #
  #
  # Endpoint:
  #   /api/systems/{systemId}/container-scan-results
  class Container < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Upload containers and their scan results'
    long_desc Help.text(:container_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :containerId, type: :string, required: true, desc: 'Unique identifier of the container'
    option :containerName, type: :string, required: true, desc: 'Friendly name of the container'
    option :time, type: :numeric, required: true, desc: 'Datetime of scan/result. Unix date format'
    # Benchmarks Array Object - Required
    option :benchmark, type: :string, required: true, desc: 'Identifier of the benchmark/grouping of compliance results'
    # Benchmarks.Results Array Object - Required
    option :lastSeen, type: :numeric, required: true, desc: 'Date last seen, Unix date format'
    option :ruleId, type: :string, required: true, desc: 'Identifier for the compliance result, vulnerability, etc. the result is for'
    option :status, type: :string, required: true, enum: ['Pass', 'Fail', 'Other', 'Not Reviewed', 'Not Checked', 'Not Applicable']

    # Optional parameter/fields
    option :namespace, type: :string, required: false, desc: 'Namespace of container in container orchestration'
    option :podIp, type: :string, required: false, desc: 'IP address of the pod'
    option :podName, type: :string, required: false, desc: 'Name of pod (e.g. Kubernetes pod)'

    # Tags Object - Optional
    option :test, type: :string, required: false, desc: 'The test tag'

    # Benchmarks Array Objects Optional
    option :isBaseline, type: :boolean, required: false, default: true, desc: 'BOOLEAN - true or false'
    option :version, type: :numeric, required: false, desc: 'The benchmark version'
    option :release, type: :numeric, required: false, desc: 'The benchmark release'

    # Benchmarks.Results Array Object - Optional
    option :message, type: :string, required: false, desc: 'Benchmark result comments'

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def add
      # Required fields
      body = {}
      body[:containerId] = options[:containerId]
      body[:containerName] = options[:containerName]
      body[:time] = options[:time]
      # Optional fields
      body[:namespace] = options[:namespace] if options[:namespace]
      body[:podIp] = options[:podIp] if options[:podIp]
      body[:podName] = options[:podName] if options[:podName]

      # Tags - Optional field
      tags = {}
      tags[:test] = options[:test] if options[:test]

      # Benchmarks - Required field
      benchmarks = {}
      benchmarks[:benchmark] = options[:benchmark]
      # Benchmarks - Optional fields
      benchmarks[:isBaseline] = options[:isBaseline] if options[:isBaseline]
      benchmarks[:version] = options[:version] if options[:version]
      benchmarks[:release] = options[:release] if options[:release]

      # Benchmarks.Results - Required fields
      benchmarks_results = {}
      benchmarks_results[:lastSeen] = options[:lastSeen]
      benchmarks_results[:ruleId] = options[:ruleId]
      benchmarks_results[:status] = options[:status]
      # Benchmarks.Results - Optional field
      benchmarks_results[:message] = options[:message] if options[:message]

      # Add Benchmark results to an array and add array to benchmarks object
      benchmarks_results_array = Array.new(1, benchmarks_results)
      benchmarks[:results] = benchmarks_results_array

      # Add benchmarks object to an array
      benchmarks_array = Array.new(1, benchmarks)
      # Add tags and benchmark ojects to body object
      body[:tags] = tags if tags.any?
      body[:benchmarks] = benchmarks_array

      # Build the body array
      body_array = Array.new(1, body)

      # Call the API
      begin
        result = EmassClient::ContainerScanResultsApi
                 .new.add_container_sans_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ContainerScanResultsApi->add_container_sans_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  # The Static Code Scans endpoint provides the ability to upload application
  # scan findings into a system's assets module.
  #
  # Application findings can also be cleared from the system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/static-code-scans - Upload static code scans
  class ScanFindings < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Upload static code scans'
    long_desc Help.text(:staticcode_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :applicationName, type: :string, required: true, desc: 'Name of the software application that was assessed'
    option :version, type: :string, required: true, desc: 'The version of the application'
    option :codeCheckName, type: :string, required: true, desc: 'Name of the software vulnerability or weakness'
    option :scanDate, type: :numeric, required: true, desc: 'The findings scan date - Unix time format'
    option :cweId, type: :string, required: true, desc: 'The Common Weakness Enumerator (CWE) identifier'
    option :count, type: :numeric, required: true, desc: 'Number of instances observed for a specified finding'
    # Optional parameter/fields
    option :rawSeverity, type: :string, required: false, enum: %w[Low Medium Moderate High Critical]

    def add
      application = EmassClient::StaticCodeRequestPostBodyApplication.new
      application.application_name = options[:applicationName]
      application.version = options[:version]

      application_findings = EmassClient::StaticCodeApplicationPost.new
      application_findings.code_check_name = options[:codeCheckName]
      application_findings.scan_date = options[:scanDate]
      application_findings.cwe_id = options[:cweId]
      application_findings.count = options[:count]
      application_findings.raw_severity = options[:rawSeverity] if options[:rawSeverity]

      app_findings_array = Array.new(1, application_findings)

      body = EmassClient::StaticCodeRequestPostBody.new
      body.application = application
      body.application_findings = app_findings_array

      body_array = Array.new(1, body)

      begin
        result = EmassClient::StaticCodeScansApi
                 .new.add_static_code_scans_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling StaticCodeScansApi->add_static_code_scans_by_system_id'.red
        puts to_output_hash(e)
      end
    end

    # CLEAR ------------------------------------------------------------------------------------
    desc 'clear', 'Clear an application findings'
    long_desc Help.text(:staticcode_clear_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :applicationName, type: :string, required: true, desc: 'Name of the software application that was assessed'
    option :version, type: :string, required: true, desc: 'The version of the application'
    option :clearFindings, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false'
    # NOTE: clearFindings is a required parameter to clear an application's findings, however Thor does not allow
    # a boolean type to be required because it automatically creates a --no-clearFindings option for clearFindings=false

    def clear
      unless options[:clearFindings]
        puts 'To clear an application findings, the field clearFindings (--clearFindings) is required'.red
        puts SCAN_POST_HELP_MESSAGE.yellow
        exit
      end

      application = EmassClient::StaticCodeRequestPostBodyApplication.new
      application.application_name = options[:applicationName]
      application.version = options[:version]

      application_findings = EmassClient::StaticCodeApplicationPost.new
      application_findings.clear_findings = options[:clearFindings]

      app_findings_array = Array.new(1, application_findings)

      body = EmassClient::StaticCodeRequestPostBody.new
      body.application = application
      body.application_findings = app_findings_array

      body_array = Array.new(1, body)

      begin
        result = EmassClient::StaticCodeScansApi
                 .new.add_static_code_scans_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling StaticCodeScansApi->add_static_code_scans_by_system_id'.red
        puts to_output_hash(e)
      end
    end
  end

  class Post < SubCommandBase
    desc 'register', 'Register a certificate & obtain an API-key'
    subcommand 'register', Register

    desc 'test_results', 'Add system Test Results'
    subcommand 'test_results', TestResults

    desc 'poams', 'Add Plan of Action and Milestones (POA&M) items to a system'
    subcommand 'poams', Poams

    desc 'milestones', 'Add milestone(s) to one or many POA&M items in a system'
    subcommand 'milestones', Milestones

    desc 'artifacts', 'Add system Artifacts'
    subcommand 'artifacts', Artifacts

    desc 'cac', 'Add Control Approval Chain (CAC) security content'
    subcommand 'cac', CAC

    desc 'pac', 'Add Package Approval Chain (PAC) security content'
    subcommand 'pac', PAC

    desc 'hardware', 'Add one or many hardware assets to a system'
    subcommand 'hardware', Hardware

    desc 'software', 'Add one or many software assets to a system'
    subcommand 'software', Software

    desc 'device_scans', 'Upload device scan results for a system'
    subcommand 'device_scans', DeviceScans

    desc 'cloud_resource', 'Upload cloud resource and their scan results'
    subcommand 'cloud_resource', CloudResource

    desc 'container', 'Upload container and their scan results'
    subcommand 'container', Container

    desc 'scan_findings', 'Upload static code scans'
    subcommand 'scan_findings', ScanFindings
  end
end
