ruby_client_path = File.expand_path('../emass_client/ruby_client/lib', __dir__)
$LOAD_PATH.unshift(ruby_client_path) unless $LOAD_PATH.include?(ruby_client_path)

spec_path = File.expand_path('../emass_client/ruby_client/spec', __dir__)
$LOAD_PATH.unshift(spec_path) unless $LOAD_PATH.include?(spec_path)

api_path = File.expand_path('../emass_client/ruby_client/spec/api', __dir__)
$LOAD_PATH.unshift(api_path) unless $LOAD_PATH.include?(api_path)

require 'rspec'

# Test client common files
require 'api_client_spec'
require 'configuration_spec'

# Test Client APIs
require 'artifacts_api_spec'
require 'artifacts_export_api_spec'
require 'cac_api_spec'
require 'cmmc_assessments_api_spec'
require 'controls_api_spec'
require 'milestones_api_spec'
require 'pac_api_spec'
require 'poam_api_spec'
require 'registration_api_spec'
require 'static_code_scans_api_spec'
require 'system_roles_api_spec'
require 'systems_api_spec'
require 'test_api_spec'
require 'test_results_api_spec'
require 'workflow_definitions_api_spec'
require 'workflow_instances_api_spec'

# to run use:
#   rspec .\spec\run_swagger_client_spec.rb
#   rspec .\spec\test_swagger_client_spec.rb --format documentation
