# frozen_string_literal: true

# Hack class that properly formats the CLI help
class SubCommandBase < Thor
  include OutputConverters

  # We do not control the method declaration for the banner

  # rubocop:disable Style/OptionalBooleanParameter
  def self.banner(command, _namespace = nil, subcommand = false)
    # Use the $thor_runner (declared by the Thor CLI framework)
    # to properly format the help text of sub-sub-commands.

    # rubocop:disable Style/GlobalVars
    if ancestors[0].to_s.include? '::Put'
      "#{basename} #{command.formatted_usage(self, $thor_runner, subcommand)}"
    else
      "#{basename} put #{command.formatted_usage(self, $thor_runner, subcommand)}"
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
  CONTROLS_PUT_HELP_MESSAGE = "\nInvoke \"bundle exec exe/emasser put controls help update\" for additional help"
  POAMS_PUT_HELP_MESSAGE = "\nInvoke \"bundle exec exe/emasser put poams help add\" for additional help"
  # Update Security Control information of a system for both the Implementation Plan and Risk Assessment.
  #
  # Endpoint:
  #    /api/systems/{systemId}/controls - Update control information in a system for one or many controls
  # rubocop:disable Style/WordArray
  class Controls < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'update', 'Get control information in a system for one or many controls (acronym)'
    long_desc Help.text(:controls_put_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :acronym,  type: :string,  required: true, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :responsibleEntities, type: :string, required: true,
      desc: 'Description of the responsible entities for the Security Control'
    option :controlDesignation, type: :string, required: true,
      enum: ['Common', 'System-Specific', 'Hybrid'], desc: 'The Security Control Designation'
    option :estimatedCompletionDate, type: :numeric, required: true, desc: 'Estimated completion date, Unix time format'
    option :implementationNarrative, type: :string, required: true, desc: 'Security control comments'

    # Conditional parameters/fields
    option :commonControlProvider,
           type: :string, required: false, enum: ['DoD', 'Component', 'Enclave'],
           desc: 'Indicate the type of Common Control Provider for an "Inherited" Security Control'
    option :naJustification,
           type: :string, required: false,
           desc: 'Provide justification for Security Controls deemed Not Applicable to the system'
    option :slcmCriticality, type: :string, required: false, desc: 'Criticality of Security Control regarding SLCM'
    option :slcmFrequency, type: :string, required: false,
           enum: ['Constantly', 'Daily', 'Weekly', 'Monthly', 'Quarterly', 'Semi-Annually',
                  'Annually', 'Every Two Years', 'Every Three Years', 'Undetermined'],
           desc: 'The System-Level Continuous Monitoring frequency'
    option :slcmMethod, type: :string, required: false,
           enum: ['Automated', 'Semi-Automated', 'Manual', 'Undetermined'],
           desc: 'The System-Level Continuous Monitoring method'
    option :slcmReporting, type: :string, required: false,
           desc: 'The System-Level Continuous Monitoring reporting'
    option :slcmTracking, type: :string, required: false,
           desc: 'The System-Level Continuous Monitoring tracking'
    option :slcmComments, type: :string, required: false,
           desc: 'Additional comments for Security Control regarding SLCM'

    # Optional parameters/fields
    option :implementationStatus, type: :string, required: false,
           enum: ['Planned', 'Implemented', 'Inherited', 'Not Applicable', 'Manually Inherited'],
           desc: 'Implementation status of the security control for the information system'
    option :severity, type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control severity, required for approved items'
    option :vulnerabiltySummary, type: :string, required: false, desc: 'The security control vulnerability summary'
    option :recommendations, type: :string, required: false, desc: 'The security control vulnerability recommendation'
    option :relevanceOfThreat, type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control vulnerability of threat'
    option :likelihood, type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control likelihood of vulnerability to threats'
    option :impact, type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control vulnerability impact'
    option :impactDescription, type: :string, required: false, desc: 'Description of the security control impact'
    option :residualRiskLevel, type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control risk level'
    option :testMethod, type: :string, required: false,
           enum: ['Test', 'Interview', 'Examine', 'Test, Interview', 'Test, Examine',
                  'Interview, Examine', 'Test, Interview, Examine'],
           desc: 'Assessment method/combination that determines if the security requirements are implemented correctly'

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def update
      # Check if business logic is satisfied
      process_business_logic

      # Required fields
      required = EmassClient::ControlsRequiredFields.new
      required.acronym = options[:acronym]
      required.responsible_entities = options[:responsibleEntities]
      required.control_designation = options[:controlDesignation]
      required.estimated_completion_date = options[:estimatedCompletionDate]
      required.implementation_narrative = options[:implementationNarrative]

      # Add optional fields
      optional = EmassClient::ControlsOptionalFields.new
      optional.implementation_status = options[:implementationStatus] if options[:implementationStatus]
      optional.severity = options[:severity] if options[:severity]
      optional.vulnerabilty_summary = options[:vulnerabiltySummary] if options[:vulnerabiltySummary]
      optional.recommendations = options[:recommendations] if options[:recommendations]
      optional.relevance_of_threat = options[:relevanceOfThreat] if options[:relevanceOfThreat]
      optional.likelihood = options[:likelihood] if options[:likelihood]
      optional.impact = options[:impact] if options[:impact]
      optional.impact_description = options[:impactDescription] if options[:impactDescription]
      optional.residual_risk_level = options[:residualRiskLevel] if options[:residualRiskLevel]
      optional.test_method = options[:testMethod] if options[:testMethod]
      optional.mitigations = options[:mitigations] if options[:mitigations]
      optional.application_layer = options[:applicationLayer] if options[:applicationLayer]
      optional.database_layer = options[:databaseLayer] if options[:databaseLayer]
      optional.operating_system_layer = options[:operatingSystemLayer] if options[:operatingSystemLayer]

      # Add conditional fields
      conditional = EmassClient::ControlsConditionalFields.new
      conditional.common_control_provider = options[:commonControlProvider] if options[:commonControlProvider]
      conditional.na_justification = options[:naJustification] if options[:naJustification]
      conditional.slcm_criticality = options[:slcmCriticality] if options[:slcmCriticality]
      conditional.slcm_frequency = options[:slcmFrequency] if options[:slcmFrequency]
      conditional.slcm_method = options[:slcmMethod] if options[:slcmMethod]
      conditional.slcm_reporting = options[:slcmReporting] if options[:slcmReporting]
      conditional.slcm_tracking = options[:slcmTracking] if options[:slcmTracking]
      conditional.slcm_comments = options[:slcmComments] if options[:slcmComments]

      # Build the request body
      body = {}
      body = body.merge(required)
      body = body.merge(optional)
      body = body.merge(conditional)

      # All good, wrap object into an array
      body_array = Array.new(1, body)

      begin
        result = EmassClient::ControlsApi.new.update_control_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ControlsApi->update_control_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    # rubocop:disable Style/CaseLikeIf, Style/StringLiterals, Metrics/BlockLength, Metrics/CyclomaticComplexity
    no_commands do
      # rubocop:disable Metrics/PerceivedComplexity, Style/MultipleComparison
      def process_business_logic
        # Conditional fields based on implementationStatus content
        # unless executes code if conditional is false
        unless options[:implementationStatus].nil?
          if options[:implementationStatus] == "Planned" || options[:implementationStatus] == "Implemented"
            if options[:responsibleEntities].nil? || options[:slcmCriticality].nil? ||
               options[:slcmFrequency].nil? || options[:slcmMethod].nil? ||
               options[:slcmReporting].nil? || options[:slcmTracking].nil? || options[:slcmComments].nil?
              puts 'Missing one of these parameters/fields:'.red
              puts '  responsibleEntities, slcmCriticality, slcmFrequency,'.red
              puts '  slcmMethod,slcmReporting, slcmTracking, slcmComments'.red
              puts CONTROLS_PUT_HELP_MESSAGE.yellow
              exit
            end
          elsif options[:implementationStatus] == 'Not Applicable'
            if options[:naJustification].nil? || options[:responsibleEntities].nil?
              puts 'Missing one of these parameters/fields:'.red
              puts '  naJustification, responsibleEntities'.red
              puts CONTROLS_PUT_HELP_MESSAGE.yellow
              exit
            end
          elsif options[:implementationStatus] == 'Manually Inherited'
            if options[:commonControlProvider].nil? || options[:responsibleEntities].nil? ||
               options[:slcmCriticality].nil? || options[:slcmFrequency].nil? || options[:slcmMethod].nil? ||
               options[:slcmReporting].nil? || options[:slcmTracking].nil? || options[:slcmComments].nil?
              puts 'Missing one of these parameters/fields:'.red
              puts '  commonControlProvider, responsibleEntities, slcmCriticality,'.red
              puts '  slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments'.red
              puts CONTROLS_PUT_HELP_MESSAGE.yellow
              exit
            end
          elsif options[:implementationStatus] == 'Inherited'
            if options[:commonControlProvider].nil?
              puts 'When implementationStatus value is "Inherited" only the following fields are updated:'.red
              puts '    controlDesignation and commonControlProvider'.red
              puts 'Missing the commonControlProvider field'.red
              puts CONTROLS_PUT_HELP_MESSAGE.yellow
              exit
            end
          end
        else
          puts 'The "--implementationStatus" parameter is required when updating a Security Control.'.red
          puts 'Values include the following: (Planned, Implemented, Inherited, Not Applicable, Manually Inherited)'.red
          exit
        end
      end
      # rubocop:enable Metrics/PerceivedComplexity, Style/MultipleComparison
    end
    # rubocop:enable Style/CaseLikeIf, Style/StringLiterals, Metrics/BlockLength, Metrics/CyclomaticComplexity
  end
  # rubocop:enable Style/WordArray

  # Update Plan of Action (POA&M) items to a system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams
  class Poams < SubCommandBase
    def self.exit_on_failure?
      true
    end

    # Update a POAM -----------------------------------------------------------
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
    # fields are required within the request.
    # pocOrganization, pocFirstName, pocLastName, pocEmail, pocPhoneNumber

    desc 'update', 'Update one or many POA&M items in a system'
    long_desc Help.text(:poam_put_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :poamId, type: :numeric, required: true, desc: 'A numeric value representing the poam identification'
    # option :displayPoamId, type: :numeric, required: true,
    #        desc: 'Globally unique identifier for individual POA&M Items, seen on the front-end as "ID"'
    option :status, type: :string, required: true, enum: ['Ongoing', 'Risk Accepted', 'Completed', 'Not Applicable']
    option :vulnerabilityDescription, type: :string, required: true, desc: 'POA&M vulnerability description'
    option :sourceIdentifyingVulnerability, type: :string, required: true, desc: 'Source that identifies the vulnerability'
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
    option :milestone, type: :hash, required: false, desc: 'key:values are: milestoneId, description and scheduledCompletionDate'
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
    # API spec states that the displayPoamId is a required field, by backend does not require it
    option :displayPoamId, type: :numeric, required: false,
          desc: 'Globally unique identifier for individual POA&M Items, seen on the front-end as "ID"'
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
    # option :mitigations, type: :string, required: false, desc: 'Mitigations explanation'
    # The next field is Required for VA. Optional for Army and USCG.
    option :identifiedInCFOAuditOrOtherReview, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    # The next fields are for Navy Only
    option :resultingResidualRiskLevelAfterProposedMitigations, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :predisposingConditions, type: :string, required: false, desc: 'Conditions (text 2,000 char)'
    option :threatDescription, type: :string, required: false, desc: 'Threat description (text 2,000 char)'
    option :devicesAffected, type: :string, required: false, desc: 'Devices Affected (text 2,000 char)'

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize
    def update
      # Check if business logic is satisfied
      process_business_logic

      # Required fields
      require_id_fields = EmassClient::PoamIds.new
      require_id_fields.poam_id = options[:poamId]
      # API spec states that the displayPoamId is a required field, by backend does not require it
      require_id_fields.display_poam_id = options[:displayPoamId] if options[:displayPoamId]

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
      milestone['milestoneId'] = options[:milestone]['milestoneId'].to_i if options[:milestone]['milestoneId']
      milestone['description'] = options[:milestone]['description'] if options[:milestone]['description']
      milestone['scheduledCompletionDate'] = options[:milestone]['scheduledCompletionDate'].to_f if options[:milestone]['scheduledCompletionDate']
      milestone_array = Array.new(1, milestone)

      # Build the request body
      body = {}
      body = body.merge(require_id_fields)
      body = body.merge(require_fields)
      body = body.merge(optional_fields)
      body = body.merge(conditional_fields)
      body = body.merge({ milestones: milestone_array })
      body_array = Array.new(1, body)

      begin
        result = EmassClient::POAMApi.new.update_poam_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling POAMApi->update_poam_by_system_id'.red
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
            puts POAMS_PUT_HELP_MESSAGE.yellow
            exit
          elsif !(options[:scheduledCompletionDate].nil? && options[:milestone].nil?)
            puts 'When status = "Risk Accepted" POA&M Item CAN NOT be saved with the following parameters/fields:'.red
            puts '    scheduledCompletionDate, or milestone'.red
            puts POAMS_PUT_HELP_MESSAGE.yellow
            exit
          else
            body.comments = options[:comments]
          end
        elsif options[:status] == "Ongoing"
          if options[:scheduledCompletionDate].nil? || options[:milestone].nil?
            puts 'When status = "Ongoing" the following parameters/fields are required:'.red
            puts '    scheduledCompletionDate, milestone'.red
            print_milestone_help
            puts POAMS_PUT_HELP_MESSAGE.yellow
            exit
          elsif options[:milestone]["description"].nil? || options[:milestone]["scheduledCompletionDate"].nil?
            puts 'Missing milstone parameters/fields'.red
            print_milestone_help
            exit
          end
        elsif options[:status] == "Completed"
          if options[:scheduledCompletionDate].nil? || options[:comments].nil? ||
             options[:completionDate].nil? || options[:milestone].nil?
            puts 'Missing one of these parameters/fields:'.red
            puts '    scheduledCompletionDate, comments, completionDate, or milestone'.red
            print_milestone_help
            puts POAMS_PUT_HELP_MESSAGE.yellow
            exit
          end
        end

        # POC checks: If any poc information is provided all POC fields are required
        if options[:pocFirstName]
          if options[:pocLastName].nil? || options[:pocEmail].nil? || options[:pocPhoneNumber].nil?
            puts 'If a POC first name is given, then all POC information must be entered:'.red
            puts '    pocLastName, pocEmail, pocPhoneNumber'.red
            puts POAMS_PUT_HELP_MESSAGE.yellow
            exit
          end
        elsif options[:pocLastName]
          if options[:pocFirstName].nil? || options[:pocEmail].nil? || options[:pocPhoneNumber].nil?
            puts 'If a POC last name is given, then all POC information must be entered:'.red
            puts '    pocFirstName, pocEmail, pocPhoneNumber'.red
            puts POAMS_PUT_HELP_MESSAGE.yellow
            exit
          end
        elsif options[:pocEmail]
          if options[:pocFirstName].nil? || options[:pocLastName].nil? || options[:pocPhoneNumber].nil?
            puts 'If a POC email is given, then all POC information must be entered:'.red
            puts '    pocFirstName, pocLastName, pocPhoneNumber'.red
            puts POAMS_PUT_HELP_MESSAGE.yellow
            exit
          end
        elsif options[:pocPhoneNumber]
          if options[:pocFirstName].nil? || options[:pocLastName].nil? || options[:pocEmail].nil?
            puts 'If a POC phone number is given, then all POC information must be entered:'.red
            puts '    pocFirstName, pocLastName, pocEmail'.red
            puts POAMS_PUT_HELP_MESSAGE.yellow
            exit
          end
        end
        # rubocop:enable Style/CaseLikeIf, Style/StringLiterals
      end

      def print_milestone_help
        puts 'Milestone format is:'.yellow
        puts '    --milestone milestoneId:[value] description:"[value]" scheduledCompletionDate:"[value]"'.yellow
        puts 'The milestoneId:[value] is optional, if not provided a new milestone is created'.yellow
      end
    end
    # rubocop:enable Metrics/BlockLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  # Update Milestones items to a system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams/{poamId}/milestones
  class Milestones < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'update', 'Update milestone(s) for given specified system and poam'
    long_desc Help.text(:milestone_put_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :poamId, type: :numeric, required: true, desc: 'A numeric value representing the poam identification'
    option :milestoneId,
           type: :numeric, required: true, desc: 'A numeric value representing the milestone identification'
    option :description, type: :string, required: true, desc: 'The milestone description'
    option :scheduledCompletionDate,
           type: :numeric, required: false, desc: 'The scheduled completion date - Unix time format'

    def update
      body = EmassClient::MilestonesGet.new
      body.milestone_id = options[:milestoneId]
      body.description = options[:description]
      body.scheduled_completion_date = options[:scheduledCompletionDate]
      body_array = Array.new(1, body)

      begin
        # Get milestones in one or many poa&m items in a system
        result = EmassClient::MilestonesApi
                 .new
                 .update_milestone_by_system_id_and_poam_id(options[:systemId], options[:poamId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling MilestonesApi->update_milestone_by_system_id_and_poam_id'.red
        puts to_output_hash(e)
      end
    end
  end

  # Update one or many artifacts for a system
  # (only one artifact per each execution)
  #
  # Endpoint:
  #    /api/systems/{systemId}/artifacts
  class Artifacts < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'update', 'Updates artifacts for a system with provided entries'
    long_desc Help.text(:artifacts_put_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :filename, type: :string, required: true, desc: 'Artifact file name to be updated'
    option :type, type: :string, required: true, default: 'Other',
      desc: 'The type of artifact. Possible values are: Procedure, Diagram, Policy, Labor, Document, Image, Other, Scan Result, Auditor Report. May also accept other values set by system administrators.'
    option :category, type: :string, required: true, default: 'Evidence',
      desc: 'The category of artifact. Possible values are: Implementation Guidance, Evidence. May also accept other values set by system administrators.'
    # NOTE: isTemplate is a required parameter, however Thor does not allow a boolean type to be required because it
    # automatically creates a --no-isTemplate option for isTemplate=false
    option :isTemplate, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    # Optional fields
    option :name, type: :string, required: false, desc: 'Artifact name'
    option :description, type: :string, required: false, desc: 'Artifact description'
    option :referencePageNumber, type: :string, required: false, desc: 'Artifact reference page number'
    option :controls, type: :string, required: false,
           desc: 'Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined'
    option :assessmentProcedures, type: :string, required: false, desc: 'The Security Control Assessment Procedure being associated with the artifact'
    option :expirationDate, type: :numeric, required: false, desc: 'Date Artifact expires and requires review - Unix time format'
    option :lastReviewedDate, type: :numeric, required: false, desc: 'Date Artifact was last reviewed - Unix time format'
    option :signedDate, type: :numeric, required: false, desc: 'Date Artifact was signed - Unix time format'

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def update
      require_fields = EmassClient::ArtifactsRequiredFields.new
      require_fields.filename = options[:filename]
      require_fields.type = options[:type]
      require_fields.category = options[:category]
      require_fields.is_template = options[:isTemplate]

      # Optional fields
      optional_fields = EmassClient::ArtifactsOptionalFields.new
      optional_fields.name = options[:name] if options[:name]
      optional_fields.description = options[:description] if options[:description]
      optional_fields.reference_page_number = options[:referencePageNumber] if options[:referencePageNumber]
      optional_fields.controls = options[:controls] if options[:controls]
      optional_fields.assessment_procedures = options[:assessmentProcedures] if options[:assessmentProcedures]
      optional_fields.expiration_date = options[:expirationDate] if options[:expirationDate]
      optional_fields.last_reviewed_date = options[:lastReviewedDate] if options[:lastReviewedDate]
      optional_fields.signed_date = options[:signedDate] if options[:signedDate]

      # Build the request body
      body = {}
      body = body.merge(require_fields)
      body = body.merge(optional_fields)
      body_array = Array.new(1, body)

      begin
        result = EmassClient::ArtifactsApi.new.update_artifact_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ArtifactsApi->update_artifact_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  # Update Hardware Baseline assets for a system
  # (only one hardware per each execution)
  #
  # Endpoints:
  #   /api/systems/{systemId}/hw-baseline
  class Hardware < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'update', 'Update one hardware assets in a system per execution'
    long_desc Help.text(:approvalPac_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :hardwareId, type: :string, required: true, desc: 'GUID identifying the specific hardware asset'
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
    def update
      # Required fields
      require_field = EmassClient::HwBaselineRequiredFields.new
      require_field.asset_name = options[:assetName]
      read_only_field = EmassClient::HwBaselineReadOnlyFields.new
      read_only_field.hardware_id = options[:hardwareId] if options[:hardwareId]

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
      body = body.merge(read_only_field)
      body = body.merge(conditional_fields)
      body = body.merge(optional_fields)
      body_array = Array.new(1, body)

      # Call the API
      result = EmassClient::HardwareBaselineApi.new.update_hw_baseline_assets(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling HardwareBaselineApi->update_hw_baseline_assets'.red
      puts to_output_hash(e)
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  # Add Software Baseline assets for a system
  # (only one software per each execution)
  #
  # Endpoints:
  #   /api/systems/{systemId}/sw-baseline
  class Software < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'update', 'update one software assets into a system per execution'
    long_desc Help.text(:approvalPac_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :softwareId, type: :string, required: true, desc: 'GUID identifying the specific software asset'
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
    option :licenseExpirationDate, type: :numeric, required: false, desc: 'TLicense expiration date for the software asset'
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

    # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def update
      # Required fields
      require_field = EmassClient::SwBaselineRequiredFields.new
      require_field.software_vendor = options[:softwareVendor]
      require_field.software_name = options[:softwareName]
      require_field.version = options[:version]
      read_only_field = EmassClient::SwBaselineReadOnlyFields.new
      read_only_field.software_id = options[:softwareId] if options[:softwareId]

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
      optional_fields.approval_date = options[:approvalDate] if options[:approvalDate]
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
      body = body.merge(read_only_field)
      body = body.merge(conditional_fields)
      body = body.merge(optional_fields)
      body_array = Array.new(1, body)

      # Call the API
      result = EmassClient::SoftwareBaselineApi.new.update_sw_baseline_assets(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SoftwareBaselineApi->update_sw_baseline_assets'.red
      puts to_output_hash(e)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  class Put < SubCommandBase
    desc 'controls', 'Update system Controls'
    subcommand 'controls', Controls

    desc 'poams', 'Update Plan of Action (POA&M) items for a system'
    subcommand 'poams', Poams

    desc 'milestones', 'Update Milestones items for a system'
    subcommand 'milestones', Milestones

    desc 'artifacts', 'Update system Artifacts'
    subcommand 'artifacts', Artifacts

    desc 'hardware', 'Update one or many hardware assets to a system'
    subcommand 'hardware', Hardware

    desc 'software', 'Update one or many software assets to a system'
    subcommand 'software', Software
  end
end
