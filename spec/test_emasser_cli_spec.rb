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
  # rubocop:disable Style/StringConcatenation
  let(:featuresDoc) { File.expand_path('../docs', __dir__)+'/features.md' }

  it 'has a version number' do
    expect(Emasser::VERSION).not_to be nil
  end

  it 'should have a features markdown file' do
    expect(File).to exist(featuresDoc)
  end
  # rubocop:enable Style/StringConcatenation
end

# to run use:
#    rspec spec\test_emasser_cli_spec.rb  --format documentation
