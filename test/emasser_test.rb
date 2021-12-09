# frozen_string_literal: true

libx = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(libx) unless $LOAD_PATH.include?(libx)

emass_client = File.expand_path('../emass_client/ruby_client/lib', __dir__)
$LOAD_PATH.unshift(emass_client) unless $LOAD_PATH.include?(emass_client)

require 'minitest/autorun'
require 'emasser/version'
require 'swagger_client'
require 'colorize'

class EmasserTest < Minitest::Test
  @checkmark = "\u2713"

  def test_that_it_has_a_version_number

    if assert_includes '1.0.0', Emasser::VERSION
    #if refute_nil Emasser::VERSION
      puts "#{"\u2713"} test_that_it_has_a_version_number".green
    else
      puts "#{"\u2717"} test_that_it_has_a_version_number".red
    end
  end

  def test_swagger_client_version_number
    refute_nil SwaggerClient::VERSION
    #puts SwaggerClient::VERSION
  end

  # def test_that_artifacts_api_exists
  #   #refute_empty SwaggerClient::ApiClient.default
  #   assert_includes SwaggerClient::Configuration.default, SwaggerClient::ApiClient.new.itself
  # end
  # def test_that_artifacts_api_exists
  #   api_client = SwaggerClient::ArtifactsApi.new.api_client # (SwaggerClient::Configuration.default)
  #   refute_empty api_client
  #   # https://semaphoreci.com/community/tutorials/getting-started-with-minitest
  #   #assert_kind_of SwaggerClient::ApiClient.default, api_client
  #   #assert_includes SwaggerClient::Configuration.default, api_client
  # end
end
