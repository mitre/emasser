lib_path = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'emasser/version'
require 'yaml'
require 'json'
require 'json/add/core'

# The describe block is always used at the top to put specs in a context.
#
# It can accept either a class name, in which case the class needs to exist, and inside
# describes or context blocks by convention, class methods are prefixed with a dot (".add"),
# and instance methods with a dash ("#add")
#
# The top describe block can also be any string that describes the testing.
describe 'emasser cli' do
  # rubocop:disable Style/StringConcatenation, Style/CommandLiteral, Style/PercentLiteralDelimiters
  let(:file) { File.expand_path('../emass_client', __dir__)+'/eMASSRestOpenApi.yaml' }

  it 'version should be equal to 1.0.0' do
    expect(Emasser::VERSION).to eq('1.0.0')
  end

  it 'should have the eMASS API yaml definition file' do
    yaml_object = JSON.generate(YAML.load_file(file))
    # puts "definition is: #{yaml_object.length}"
    expect(yaml_object.length).to be > 0
  end

  it 'should have a valid API yaml definition file' do
    yaml_object = %x[ruby -r yaml -e 'YAML.load_file ARGV[0];puts "ok"' #{file}]
    expect(yaml_object).to eq("ok\n")
  end
  # rubocop:enable Style/StringConcatenation, Style/CommandLiteral, Style/PercentLiteralDelimiters
end

# to run use:
#    rspec spec\test_emasser_cli_spec.rb  --format documentation
