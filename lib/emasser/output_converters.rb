# frozen_string_literal: true

module OutputConverters
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/TernaryParentheses
  # rubocop:disable Style/IfWithBooleanLiteralBranches, Style/RescueStandardError, Metrics/BlockNesting
  def to_output_hash(obj)
    diplay_nulls = (ENV.fetch('EMASSER_CLI_DISPLAY_NULL', 'true').eql? 'true') ? true : false

    if obj.to_s.include? 'Error message'
      begin
        index = obj.to_s.index('Response body')+14
        arr_obj = obj.to_s[index, obj.to_s.size - index]
        JSON.pretty_generate(JSON.parse(arr_obj))
      rescue
        obj
      end
    else
      obj = obj.to_body if obj.respond_to?(:to_body)
      if !diplay_nulls
        clean_obj = {}
        data_obj = {}
        obj.each do |key, value|
          if key.to_s.include?('meta')
            obj_entry = {}
            obj_entry[:meta] = value
            clean_obj.merge!(obj_entry)
          elsif key.to_s.include?('data')
            if value.is_a?(Array)
              hash_array = []
              value.each do |elements|
                hash_array << elements.compact
              end
              data_obj['data'] = hash_array
            else
              data_obj['data'] = value.nil? ? value : value.compact
            end
          elsif key.to_s.include?('pagination')
            pg_obj = {}
            pg_obj[:pagination] = value
            data_obj.merge!(pg_obj)
          end
          clean_obj.merge!(data_obj)
        end
        obj = clean_obj
      end
      JSON.pretty_generate(obj)
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/TernaryParentheses
  # rubocop:enable Style/IfWithBooleanLiteralBranches, Style/RescueStandardError, Metrics/BlockNesting
end
