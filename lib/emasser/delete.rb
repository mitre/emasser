# frozen_string_literal: true

# Hack class that properly formats the CLI help
class SubCommandBase < Thor
  # include OptionsParser
  # include InputConverters
  include OutputConverters

  # We do not control the method declaration for the banner

  # rubocop:disable Style/OptionalBooleanParameter
  def self.banner(command, _namespace = nil, subcommand = false)
    # Use the $thor_runner (declared by the Thor CLI framework)
    # to properly format the help text of sub-sub-commands.

    # rubocop:disable Style/GlobalVars
    if ancestors[0].to_s.include? '::Del'
      "exe/#{basename} #{command.formatted_usage(self, $thor_runner, subcommand)}"
    else
      "exe/#{basename} delete #{command.formatted_usage(self, $thor_runner, subcommand)}"
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
  # Remove one or more POA&M from a system
  #
  # Endpoint:
  #  /api/systems/{systemId}/poams - Remove one or many poa&m items in a system
  class Poams < SubCommandBase
    def self.exit_on_failure?
      true
    end

    # Delete a POAM -----------------------------------------------------------
    desc 'remove', 'Add one or many POA&M items in a system'
    long_desc Help.text(:poam_del_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :poamId,   type: :numeric, required: true, desc: 'A numeric value representing the poam identification'

    def remove
      body = SwaggerClient::DeletePoam.new
      body.poam_id = options[:poamId]
      body_array = Array.new(1, body)

      result = SwaggerClient::POAMApi.new.delete_poam(body_array, options[:systemId])
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling POAMApi->delete_poam'.red
      puts to_output_hash(e)
    end
  end

  # Remove one or more Milestones from a system for a POA
  #
  # Endpoint:
    #  /api/systems/{systemId}/poam/{poamId}/milestones - Remove milestones in a system for one or many poa&m items
  class Milestones < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'remove', 'Delete one or many POA&M MILSTONES in a system'
    long_desc Help.text(:milestone_del_mapper)

    # Required parameters/fields
    option :systemId,    type: :numeric, required: true,
                         desc: 'A numeric value representing the system identification'
    option :poamId,      type: :numeric, required: true,
                         desc: 'A numeric value representing the poam identification'
    option :milestoneId, type: :numeric, required: true,
                         desc: 'A numeric value representing the milestone identification'

    def remove
      body = SwaggerClient::DeleteMilestone.new
      body.milestone_id = options[:milestoneId]
      body_array = Array.new(1, body)

      result = SwaggerClient::MilestonesApi.new.delete_milestone(body_array, options[:systemId], options[:poamId])
      # The server returns an empty object upon successfully deleting a milestone.
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling MilestonesApi->delete_milestone'.red
      puts to_output_hash(e)
    end
  end

  # Remove one or many artifacts in a system
  #
  # Endpoint:
  #    /api/systems/{systemId}/artifacts - Delete one or more artifacts (files) from a system
  class Artifacts < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'remove', 'Remove one or many artifacts in a system'
    long_desc Help.text(:artifact_del_mapper)

    # Required parameters/fields
    option :systemId, type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :files, type: :array, required: true, desc: 'Artifact file(s) to remove from the given system'

    def remove
      body_array = []
      options[:files].each do |file|
        obj = {}
        obj[:filename] = file
        body_array << obj
      end

      result = SwaggerClient::ArtifactsApi.new.delete_artifact(body_array, options[:systemId])
      puts to_output_hash(result).green
    rescue SwaggerClient::ApiError => e
      puts 'Exception when calling ArtifactsApi->delete_artifact'.red
      puts to_output_hash(e)
    end
  end

  class Delete < SubCommandBase
    desc 'poams', 'Delete Plan of Action and Milestones (POA&M) items for a system'
    subcommand 'poams', Poams

    desc 'milestones', 'Delete Milestones from a Plan of Action ffrom a system'
    subcommand 'milestones', Milestones

    desc 'artifacts', 'Delete system Artifacts'
    subcommand 'artifacts', Artifacts
  end
end
