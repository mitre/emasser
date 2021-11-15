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
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :cci,         type: :string,  required: true, desc: 'The system CCI string numerical value'
    option :testedBy,    type: :string,  required: true, desc: 'The person that conducted the test (Last Name, First)'
    option :testDate,    type: :numeric, required: true, desc: 'The date test was conducted, Unix time format.'
    option :description, type: :string,  required: true, desc: 'The description of test result. 4000 Characters.'
    option :complianceStatus, type: :string, required: true, enum: ['Compliant', 'Non-Compliant', 'Not Applicable']

    def add
      optional_options_keys = optional_options(@_initializer).keys
      optional_options = to_input_hash(optional_options_keys, options)

      body = SwaggerClient::TestResultsRequestBody.new
      body.cci = options[:cci]
      body.tested_by = options[:testedBy]
      body.test_date = options[:testDate]
      body.description = options[:description]
      body.compliance_status = options[:complianceStatus]

      # puts "body is: #{body}"
      body_array = Array.new(1, body)

      begin
        result = SwaggerClient::TestResultsApi
                 .new.add_test_results_by_system_id(body_array, options[:systemId], optional_options)
        puts to_output_hash(result)
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling TestResultsApi->add_test_results_by_system_id'
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
  class Poams < SubCommandBase
    def self.exit_on_failure?
      true
    end

    # POAM --------------------------------------------------------------------
    #
    # The following fields are required based on the contents of the status field
    # status          Required Fields (besides REQUIRED)
    # -------------------------------------------------------------------------
    # Risk Accepted   comments, resources
    # Ongoing         scheduledCompletionDate, resources, milestones (at least 1)
    # Completed       scheduledCompletionDate, comments, resources,
    #                 completionDate, milestones (at least 1)
    # Not Applicable  POAM can not be created
    desc 'add', 'Add one or many POA&M items in a system'
    option :systemId,                     type: :numeric,  required: true,
                                          desc: 'A numeric value representing the system identification'
    option :scheduledCompletionDateStart, type: :numeric,  required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd,   type: :numeric,  required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'
    option :controlAcronyms, type: :string,  required: false, desc: 'The system acronym(s) e.g "AC-1, AC-2"'
    option :ccis,            type: :string,  required: false, desc: 'The system CCIS string numerical value'
    option :systemOnly,      type: :boolean, required: false, default: false, desc: 'BOOLEAN - true or false.'

    def add
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
    desc 'add_milestones', 'Add milestone(s) for given specified system and poam'
    option :systemId, type: :numeric, required: true,
                      desc: 'A numeric value representing the system identification'
    option :poamId,   type: :numeric, required: true,
                      desc: 'A numeric value representing the poam identification'
    option :scheduledCompletionDateStart, type: :numeric,  required: false,
                                          desc: 'The schedule completion start date - Unix time format.'
    option :scheduledCompletionDateEnd,   type: :numeric,  required: false,
                                          desc: 'The scheduled completion end date - Unix time format.'

    def add_milestones
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

  class Post < SubCommandBase
    desc 'test_results', 'Add system Test Results'
    subcommand 'test_results', TestResults

    desc 'poams', 'Add Plan of Action and Milestones (POA&M) items to a system'
    subcommand 'poams', Poams

    desc 'artifacts', 'Add system Artifacts'
    subcommand 'artifacts', Artifacts
  end
end
