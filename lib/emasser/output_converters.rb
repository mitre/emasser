# frozen_string_literal: true

module OutputConverters
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/TernaryParentheses
  # rubocop:disable Style/IfWithBooleanLiteralBranches, Style/RescueStandardError, Metrics/BlockNesting, Style/RedundantCondition
  def to_output_hash(obj)
    diplay_nulls = (ENV.fetch('EMASSER_CLI_DISPLAY_NULL', 'true').eql? 'true') ? true : false
    diplay_datetime = (ENV.fetch('EMASSER_EPOCH_TO_DATETIME', 'false').eql? 'true') ? true : false

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
        begin
          obj.each do |key, value|
            if key.to_s.include?('meta')
              obj_entry = {}
              obj_entry[:meta] = value
              clean_obj.merge!(obj_entry)
            elsif key.to_s.include?('data')
              if value.is_a?(Array)
                hash_array = []
                value.map do |elements|
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
        rescue
          obj
        end
      end

      if diplay_datetime
        clean_obj = {}
        data_obj = {}
        begin
          obj.each do |key, value|
            if key.to_s.include?('meta')
              obj_entry = {}
              obj_entry[:meta] = value
              clean_obj.merge!(obj_entry)
            elsif key.to_s.include?('data')
              if value.is_a?(Array)
                hash_array = []
                value.each do |element|
                  datetime_obj = change_to_datetime(element)
                  hash_array << datetime_obj
                end
                data_obj['data'] = hash_array
              else
                data_obj['data'] = change_to_datetime(value)
              end
            elsif key.to_s.include?('pagination')
              pg_obj = {}
              pg_obj[:pagination] = value
              data_obj.merge!(pg_obj)
            end
            clean_obj.merge!(data_obj)
          end
          obj = clean_obj
        rescue
          obj
        end
      end
      JSON.pretty_generate(obj)
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/TernaryParentheses
  # rubocop:enable Style/IfWithBooleanLiteralBranches, Style/RescueStandardError, Metrics/BlockNesting, Style/RedundantCondition

  # rubocop:disable Style/RedundantReturn
  # rubocop:disable Style/IdenticalConditionalBranches
  # rubocop:disable Metrics/BlockNesting, Style/RescueStandardError
  # rubocop:disable Performance/RedundantMatch, Performance/RegexpMatch
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def change_to_datetime(obj)
    if obj.nil? || obj.is_a?(String)
      return obj
    end

    data_obj = {}
    obj.each do |key, value|
      obj_entry = {}
      if value.is_a?(Array)
        hash_array = []
        value.map do |element|
          hash_array << change_to_datetime(element)
        end
        obj_entry[key] = hash_array
        data_obj.merge!(obj_entry)
      else
        date_value = value
        if /(DATE|TIMESTAMP|LASTSEEN|TIME|ATD)/.match(key.to_s.upcase)
          begin
            date_value = Integer(value)
            if date_value > 100000000
              date_value = value.nil? ? value : Time.at(date_value)
            end
          rescue
            date_value
          end
        end
        obj_entry[key] = date_value
        data_obj.merge!(obj_entry)
      end
    end
    return data_obj
  end
  # rubocop:enable Style/RedundantReturn
  # rubocop:enable Style/IdenticalConditionalBranches
  # rubocop:enable Metrics/BlockNesting, Style/RescueStandardError
  # rubocop:enable Performance/RedundantMatch, Performance/RegexpMatch
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end
