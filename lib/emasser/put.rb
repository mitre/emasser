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
    if ancestors[0].to_s.include? '::Put'
      "exe/#{basename} #{command.formatted_usage(self, $thor_runner, subcommand)}"
    else
      "exe/#{basename} put #{command.formatted_usage(self, $thor_runner, subcommand)}"
    end
    # rubocop:enable Style/GlobalVars
  end
  # rubocop:enable Style/OptionalBooleanParameter
end

module Emasser
  # The PUT Controls endpoint provides the ability to update Security Control information of a
  # system for both the Implementation Plan and Risk Assessment.
  #
  # Endpoint:
  #    /api/systems/{systemId}/controls - Update control information in a system for one or many controls
  # rubocop:disable Metrics/ClassLength, Style/WordArray
  class Controls < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'update', 'Get control information in a system for one or many controls (acronym)'
    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :acronym,  type: :string,  required: true, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :responsibleEntities, type: :string, required: true,
                                 desc: 'Description of Responsible Entities that \
                                        are responsible for the Security Control'
    option :controlDesignation,      type: :string, required: true, enum: ['Common', 'System-Specific', 'Hybrid']
    option :estimatedCompletionDate, type: :numeric, required: true, desc: 'Estimated completion date, Unix time format'
    option :comments,                type: :string, required: true, desc: 'Security control comments'
    # Conditional parameters/fields
    option :commonControlProvider
    option :naJustification
    option :slcmCriticality
    option :slcmFrequency
    option :slcmMethod
    option :slcmReporting
    option :slcmTracking
    option :slcmComments

    # Optional parameters/fields
    option :implementationStatus
    option :severity
    option :vulnerabiltySummary
    option :recommendations
    option :relevanceOfThreat
    option :likelihood
    option :impact
    option :impactDescription
    option :residualRiskLevel

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def update
      # Required fields
      body = SwaggerClient::ControlsRequestBody.new
      body.acronym = options[:acronym]
      body.responsible_entities = options[:responsibleEntities]
      body.control_designation = options[:controlDesignation]
      body.estimated_completion_date = options[:estimatedCompletionDate]
      body.comments = options[:comments]

      # Conditional fields based on implementationStatus content
      # rubocop:disable Style/CaseLikeIf, Style/NegatedIf, Style/StringLiterals
      if !options[:implementationStatus].nil?
        body.implementation_status = options[:implementationStatus]

        if options[:implementationStatus] == "Planned" || options[:implementationStatus] == "Implemented"
          if options[:controlDesignation].nil? || options[:estimatedCompletionDate].nil? ||
             options[:responsibleEntities].nil? || options[:slcmCriticality].nil? ||
             options[:slcmFrequency].nil? || options[:slcmMethod].nil? ||
             options[:slcmReporting].nil? || options[:slcmTracking].nil? ||
             options[:slcmComments].nil?

            puts 'Missing one of these parameters/fields:'
            puts 'controlDesignation, estimatedCompletionDate, responsibleEntities,
                  slcmCriticality, slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments'
            exit
          else
            body.control_designation = option[:controlDesignation]
            body.estimated_completion_date = options[:estimatedCompletionDate]
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
            puts 'Missing one of these parameters/fields:'
            puts 'controlDesignation, naJustification, responsibleEntities'
            exit
          else
            body.control_designation = option[:controlDesignation]
            body.slcm_reporting = options[:naJustification]
            body.responsible_entities = options[:responsibleEntities]
          end
        elsif options[:implementationStatus] == 'Manually Inherited'
          if options[:commonControlProvider].nil? || options[:controlDesignation].nil? ||
             options[:estimatedCompletionDate].nil? || options[:responsibleEntities].nil? ||
             options[:slcmCriticality].nil? || options[:slcmFrequency].nil? ||
             options[:slcmMethod].nil? || options[:slcmReporting].nil? ||
             options[:slcmTracking].nil? || options[:slcmComments].nil?

            puts 'Missing one of these parameters/fields:'
            puts 'commonControlProvider, controlDesignation, estimatedCompletionDate, responsibleEntities,
                  slcmCriticality, slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments'
            exit
          else
            body.common_control_provider = options[:commonControlProvider]
            body.control_designation = options[:controlDesignation]
            body.estimated_completion_date = options[:estimatedCompletionDate]
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
            puts 'Missing one of these parameters/fields:'
            puts 'commonControlProvider, controlDesignation'
            exit
          else
            body.common_control_provider = options[:commonControlProvider]
            body.control_designation = options[:controlDesignation]
          end
        end
      end
      # rubocop:enable Style/CaseLikeIf, Style/StringLiterals

      # Add optional fields
      # rubocop:disable Style/IfUnlessModifier
      if !options[:severity].nil? then body.implementation_status = options[:severity] end
      if !options[:vulnerabiltySummary].nil? then body.vulnerabilty_summary = options[:vulnerabiltySummary] end
      if !options[:recommendations].nil? then body.recommendations = options[:recommendations] end
      if !options[:relevanceOfThreat].nil? then body.relevance_of_threat = options[:relevanceOfThreat] end
      if !options[:likelihood].nil? then body.likelihood = options[:likelihood] end
      if !options[:impact].nil? then body.impact = options[:impact] end
      if !options[:impactDescription].nil? then body.impact_description = options[:impactDescription] end
      if !options[:residualRiskLevel].nil? then body.residual_risk_level = options[:residualRiskLevel] end
      # rubocop:enable Style/IfUnlessModifier, Style/NegatedIf

      body_array = Array.new(1, body)

      begin
        result = SwaggerClient::ControlsApi.new.update_control_by_system_id(body_array, options[:systemId])
        puts to_output_hash(result)
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ControlsApi->update_control_by_system_id'
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end
  # rubocop:enable Metrics/ClassLength, Style/WordArray

  # The POA&M endpoints provide the ability to update Plan of Action and Milestones (POA&M)
  # items to a system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams                     - Update one or many poa&m items in a system
  #   /api/systems/{systemId}/poams/{poamId}/milestones - Update milestones in one or many poa&m items in a system
  class Poams < SubCommandBase
    def self.exit_on_failure?
      true
    end

    # SYSTEM ------------------------------------------------------------------
    desc 'update', 'Update one or many POA&M items in a system'
    option :systemId,                     type: :numeric,  required: true,
                                          desc: 'A numeric value representing the system identification'
    option :scheduledCompletionDateStart, type: :numeric,  required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd,   type: :numeric,  required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'
    option :controlAcronyms, type: :string,  required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :ccis,            type: :string,  required: false, desc: 'The system CCIS string numerical value'
    option :systemOnly,      type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def update
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        result = SwaggerClient::POAMApi.new.api_systems_system_id_poams_get(options[:systemId], optional_options)
        puts to_output_hash(result)
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling POAMApi->api_systems_system_id_poams_get'
        puts to_output_hash(e)
      end
    end

    # MILSTONES by SYSTEM and POAM ID -----------------------------------------
    desc 'update_milestones', 'Update milestone(s) for given specified system and poam'
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :poamId,   type: :numeric, required: true,
                      desc: 'A numeric value representing the poam identification'
    option :scheduledCompletionDateStart, type: :numeric,  required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd,   type: :numeric,  required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'

    def update_milestones
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      begin
        # Get milestones in one or many poa&m items in a system
        result = SwaggerClient::POAMApi.new.get_milestones_by_system_id_and_poam_id(options[:systemId],
                                                                                    options[:poamId], optional_options)
        puts to_output_hash(result)
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling POAMApi->get_milestones_by_system_id_and_poam_id'
        puts to_output_hash(e)
      end
    end
  end

  # The Artifact endpoints provide the ability to add new Artifacts
  # (supporting documentation/evidence for Security Control Assessments
  # and system Authorization activities) to a system.
  #
  # Endpoints:
  #    /api/systems/{systemId}/artifacts - Post one or many artifacts to a system
  class Artifacts < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'upload SYSTEM_ID FILE [FILE ...]', 'Uploads [FILES] to the given [SYSTEM_ID] as artifacts'
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :files, type: :array, required: true, desc: 'Artifact file(s) to post to the given system'

    def upload
      tempfile = Tempfile.create(['artifacts', '.zip'])

      Zip::OutputStream.open(tempfile.path) do |z|
        options[:files].each do |file|
          # Add file name to the archive: Don't use the full path
          z.put_next_entry(File.basename(file))
          # Add the file to the archive
          z.print File.read(file)
        end
      end

      begin
        result = SwaggerClient::ArtifactsApi.new.add_artifacts_by_system_id(tempfile, options[:systemId])
        puts to_output_hash(result)
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ArtifactsApi->add_artifacts_by_system_id'
        puts to_output_hash(e)
      ensure
        # Delete the temp file
        unless File.exist? tempfile
          tempfile.close
          FileUtils.remove_file(tempfile, true)
        end
      end
    end
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
