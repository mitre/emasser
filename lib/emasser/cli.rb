# frozen_string_literal: true

module Emasser
  class CLI < Thor
    include OutputConverters
    package_name 'Emasser'
    register(Emasser::Get, 'get', 'get [RESOURCE]', 'Gets a resource')

    def self.exit_on_failure?
      true
    end

    desc 'upload SYSTEM_ID FILE [FILE ...]', 'Uploads [FILES] to the given [SYSTEM_ID] as artifacts'
    def upload(systemid, *files)
      raise ArgumentError, 'SYSTEM_ID is required!' if systemid.empty?
      raise ArgumentError, 'At least one FILE is required!' if files.empty?

      tempfile = Tempfile.create(['artifacts', '.zip'])

      Zip::OutputStream.open(tempfile.path) do |z|
        files.each do |file|
          # Add file name to the archive: Don't use the full path
          z.put_next_entry(File.basename(file))
          # Add the file content to the archive
          z.print File.read(file)
        end
      end

      begin
        result = SwaggerClient::ArtifactsApi.new.add_artifacts_by_system_id(tempfile, systemid)
        puts to_output_hash(result)
      rescue SwaggerClient::ApiError => e
        puts 'Exception when calling ArtifactsApi->add_artifacts_by_system_id'
        puts to_output_hash(e)
      ensure
        # Delete the temp file
        if File.exist? tempfile
          tempfile.close
          FileUtils.remove_file(tempfile, true)
        end
      end
    end
  end
end
