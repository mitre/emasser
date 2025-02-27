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
      "#{basename} #{command.formatted_usage(self, $thor_runner, subcommand)}"
    else
      "#{basename} delete #{command.formatted_usage(self, $thor_runner, subcommand)}"
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
    desc 'remove', 'Delete one or many POA&M items in a system'
    long_desc Help.text(:poam_del_mapper)

    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :poamId, aliases: '-p', type: :numeric, required: true, desc: 'A numeric value representing the poam identification'

    def remove
      body = EmassClient::PoamRequestDeleteBodyInner.new
      body.poam_id = options[:poamId]
      body_array = Array.new(1, body)

      result = EmassClient::POAMApi.new.delete_poam(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
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
    option :systemId, aliases: '-s', type: :numeric, required: true,
                         desc: 'A numeric value representing the system identification'
    option :poamId, aliases: '-p', type: :numeric, required: true,
                         desc: 'A numeric value representing the poam identification'
    option :milestoneId, aliases: '-m', type: :numeric, required: true,
                         desc: 'A numeric value representing the milestone identification'

    def remove
      body = EmassClient::MilestonesRequestDeleteBodyInner.new
      body.milestone_id = options[:milestoneId]
      body_array = Array.new(1, body)

      result = EmassClient::MilestonesApi.new.delete_milestone(options[:systemId], options[:poamId], body_array)
      # The server returns an empty object upon successfully deleting a milestone.
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
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

    desc 'remove', 'Delete one or many artifacts in a system'
    long_desc Help.text(:artifacts_del_mapper)

    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :files, aliases: '-f', type: :array, required: true, desc: 'Artifact file(s) to remove from the given system'

    def remove
      body_array = []
      options[:files].each do |file|
        obj = {}
        obj[:filename] = file
        body_array << obj
      end

      result = EmassClient::ArtifactsApi.new.delete_artifact(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ArtifactsApi->delete_artifact'.red
      puts to_output_hash(e)
    end
  end

  # Remove one or many hardware assets in a system
  #
  # Endpoint:
  #    /api/systems/{systemId}/hw-baseline
  class Hardware < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'remove', 'Delete one or many hardware assets in a system'

    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :hardwareIds, aliases: '-w', type: :array, required: true, desc: 'GUID identifying the specific hardware asset'

    def remove
      body_array = []
      options[:hardwareIds].each do |hardware|
        obj = {}
        obj[:hardwareId] = hardware
        body_array << obj
      end

      result = EmassClient::HardwareBaselineApi.new.delete_hw_baseline_assets(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling HardwareBaselineApi->delete_hw_baseline_assets'.red
      puts to_output_hash(e)
    end
  end

  # Remove one or many software assets in a system
  #
  # Endpoint:
  #    /api/systems/{systemId}/sw-baseline
  class Software < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'remove', 'Delete one or many software assets in a system'

    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :softwareIds, aliases: '-w', type: :array, required: true, desc: 'GUID identifying the specific software asset'

    def remove
      body_array = []
      options[:softwareIds].each do |software|
        obj = {}
        obj[:softwareId] = software
        body_array << obj
      end

      result = EmassClient::SoftwareBaselineApi.new.delete_sw_baseline_assets(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling SoftwareBaselineApi->delete_sw_baseline_assets'.red
      puts to_output_hash(e)
    end
  end

  # The Cloud Resource Results endpoint provides the ability to remove
  # cloud resources and their scan results in the assets module for a system.
  #
  # Endpoint:
  #  /api/systems/{systemId}/cloud-resource-results
  class CloudResource < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'remove', 'Delete one or many Cloud Resources and their scan results in the assets module for a system'

    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :resourceId, aliases: '-r', type: :string, required: true, desc: 'Unique identifier/resource namespace for policy compliance result'

    def remove
      body = EmassClient::CloudResourcesDeleteBodyInner.new
      body.resource_id = options[:resourceId]
      body_array = Array.new(1, body)

      result = EmassClient::CloudResourceResultsApi.new.delete_cloud_resources(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling CloudResourceResultsApi->delete_cloud_resources'.red
      puts to_output_hash(e)
    end
  end

  # The Container Scan Results endpoint provides the ability to remove
  # containers and their scan results in the assets module for a system.
  #
  # Endpoint:
  #  /api/systems/{systemId}/container-scan-results
  class Container < SubCommandBase
    def self.exit_on_failure?
      true
    end

    desc 'remove', 'Delete one or many containers scan results in the assets module for a system'

    # Required parameters/fields
    option :systemId, aliases: '-s', type: :numeric, required: true, desc: 'A numeric value representing the system identification'
    option :containerId, aliases: '-c', type: :string, required: true, desc: 'Unique identifier of the container'

    def remove
      body = EmassClient::ContainerResourcesDeleteBodyInner.new
      body.container_id = options[:containerId]
      body_array = Array.new(1, body)

      result = EmassClient::ContainerScanResultsApi.new.delete_container_sans(options[:systemId], body_array)
      puts to_output_hash(result).green
    rescue EmassClient::ApiError => e
      puts 'Exception when calling ContainerScanResultsApi->delete_container_sans'.red
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

    desc 'hardware', 'Delete one or many hardware assets to a system'
    subcommand 'hardware', Hardware

    desc 'software', 'Delete one or many software assets to a system'
    subcommand 'software', Software

    desc 'cloud_resource', 'Delete cloud resource and their scan results'
    subcommand 'cloud_resource', CloudResource

    desc 'container', 'Delete container and their scan results'
    subcommand 'container', Container
  end
end
