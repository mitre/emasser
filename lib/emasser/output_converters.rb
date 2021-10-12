# frozen_string_literal: true

module OutputConverters
  def to_output_hash(obj)
    if obj.to_s.include? 'Error message'
      obj
    else
      hash = obj.instance_variables.each_with_object({}) do |var, h|
        h[var.to_s.delete('@')] = obj.instance_variable_get(var)
      end
      JSON.pretty_generate(hash)
    end
  end
end
