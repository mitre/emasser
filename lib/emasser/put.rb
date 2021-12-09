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
      "exe/#{basename} #{command.formatted_usage(self, $thor_runner, subcommand)}"
    else
      "exe/#{basename} put #{command.formatted_usage(self, $thor_runner, subcommand)}"
    end
    # rubocop:enable Style/GlobalVars
  end
  # rubocop:enable Style/OptionalBooleanParameter
end

# Override thor's long_desc identation behavior
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
  # Update Security Control information of a system for both the Implementation Plan and Risk Assessment.
  #
  # Endpoint:
  #    /api/systems/{systemId}/controls - Update control information in a system for one or many controls
  # rubocop:disable Metrics/ClassLength, Style/WordArray
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
                                enum: ['Common', 'System-Specific', 'Hybrid'],
                                desc: 'The Security Control Designation'
    option :estimatedCompletionDate, type: :numeric, required: true, desc: 'Estimated completion date, Unix time format'
    option :implementationNarrative, type: :string, required: true, desc: 'Security control comments'

    # Conditional parameters/fields
    option :commonControlProvider,
           type: :string,
           required: false,
           enum: ['DoD', 'Component', 'Enclave'],
           desc: 'Indicate the type of Common Control Provider for an "Inherited" Security Control'
    option :naJustification,
           type: :string, required: false,
           desc: 'Provide justification for Security Controls deemed Not Applicable to the system'
    option :slcmCriticality,
           type: :string, required: false,
           desc: 'Criticality of Security Control regarding SLCM'
    option :slcmFrequency,
           type: :string, required: false,
           enum: ['Constantly', 'Daily', 'Weekly', 'Monthly', 'Quarterly', 'Semi-Annually',
                  'Annually', 'Every Two Years', 'Every Three Years', 'Undetermined'],
           desc: 'The System-Level Continuous Monitoring frequency'
    option :slcmMethod,
           type: :string, required: false,
           enum: ['Automated', 'Semi-Automated', 'Manual', 'Undetermined'],
           desc: 'The System-Level Continuous Monitoring method'
    option :slcmReporting,
           type: :string, required: false,
           desc: 'The System-Level Continuous Monitoring reporting'
    option :slcmTracking,
           type: :string, required: false,
           desc: 'The System-Level Continuous Monitoring tracking'
    option :slcmComments,
           type: :string, required: false,
           desc: 'Additional comments for Security Control regarding SLCM'

    # Optional parameters/fields
    option :implementationStatus,
           type: :string, required: false,
           enum: ['Planned', 'Implemented', 'Inherited', 'Not Applicable', 'Manually Inherited'],
           desc: 'Implementation status of the security control for the information system'
    option :severity,
           type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control severity, required for approved items'
    option :vulnerabiltySummary, type: :string, required: false, desc: 'The security control vulnerability summary'
    option :recommendations, type: :string, required: false, desc: 'The security control vulnerability recommendation'
    option :relevanceOfThreat,
           type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control vulnerability of threat'
    option :likelihood,
           type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control likelihood of vulnerability to threats'
    option :impact,
           type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control vulnerability impact'
    option :impactDescription, type: :string, required: false, desc: 'Description of the security control impact'
    option :residualRiskLevel,
           type: :string, required: false,
           enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High'],
           desc: 'The security control risk level'
    option :testMethod,
           type: :string, required: false,
           enum: ['Test', 'Interview', 'Examine', 'Test, Interview', 'Test, Examine',
                  'Interview, Examine', 'Test, Interview, Examine'],
           desc: 'Assessment method/combination that determines if the security requirements are implemented correctly'

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def update
      # Required fields
      body = SwaggerClient::ControlsRequestPutBody.new
      body.acronym = options[:acronym]
      body.responsible_entities = options[:responsibleEntities]
      body.control_designation = options[:controlDesignation]
      body.estimated_completion_date = options[:estimatedCompletionDate]
      body.implementation_narrative = options[:implementationNarrative]

      # Conditional fields based on implementationStatus content
      # rubocop:disable Style/CaseLikeIf, Style/StringLiterals, Style/NegatedIf
      if !options[:implementationStatus].nil?
        body.implementation_status = options[:implementationStatus]

        if options[:implementationStatus] == "Planned" || options[:implementationStatus] == "Implemented"
          if options[:controlDesignation].nil? || options[:responsibleEntities].nil? ||
             options[:slcmCriticality].nil? || options[:slcmFrequency].nil? ||
             options[:slcmMethod].nil? || options[:slcmReporting].nil? ||
             options[:slcmTracking].nil? || options[:slcmComments].nil?

            puts 'Missing one of these parameters/fields:'.red
            puts 'controlDesignation, responsibleEntities, slcmCriticality,
                  slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments'.red
            puts 'Invoke "bundle exec exe/emasser put controls help update" for additional help'.yellow
            exit
          else
            body.control_designation = option[:controlDesignation]
            body.responsible_entities = options[:responsibleEntities]
            body.slcm_criticality = options[:slcmCriticality]
            body.slcm_frequency = options[:slcmFrequency]
            body.slcm_method = options[:slcmMethod]
            body.slcm_reporting = options[:slcmReporting]
            body.slcm_tracking = options[:slcmTracking]
            body.slcm_comments = options[:slcmComments]
          end
        elsif options[:implementationStatus] == 'Not Applicable'
          if options[:naJustification].nil? || options[:controlDesignation].nil? || options[:responsibleEntities].nil?
            puts 'Missing one of these parameters/fields:'.red
            puts 'controlDesignation, naJustification, responsibleEntities'.red
            puts 'Invoke "bundle exec exe/emasser put controls help update" for additional help'.yellow
            exit
          else
            body.control_designation = option[:controlDesignation]
            body.slcm_reporting = options[:naJustification]
            body.responsible_entities = options[:responsibleEntities]
          end
        elsif options[:implementationStatus] == 'Manually Inherited'
          if options[:commonControlProvider].nil? || options[:controlDesignation].nil? ||
             options[:responsibleEntities].nil? || options[:slcmCriticality].nil? ||
             options[:slcmFrequency].nil? || options[:slcmMethod].nil? ||
             options[:slcmReporting].nil? || options[:slcmTracking].nil? || options[:slcmComments].nil?
            puts 'Missing one of these parameters/fields:'.red
            puts 'commonControlProvider, controlDesignation, responsibleEntities, slcmCriticality,
                  slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments'.red
            puts 'Invoke "bundle exec exe/emasser put controls help update" for additional help'.yellow
            exit
          else
            body.common_control_provider = options[:commonControlProvider]
            body.control_designation = options[:controlDesignation]
            body.responsible_entities = options[:responsibleEntities]
            body.slcm_criticality = options[:slcmCriticality]
            body.slcm_frequency = options[:slcmFrequency]
            body.slcm_method = options[:slcmMethod]
            body.slcm_reporting = options[:slcmReporting]
            body.slcm_tracking = options[:slcmTracking]
            body.slcm_comments = options[:slcmComments]
          end
        elsif options[:implementationStatus] == 'Inherited'
          if options[:commonControlProvider].nil? || options[:controlDesignation].nil?
            puts 'When implementationStatus=Inherited only these fields are update:'.red
            puts 'commonControlProvider, controlDesignation'.red
            puts 'Invoke "bundle exec exe/emasser put controls help update" for additional help'.yellow
            exit
          else
            body.common_control_provider = options[:commonControlProvider]
            body.control_designation = options[:controlDesignation]
          end
        end
      end
      # rubocop:enable Style/CaseLikeIf, Style/StringLiterals, Style/NegatedIf

      # Add optional fields
      body.severity = options[:severity] if options[:severity]
      body.vulnerabilty_summary = options[:vulnerabiltySummary] if options[:vulnerabiltySummary]
      body.recommendations = options[:recommendations] if options[:recommendations]
      body.relevance_of_threat = options[:relevanceOfThreat] if options[:relevanceOfThreat]
      body.likelihood = options[:likelihood] if options[:likelihood]
      body.impact = options[:impact] if options[:impact]
      body.impact_description = options[:impactDescription] if options[:impactDescription]
      body.residual_risk_level = options[:residualRiskLevel] if options[:residualRiskLevel]

      body_array = Array.new(1, body)

      begin
        result = SwaggerClient::ControlsApi.new.update_control_by_system_id(body_array, options[:systemId])
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ControlsApi->update_control_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end
  # rubocop:enable Metrics/ClassLength, Style/WordArray

  # Update Plan of Action and Milestones (POA&M) items to a system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams                     - Update one or many poa&m items in a system
  #   /api/systems/{systemId}/poams/{poamId}/milestones - Update milestones in one or many poa&m items in a system
  # rubocop:disable Metrics/ClassLength
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
    #
    # If a POC email is supplied, the application will attempt to locate a user
    # already registered within the application and pre-populate any information
    # not explicitly supplied in the request. If no such user is found, these
    # fields are required within the request.
    # pocOrganization, pocFirstName, pocLastName, pocEmail, pocPhoneNumber

    desc 'update', 'Update one or many POA&M items in a system'
    long_desc Help.text(:poam_put_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :poamId,   type: :numeric, required: true, desc: 'A numeric value representing the poam identification'
    option :status,   type: :string, required: true, enum: ['Ongoing', 'Risk Accepted', 'Completed', 'Not Applicable']
    option :vulnerabilityDescription, type: :string, required: true, desc: 'POA&M vulnerability description'
    option :sourceIdentVuln,
           type: :string, required: true, desc: 'Source that identifies the vulnerability'
    option :pocOrganization, type: :string, required: true, desc: 'Organization/Office represented'

    # Conditional parameters/fields
    option :milestone,
           type: :hash, required: false, desc: 'key:values are: milestoneId, description and scheduledCompletionDate'
    option :pocFirstName, type: :string, required: false, desc: 'First name of POC'
    option :pocLastName, type: :string, required: false, desc: 'Last name of POC.'
    option :pocEmail, type: :string, required: false, desc: 'Email address of POC'
    option :pocPhoneNumber, type: :string, required: false, desc: 'Phone number of POC (area code) ***-**** format'
    option :severity, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :scheduledCompletionDate,
           type: :numeric, required: false, desc: 'The scheduled completion date - Unix time format'
    option :completionDate,
           type: :numeric, required: false, desc: 'The schedule completion date - Unix time format'
    option :comments, type: :string, required: false, desc: 'Comments for completed and risk accepted POA&M items'
    option :isActive, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    # Optional parameters/fields
    option :externalUid, type: :string, required: false, desc: 'External ID associated with the POA&M'
    option :controlAcronym, type: :string, required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :cci, type: :string, required: false, desc: 'The system CCIS string numerical value'
    option :securityChecks, type: :string, required: false, desc: 'Security Checks that are associated with the POA&M'
    option :rawSeverity, type: :string, required: false, enum: %w[I II III]
    option :resources, type: :string, required: false, desc: 'List of resources used'
    option :relevanceOfThreat,
           type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :likelihood, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :impact, type: :string, required: false, desc: 'Description of Security Control’s impact'
    option :impactDescription, type: :string, required: false, desc: 'Description of the security control impact'
    option :residualRiskLevel,
           type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :recommendations, type: :string, required: false, desc: 'Recomendations'
    option :mitigation, type: :string, required: false, desc: 'Mitigation explanation'

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def update
      # Required fields
      body = SwaggerClient::PoamRequiredPut.new
      body.poam_id = options[:poamId]
      body.status = options[:status]
      body.vulnerability_description = options[:vulnerabilityDescription]
      body.source_ident_vuln = options[:sourceIdentVuln]
      body.poc_organization = options[:pocOrganization]

      #-----------------------------------------------------------------------------
      # Conditional fields based on the status field values
      # "Risk Accepted"   comments, resources
      # "Ongoing"         scheduledCompletionDate, resources, milestones (at least 1)
      # "Completed"       scheduledCompletionDate, comments, resources,
      #                   completionDate, milestones (at least 1)
      # "Not Applicable"  POAM can not be created
      #-----------------------------------------------------------------------------
      # rubocop:disable Style/CaseLikeIf, Style/StringLiterals, Style/SoleNestedConditional
      if options[:status] == "Risk Accepted"
        if options[:comments].nil? || options[:resources].nil?
          puts 'Missing one of these parameters/fields:'.red
          puts 'comments, or resources'.red
          puts 'Invoke "bundle exec exe/emasser puu poams help update" for additional help'.yellow
          exit
        else
          body.comments = options[:comments]
          body.resources = options[:resources]
        end
      elsif options[:status] == "Ongoing"
        if options[:scheduledCompletionDate].nil? || options[:resources].nil? || options[:milestone].nil?
          puts 'Missing one of these parameters/fields:'.red
          puts 'milstoneScheduledCompletionDate, resources, or milestones'.red
          puts 'Invoke "bundle exec exe/emasser put poams help update" for additional help'.yellow
          exit
        else
          body.scheduled_completion_date = options[:scheduledCompletionDate]
          body.resources = options[:resources]

          milestone = SwaggerClient::MilestonesRequiredPut.new
          milestone.milestone_id = options[:milestone]["milestoneId"]
          milestone.description = options[:milestone]["description"]
          milestone.scheduled_completion_date = options[:milestone]["scheduledCompletionDate"]
          milestone_array = Array.new(1, milestone)
          body.milestones = milestone_array
        end
      elsif options[:status] == "Completed"
        if options[:scheduledCompletionDate].nil? || options[:comments].nil? ||
           options[:resources].nil? || options[:completionDate].nil? || options[:milestone].nil?
          puts 'Missing one of these parameters/fields:'.red
          puts 'scheduledCompletionDate, comments, resources, completionDate, or milestone'.red
          puts 'Invoke "bundle exec exe/emasser put poams help update" for additional help'.yellow
          exit
        else
          body.scheduled_completion_date = options[:scheduledCompletionDate]
          body.comments = options[:comments]
          body.resources = options[:resources]
          body.completion_date = options[:completionDate]

          milestone = SwaggerClient::MilestonesRequiredPut.new
          milestone.milestone_id = options[:milestone]["milestoneId"]
          milestone.description = options[:milestone]["description"]
          milestone.scheduled_completion_date = options[:milestone]["scheduledCompletionDate"]
          milestone_array = Array.new(1, milestone)
          body.milestones = milestone_array
        end
      end

      # If a POC email is given, then all POC information must be entered.
      if options[:pocEmail].nil?
        if options[:pocOrganization].nil? || options[:pocFirstName].nil? ||
           options[:pocLastName].nil? || options[:pocPhoneNumber].nil?
          puts 'Missing one of these parameters/fields:'.red
          puts 'pocOrganization, pocFirstName, pocLastName, or pocPhoneNumber'.red
          puts 'Invoke "bundle exec exe/emasser put poams help update" for additional help'.yellow
          exit
        end
      end
      # rubocop:enable Style/CaseLikeIf, Style/StringLiterals, Style/SoleNestedConditional

      # Add conditional fields
      body.poc_first_name = options[:pocFirstName] if options[:pocFirstName]
      body.poc_last_name = options[:pocLastName] if options[:pocLastName]
      body.poc_email = options[:pocEmail] if options[:pocEmail]
      body.poc_phone_number = options[:pocPhoneNumber] if options[:pocPhoneNumber]
      body.severity = options[:severity] if options[:severity]

      # Add optional fields
      body.external_uid = options[:externalUid] if options[:externalUid]
      body.control_acronym = options[:controlAcronym] if options[:controlAcronym]
      body.cci = options[:cci] if options[:cci]
      body.security_checks = options[:securityChecks] if options[:securityChecks]
      body.raw_severity = options[:rawSeverity] if options[:rawSeverity]
      body.relevance_of_threat = options[:relevanceOfThreat] if options[:relevanceOfThreat]
      body.likelihood = options[:likelihood] if options[:likelihood]
      body.impact = options[:impact] if options[:impact]
      body.impact_description = options[:impactDescription] if options[:impactDescription]
      body.residual_risk_level = options[:residualRiskLevel] if options[:residualRiskLevel]
      body.recommendations = options[:recommendations] if options[:recommendations]
      body.mitigation = options[:mitigation] if options[:mitigation]

      body_array = Array.new(1, body)

      begin
        result = SwaggerClient::POAMApi.new.update_poam_by_system_id(body_array, options[:systemId])
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling POAMApi->update_poam_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    # Update MILSTONES by SYSTEM and POAM ID ----------------------------------
    desc 'update_milestones', 'Update milestone(s) for given specified system and poam'
    long_desc Help.text(:milestone_put_mapper)

    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :poamId, type: :numeric, required: true, desc: 'A numeric value representing the poam identification'
    option :milestoneId,
           type: :numeric, required: true, desc: 'A numeric value representing the milestone identification'
    option :description, type: :string, required: true, desc: 'The milestone description'
    option :scheduledCompletionDate,
           type: :numeric, required: false, desc: 'The scheduled completion date - Unix time format'
    # Optional
    option :isActive, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def update_milestones
      body = SwaggerClient::MilestonesRequestPutBody.new
      body.milestone_id = options[:milestoneId]
      body.description = options[:description]
      body.scheduled_completion_date = options[:scheduledCompletionDate]
      body_array = Array.new(1, body)

      begin
        # Get milestones in one or many poa&m items in a system
        result = SwaggerClient::POAMApi
                 .new
                 .update_milestone_by_system_id_and_poam_id(body_array, options[:systemId], options[:poamId])
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling POAMApi->update_milestone_by_system_id_and_poam_id'.red
        puts to_output_hash(e)
      end
    end
  end
  # rubocop:enable Metrics/ClassLength

  # Update one or many artifacts for a system (this implementation only updates one artifact per each execution)
  #
  # Endpoint:
  #    /api/systems/{systemId}/artifacts - Put (update) one or many artifacts for a system
  class Artifacts < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'update', 'Updates artifacts for a system with provided entries'
    long_desc Help.text(:artifacts_put_mapper)

    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :filename, type: :string, required: true, desc: 'Artifact file name to be updated'
    option :type,
           type: :string, required: true,
           enum: ['Procedure', 'Diagram', 'Policy', 'Labor', 'Document',
                  'Image', 'Other', 'Scan Result', 'Auditor Report']
    option :category, type: :string, required: true, enum: ['Implementation Guidance', 'Evidence']
    option :isTemplate, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'
    # NOTE: compress is a required parameter, however Thor does not allow a boolean type to be required because it
    # automatically creates a --no-isTemplate option for isTemplate=false

    # Optional fields
    option :description, type: :string, required: false, desc: 'Artifact description'
    option :refPageNumber, type: :string, required: false, desc: 'Artifact reference page number'
    option :ccis, type: :string, required: false, desc: 'The system CCIs string numerical value'
    option :controls,
           type: :string, required: false,
           desc: 'Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined'
    option :artifactExpirationDate,
           type: :numeric, required: false, desc: 'Date Artifact expires and requires review - Unix time format'
    option :lastReviewedDate,
           type: :numeric, required: false, desc: 'Date Artifact was last reviewed - Unix time format'

    # rubocop:disable Metrics/CyclomaticComplexity
    def update
      body = SwaggerClient::ArtifactsRequestPutBody.new
      body.filename = options[:filename]
      body.type = options[:type]
      body.category = options[:category]
      body.is_template = options[:isTemplate]
      # Optional fields
      body.description = options[:description] if options[:description]
      body.ref_page_number = options[:refPageNumber] if options[:refPageNumber]
      body.ccis = options[:ccis] if options[:ccis]
      body.controls = options[:controls] if options[:controls]
      body.artifact_expiration_date = options[:artifactExpirationDate] if options[:artifactExpirationDate]
      body.last_reviewed_date = options[:lastReviewedDate] if options[:lastReviewedDate]

      body_array = Array.new(1, body)

      begin
        result = SwaggerClient::ArtifactsApi.new.update_artifact_by_system_id(body_array, options[:systemId])
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ArtifactsApi->update_artifact_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity
  end

  class Put < SubCommandBase
    desc 'controls', 'Update system Controls'
    subcommand 'controls', Controls

    desc 'poams', 'Update Plan of Action and Milestones (POA&M) items to a system'
    subcommand 'poams', Poams

    desc 'artifacts', 'Put system Artifacts'
    subcommand 'artifacts', Artifacts
  end
end
