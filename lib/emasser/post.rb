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
      "exe/#{basename} #{command.formatted_usage(self, $thor_runner, subcommand)}"
    else
      "exe/#{basename} post #{command.formatted_usage(self, $thor_runner, subcommand)}"
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
  # The Test Result endpoints provide the ability to add test results for a system's DoD
  # Assessment Procedures (CCIs) which determines NIST SP 80-53 Revision 4 Security
  # Control Compliance (Compliant, Non-Compliant, Not Applicable). The endpoints also
  # provide the ability to retrieve test results.
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
      body = SwaggerClient::TestResultsRequestPostBody.new
      body.cci = options[:cci]
      body.tested_by = options[:testedBy]
      body.test_date = options[:testDate]
      body.description = options[:description]
      body.compliance_status = options[:complianceStatus]

      # puts "body is: #{body}"
      body_array = Array.new(1, body)

      begin
        result = SwaggerClient::TestResultsApi
                 .new.add_test_results_by_system_id(body_array, options[:systemId])
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling TestResultsApi->add_test_results_by_system_id'.red
        puts to_output_hash(e)
      end
    end
  end

  # The POA&M endpoints provide the ability to add Plan of Action and Milestones (POA&M)
  # items to a system.
  #
  # Endpoint:
  #   /api/systems/{systemId}/poams                     - Add one or many poa&m items in a system
  #   /api/systems/{systemId}/poams/{poamId}/milestones - Add milestones in one or many poa&m items in a system
  # rubocop:disable Metrics/ClassLength
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
    # fields are required within the request.
    # pocOrganization, pocFirstName, pocLastName, pocEmail, pocPhoneNumber

    desc 'add', 'Add one or many POA&M items in a system'
    long_desc Help.text(:poam_post_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :status, type: :string, required: true, enum: ['Ongoing', 'Risk Accepted', 'Completed', 'Not Applicable']
    option :vulnerabilityDescription, type: :string, require: true, desc: 'POA&M vulnerability description'
    option :sourceIdentVuln,
           type: :string, require: true, desc: 'Source that identifies the vulnerability'
    option :reviewStatus, type: :string, required: false, enum: ['Not Approved', 'Under Review', 'Approved']

    # Conditional parameters/fields
    option :milestone, type: :hash, required: false, desc: 'key:values are: description and scheduledCompletionDate'
    option :pocOrganization, type: :string, require: false, desc: 'Organization/Office represented'
    option :pocFirstName, type: :string, require: false, desc: 'First name of POC'
    option :pocLastName, type: :string, require: false, desc: 'Last name of POC.'
    option :pocEmail, type: :string, require: false, desc: 'Email address of POC'
    option :pocPhoneNumber, type: :string, require: false, desc: 'Phone number of POC (area code) ***-**** format'
    option :severity, type: :string, required: false, enum: ['Very Low', 'Low', 'Moderate', 'High', 'Very High']
    option :scheduledCompletionDate,
           type: :numeric, required: false, desc: 'The scheduled completion date - Unix time format'
    option :completionDate,
           type: :numeric, required: false, desc: 'The schedule completion date - Unix time format'
    option :comments, type: :string, require: false, desc: 'Comments for completed and risk accepted POA&M items'
    option :isActive, type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    # Optional parameters/fields
    option :externalUid, type: :string, require: false, desc: 'External ID associated with the POA&M'
    option :controlAcronym, type: :string, require: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :cci, type: :string, require: false, desc: 'The system CCIS string numerical value'
    option :securityChecks, type: :string, require: false, desc: 'Security Checks that are associated with the POA&M'
    option :rawSeverity, type: :string, required: false, enum: %w[I II III]
    option :resources, type: :string, require: false, desc: 'List of resources used'
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
      body = SwaggerClient::PoamRequiredPost.new
      body.status = options[:status]
      body.vulnerability_description = options[:vulnerabilityDescription]
      body.source_ident_vuln = options[:sourceIdentVuln]
      body.review_status = options[:reviewStatus]

      # Conditional fields based on the status field values
      # Risk Accepted   comments, resources
      # Ongoing         scheduledCompletionDate, resources, milestones (at least 1)
      # Completed       scheduledCompletionDate, comments, resources,
      #                 completionDate, milestones (at least 1)
      # Not Applicable  POAM can not be created
      # rubocop:disable Style/CaseLikeIf, Style/StringLiterals
      if options[:status] == "Risk Accepted"
        if options[:comments].nil? || options[:resources].nil?
          puts 'Missing one of these parameters/fields:'.red
          puts 'comments, or resources'.red
          puts 'Invoke "bundle exec exe/emasser post poams help add" for additional help'.yellow
          exit
        else
          body.comments = options[:comments]
          body.resources = options[:resources]
        end
      elsif options[:status] == "Ongoing"
        if options[:scheduledCompletionDate].nil? || options[:resources].nil? || options[:milestone].nil?
          puts 'Missing one of these parameters/fields:'.red
          puts 'milstoneScheduledCompletionDate, resources, or milestones'.red
          puts 'Invoke "bundle exec exe/emasser post poams help add" for additional help'.yellow
          exit
        else
          body.scheduled_completion_date = options[:scheduledCompletionDate]
          body.resources = options[:resources]

          milestone = SwaggerClient::MilestonesRequiredPost.new
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
          puts 'Invoke "bundle exec exe/emasser post poams help add" for additional help'.yellow
          exit
        else
          body.scheduled_completion_date = options[:scheduledCompletionDate]
          body.comments = options[:comments]
          body.resources = options[:resources]
          body.completion_date = options[:completionDate]

          milestone = SwaggerClient::MilestonesRequiredPost.new
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
          puts 'Invoke "bundle exec exe/emasser post poams help add" for additional help'.yellow
          exit
        end
      elsif options[:pocLastName]
        if options[:pocFirstName].nil? || options[:pocEmail].nil? || options[:pocPhoneNumber].nil?
          puts 'If a POC last name is given, then all POC information must be entered:'.red
          puts '    pocFirstName, pocEmail, pocPhoneNumber'.red
          puts 'Invoke "bundle exec exe/emasser post poams help add" for additional help'.yellow
          exit
        end
      elsif options[:pocEmail]
        if options[:pocFirstName].nil? || options[:pocLastName].nil? || options[:pocPhoneNumber].nil?
          puts 'If a POC email is given, then all POC information must be entered:'.red
          puts '    pocFirstName, pocLastName, pocPhoneNumber'.red
          puts 'Invoke "bundle exec exe/emasser post poams help add" for additional help'.yellow
          exit
        end
      elsif options[:pocPhoneNumber]
        if options[:pocFirstName].nil? || options[:pocLastName].nil? || options[:pocEmail].nil?
          puts 'If a POC phone number is given, then all POC information must be entered:'.red
          puts '    pocFirstName, pocLastName, pocEmail'.red
          puts 'Invoke "bundle exec exe/emasser post poams help add" for additional help'.yellow
          exit
        end
      end
      # rubocop:enable Style/CaseLikeIf, Style/StringLiterals

      # Add conditional fields
      body.poc_organization = options[:pocOrganization] if options[:pocOrganization]
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
        result = SwaggerClient::POAMApi.new.add_poam_by_system_id(body_array, options[:systemId])
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling POAMApi->add_poam_by_system_id'.red
        puts to_output_hash(e)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    # MILSTONES by SYSTEM and POAM ID -----------------------------------------
    desc 'add_milestones', 'Add milestone(s) for given specified system and poam'
    long_desc Help.text(:milestone_put_mapper)

    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :poamId, type: :numeric, required: true, desc: 'A numeric value representing the poam identification'
    option :description, type: :string,  required: true, desc: 'The milestone description'
    option :scheduledCompletionDate,
           type: :numeric, required: false, desc: 'The scheduled completion date - Unix time format'

    def add_milestones
      body = SwaggerClient::MilestonesRequestPostBody.new
      body.poam_id = options[:poamId]
      body.description = options[:description]
      body.scheduled_completion_date = options[:scheduledCompletionDate]
      body_array = Array.new(1, body)

      begin
        result = SwaggerClient::POAMApi
                 .new.add_milestone_by_system_id_and_poam_id(body_array, options[:systemId], options[:poamId])
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling POAMApi->add_milestone_by_system_id_and_poam_id'.red
        puts to_output_hash(e)
      end
    end
  end
  # rubocop:enable Metrics/ClassLength

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

    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :files, type: :array, required: true, desc: 'Artifact file(s) to post to the given system'
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
    option :ccis, type: :string, require: false, desc: 'The system CCIs string numerical value'
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
        result = SwaggerClient::ArtifactsApi
                 .new
                 .add_artifacts_by_system_id(options[:isTemplate], options[:type],
                                             options[:category], tempfile, options[:systemId], opts)
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
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

  # Add a Control Approval Chain (CAC) or a Package Approval Chain (PAC)
  #
  # Endpoints:
  #    /api/systems/{systemId}/approval/cac - Add location of one or many controls in CAC
  #    /api/systems/{systemId}/approval/pac - Add location of system package in PAC
  class Approval < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'cac', 'Get all system CAC for a system Id'
    long_desc Help.text(:approvalCac_post_mapper)

    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :controlAcronym, type: :string, required: true, desc: 'The system acronym "AC-1, AC-2"'
    option :comments, type: :string, require: false, desc: 'The control approval chain comments'

    def cac
      body = SwaggerClient::ApprovalCacRequestPostBody.new
      body.control_acronym = options[:controlAcronym]
      body.comments = options[:comments]

      body_array = Array.new(1, body)

      begin
        # Get location of one or many controls in CAC
        result = SwaggerClient::ApprovalChainApi.new.add_c_ac_approval_chain_by_system_id(body_array,
                                                                                          options[:systemId])
        puts to_output_hash(result).green
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ApprovalChainApi->add_c_ac_approval_chain_by_system_id'.red
        puts to_output_hash(e)
      end
    end

    desc 'pac', 'Get all system PAC for a system Id'
    long_desc Help.text(:approvalPac_post_mapper)

    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :name, type: :string, require: false, desc: 'The control package name'
    option :type, type: :string, required: true,
                  enum: ['Assess and Authorize', 'Assess Only', 'Security Plan Approval']
    option :comments, type: :string, require: false, desc: 'The control package approval chain comments'

    def pac
      body = SwaggerClient::ApprovalPacRequestBodyPost.new
      body.name = options[:name]
      body.type = options[:type]
      body.comments = options[:comments]

      body_array = Array.new(1, body)

      result = SwaggerClient::ApprovalChainApi.new.add_pac_approval_chain_by_system_id(body_array, options[:systemId])
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling ApprovalChainApi->add_pac_approval_chain_by_system_id'.red
      puts to_output_hash(e)
    end
  end

  class Post < SubCommandBase
    desc 'test_results', 'Add system Test Results'
    subcommand 'test_results', TestResults

    desc 'poams', 'Add Plan of Action and Milestones (POA&M) items to a system'
    subcommand 'poams', Poams

    desc 'artifacts', 'Add system Artifacts'
    subcommand 'artifacts', Artifacts

    desc 'approval', 'Add Controls or Packages (CAC/PAC) security content'
    subcommand 'approval', Approval
  end
end
