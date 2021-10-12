# frozen_string_literal: true

module OptionsParser
  def required_options(initializer)
    options_that_are(initializer, :required)
  end

  def optional_options(initializer)
    options_that_are(initializer, :optional)
  end

  private

  def options_that_are(initializer, constraint)
    raise(ArgumentError, 'constraint must be required or optional') unless %i[required optional].include?(constraint)

    method = constraint.eql?(:required) ? :select : :reject
    initializer[2][:current_command].options.send(method) { |_k, v| v.required }
  end
end
