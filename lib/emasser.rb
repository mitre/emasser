# frozen_string_literal: true

require 'thor'
require 'zip'
require 'swagger_client'
require 'emasser/constants'
require 'emasser/configuration'
require 'emasser/version'
require 'emasser/errors'
require 'emasser/options_parser'
require 'emasser/output_converters'
require 'emasser/input_converters'
require 'emasser/get'
require 'emasser/cli'

module Emasser
  Emasser::CLI.start
end
