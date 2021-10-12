# frozen_string_literal: true

require 'active_support/inflector'
require 'active_support/core_ext/hash'

module InputConverters
  # Method uses utility class "underscore" from ActiveSupport
  include ActiveSupport::Inflector

  # Given the full hash of options, select the truly optional ones and then
  # convert the camelCase optional CLI parameters to underscore as the Swagger auto
  # generated code converts all camelCase variable within the yaml to an underscore format
  # This will result in a properly formatted hash of parameters for the API request.
  # example: controlAcronyms TO control_acronyms
  #
  # As an alternative, declare the options in underscore case and only select for the optional_options.
  def to_input_hash(optional_options_keys, full_options)
    optional_options_hash = full_options.select { |option| optional_options_keys.include?(option.to_sym) }
    optional_options_hash.transform_keys { |k| k.to_s.underscore.to_sym }
  end
end
