# frozen_string_literal: true

require 'thor'
require 'zip'
require 'colorize'
require 'emass_client'
require 'emasser/constants'
require 'emasser/configure'
require 'emasser/configuration'
require 'emasser/version'
require 'emasser/errors'
require 'emasser/options_parser'
require 'emasser/output_converters'
require 'emasser/input_converters'
require 'emasser/help'
require 'emasser/cli'

module Emasser
  Emasser::CLI.start(ARGV)
end
