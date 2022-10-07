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
  # Common static messages
  POAMS_POST_HELP_MESSAGE = "\nInvoke \"emasser post poams help add\" for additional help"
  SCAN_POST_HELP_MESSAGE = "\nInvoke \"emasser post scan_findings help clear\" for additional help"

  # The Registration endpoint provides the ability to register a certificate & obtain an API-key.
  #
  # Endpoint:
  #    /api/api-key - Register certificate and obtain API key
  class Register < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'cert', 'Register a certificate & obtain an API-key'
    # rubocop:disable Style/RedundantBegin
    def cert
      begin
        result = EmassClient::RegistrationApi.new.register_user({})
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling RegistrationApi->register_user'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Style/RedundantBegin
  end

  # The Test Results endpoints provide the ability to add test results for a
  # system's Assessment Procedures (CCIs) which determine Security Control compliance.
  #
  # Endpoint:
  #    /api/systems/{systemId}/test-results - Add one or many test results for a system
  class TestResults < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Post a test result for a system'
    long_desc Help.text(:testresults_post_mapper)

    # Required fields
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :cci,         type: :string,  required: true, desc: 'The system CCI string numerical value'
    option :testedBy,    type: :string,  required: true, desc: 'The person that conducted the test (Last Name, First)'
    option :testDate,    type: :numeric, required: true, desc: 'The date test was conducted, Unix time format.'
    option :description, type: :string,  required: true, desc: 'The description of test result. 4000 Characters.'
    option :complianceStatus, type: :string, required: true, enum: ['Compliant', 'Non-Compliant', 'Not Applicable']

    def add
      body = EmassClient::TestResultsGet.new
      body.cci = options[:cci]
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
  #   /api/systems/{systemId}/poams - Add one or many poa&m items in a system
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
    #
    # If a POC email is supplied, the application will attempt to locate a user
    # already registered within the application and pre-populate any information
    # not explicitly supplied in the request. If no such user is found, these
    # fields are required within the request:
    #     pocFirstName, pocLastName, pocPhoneNumber

    desc 'add', 'Add one or many POA&M items in a system'
    long_desc Help.text(:poam_post_mapper)

    # Required parameters/fields (the poamId and displayPoamId are generated by the PUT call)
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :status, type: :string, required: true, enum: ['Ongoing', 'Risk Accepted', 'Completed', 'Not Applicable']
    option :vulnerabilityDescription, type: :string, required: true, desc: 'POA&M vulnerability description'
    option :sourceIdentVuln,
           type: :string, required: true, desc: 'Source that identifies the vulnerability'
    option :pocOrganization, type: :string, required: true, desc: 'Organization/Office represented'
    option :resources, type: :string, required: true, desc: 'List of resources used'

    # Conditional parameters/fields
    option :milestone, type: :hash, required: false, desc: 'key:values are: description and scheduledCompletionDate'
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

    # Optional parameters/fields
    option :externalUid, type: :string, required: false, desc: 'External ID associated with the POA&M'
    option :controlAcronym, type: :string, required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :cci, type: :string, required: false, desc: 'The system CCIS string numerical value'
    option :securityChecks, type: :string, required: false, desc: 'Security Checks that are associated with the POA&M'
    option :rawSeverity, type: :string, required: false, enum: %w[I II III]
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
    def add
      # Required fields
      body = EmassClient::PoamGet.new
      body.status = options[:status]
      body.vulnerability_description = options[:vulnerabilityDescription]
      body.source_ident_vuln = options[:sourceIdentVuln]
      body.poc_organization = options[:pocOrganization]
      body.resources = options[:resources]

      process_business_logic(body)

      # Add conditional fields
      body.poc_first_name = options[:pocFirstName] if options[:pocFirstName]
      body.poc_last_name = options[:pocLastName] if options[:pocLastName]
      body.poc_email = options[:pocEmail] if options[:pocEmail]
      body.poc_phone_number = options[:pocPhoneNumber] if options[:pocPhoneNumber]
      body.severity = options[:severity] if options[:severity]

      # Add optional fields
      body.external_uid = options[:externalUid] if options[:externalUid]
      body.control_acronyms = options[:controlAcronym] if options[:controlAcronym]
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
        result = EmassClient::POAMApi.new.add_poam_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling POAMApi->add_poam_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    # rubocop:disable Metrics/BlockLength, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    no_commands do
      def process_business_logic(body)
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
          else
            body.comments = options[:comments]
          end
        elsif options[:status] == "Ongoing"
          if options[:scheduledCompletionDate].nil? || options[:milestone].nil?
            puts 'When status = "Ongoing" the following parameters/fields are required:'.red
            puts '    scheduledCompletionDate, milestone'.red
            print_milestone_help
            puts POAMS_POST_HELP_MESSAGE.yellow
            exit
          elsif options[:milestone]["description"].nil? || options[:milestone]["scheduledCompletionDate"].nil?
            puts 'Missing milstone parameters/fields'.red
            print_milestone_help
            exit
          else
            body.scheduled_completion_date = options[:scheduledCompletionDate]

            milestone = EmassClient::MilestonesRequiredPost.new
            milestone.description = options[:milestone]["description"]
            milestone.scheduled_completion_date = options[:milestone]["scheduledCompletionDate"]
            milestone_array = Array.new(1, milestone)
            body.milestones = milestone_array
          end
        elsif options[:status] == "Completed"
          if options[:scheduledCompletionDate].nil? || options[:comments].nil? ||
             options[:completionDate].nil? || options[:milestone].nil?
            puts 'When status = "Completed" the following parameters/fields are required:'.red
            puts '    scheduledCompletionDate, comments, completionDate, or milestone'.red
            print_milestone_help
            puts POAMS_POST_HELP_MESSAGE.yellow
            exit
          else
            body.scheduled_completion_date = options[:scheduledCompletionDate]
            body.comments = options[:comments]
            body.completion_date = options[:completionDate]

            milestone = EmassClient::MilestonesRequiredPost.new
            milestone.description = options[:milestone]["description"]
            milestone.scheduled_completion_date = options[:milestone]["scheduledCompletionDate"]
            milestone_array = Array.new(1, milestone)
            body.milestones = milestone_array
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
    # rubocop:enable Metrics/BlockLength, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end

  # The Milestones endpoints provide the ability add milestones that are associated with
  # Plan of Action and Milestones (POA&M) items for a system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams/{poamId}/milestones - Add milestones in one or many poa&m items in a system
  class Milestones < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Add milestones to one or many POA&M items in a system'
    long_desc Help.text(:milestone_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :poamId, type: :numeric, required: true, desc: 'A numeric value representing the poam identification'
    option :description, type: :string,  required: true, desc: 'The milestone description'
    option :scheduledCompletionDate,
           type: :numeric, required: true, desc: 'The scheduled completion date - Unix time format'

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

  # Add one or many artifacts for a system (delivery method must be a zip file)
  #
  # Endpoints:
  #    /api/systems/{systemId}/artifacts - Post one or many artifacts to a system
  class Artifacts < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'upload SYSTEM_ID FILE [FILE ...]', 'Uploads [FILES] to the given [SYSTEM_ID] as artifacts'
    long_desc Help.text(:artifacts_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :files, type: :array, required: true, desc: 'Artifact file(s) to post to the given system'
    option :type,
           type: :string, required: true,
           enum: ['Procedure', 'Diagram', 'Policy', 'Labor', 'Document',
                  'Image', 'Other', 'Scan Result', 'Auditor Report']
    option :category, type: :string, required: true, enum: ['Implementation Guidance', 'Evidence']
    option :isTemplate, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    # Optional parameters/fields
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

    def upload
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)
      # Remove the isTemplate as we can't use the required = true.
      optional_options.delete(:is_template)

      opts = {}
      opts[:type] = options[:type]
      opts[:category] = options[:category]
      opts[:is_template] = options[:is_template]
      opts[:form_params] = optional_options

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
        result = EmassClient::ArtifactsApi
                 .new
                 .add_artifacts_by_system_id(options[:systemId], tempfile, opts)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling ArtifactsApi->add_artifacts_by_system_id'.red
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

  # Add a Control Approval Chain (CAC)
  #
  # Endpoints:
  #    /api/systems/{systemId}/approval/cac - Submit control to second stage of CAC
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
  #    /api/systems/{systemId}/approval/pac - Initiate system workflow for review
  class PAC < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'add', 'Initiate system workflow for review'
    long_desc Help.text(:approvalPac_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :workflow, type: :string, required: true,
                      enum: ['Assess and Authorize', 'Assess Only', 'Security Plan Approval']
    option :name, type: :string, required: true, desc: 'The control package name'
    option :comments, type: :string, required: true,
                      desc: 'Comments submitted upon initiation of the indicated workflow'

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

      application_findings = EmassClient::StaticCodeApplication.new
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

      application_findings = EmassClient::StaticCodeApplication.new
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

  # The Cloud Resources endpoint provides the ability to upload (add)
  # cloud resources and their scan results in the assets module for a system.
  #
  #
  # Endpoint:
  #   /api/systems/{systemId}/cloud-resources-results - Upload cloud resources and their scan results
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
    # ComplianceResults Array Objects
    option :cspPolicyDefinitionId, type: :string, required: true, desc: 'Unique identifier/compliance namespace for CSP/Resource\'s policy definition/compliance check'
    option :isCompliant, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false'
    option :policyDefinitionTitle, type: :string, required: true, desc: 'Friendly policy/compliance check title. Recommend short title'

    # Optional parameter/fields
    option :initiatedBy, type: :string, required: false, desc: 'Email of POC'
    option :cspAccountId, type: :string, required: false, desc: 'System/owner\'s CSP account ID/number'
    option :cspRegion, type: :string, required: false, desc: 'CSP region of system'
    option :isBaseline, type: :boolean, required: false, default: true, desc: 'BOOLEAN - true or false'
    # Tags Object
    option :test, type: :string, required: false, desc: 'The test tag'
    # ComplianceResults Array Objects
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

      body[:tags] = tags
      body[:complianceResults] = compliance_results_array

      body_array = Array.new(1, body)

      begin
        result = EmassClient::CloudResourcesApi
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
  #   /api/systems/{systemId}/container-scan-results - Upload containers and their scan results
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
    # Benchmarks Array Objects
    option :benchmark, type: :string, required: true, desc: 'Identifier of the benchmark/grouping of compliance results'
    # Benchmarks.Results Array Objects
    option :lastSeen, type: :numeric, required: true, desc: 'Date last seen, Unix date format'
    option :ruleId, type: :string, required: true, desc: 'Identifier for the compliance result, vulnerability, etc. the result is for'
    option :status, type: :string, required: true, enum: ['Pass', 'Fail', 'Other', 'Not Reviewed', 'Not Checked', 'Not Applicable']

    # Optional parameter/fields
    option :namespace, type: :string, required: false, desc: 'Namespace of container in container orchestration'
    option :podIp, type: :string, required: false, desc: 'IP address of the pod'
    option :podName, type: :string, required: false, desc: 'Name of pod (e.g. Kubernetes pod)'
    # Tags Object
    option :test, type: :string, required: false, desc: 'The test tag'
    # Benchmarks Array Objects
    option :isBaseline, type: :boolean, required: false, default: true, desc: 'BOOLEAN - true or false'
    # Benchmarks.Results Array Objects
    option :message, type: :string, required: false, desc: 'Benchmark result comments'

    # rubocop:disable Metrics/CyclomaticComplexity
    def add
      # Required and Optional main fields
      body = {}
      body[:containerId] = options[:containerId]
      body[:containerName] = options[:containerName]
      body[:time] = options[:time]
      body[:namespace] = options[:namespace] if options[:namespace]
      body[:podIp] = options[:podIp] if options[:podIp]
      body[:podName] = options[:podName] if options[:podName]

      # Optional tags field
      tags = {}
      tags[:test] = options[:test] if options[:test]

      # Required and Optional Benchmarks fields
      benchmarks = {}
      benchmarks[:benchmark] = options[:benchmark]
      # Optional fields
      benchmarks[:isBaseline] = options[:isBaseline] if options[:isBaseline]

      # Required and Optional Benchmarks.Results
      benchmarks_results = {}
      benchmarks_results[:lastSeen] = options[:lastSeen]
      benchmarks_results[:ruleId] = options[:ruleId]
      benchmarks_results[:status] = options[:status]
      benchmarks_results[:message] = options[:message] if options[:message]

      # Add Benchmark results to an array and add array to benchmarks object
      benchmarks_results_array = Array.new(1, benchmarks_results)
      benchmarks[:results] = benchmarks_results_array # = Array.new(1, benchmarks_results)
      # Add benchmarks object to an array
      benchmarks_array = Array.new(1, benchmarks)
      # Add tags and benchmark ojects to body object
      body[:tags] = tags
      body[:benchmarks] = benchmarks_array

      body_array = Array.new(1, body)

      begin
        result = EmassClient::ContainersApi
                 .new.add_container_sans_by_system_id(options[:systemId], body_array)
        puts to_output_hash(result).green
      rescue EmassClient::ApiError => e
        puts 'Exception when calling StaticCodeScansApi->add_container_sans_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity
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

    desc 'scan_findings', 'Upload static code scans'
    subcommand 'scan_findings', ScanFindings

    desc 'cloud_resource', 'Upload cloud resource and their scan results'
    subcommand 'cloud_resource', CloudResource

    desc 'container', 'Upload container and their scan results'
    subcommand 'container', Container
  end
end
