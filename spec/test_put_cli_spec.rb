require 'thor'
require 'emasser/errors'
require 'emasser/output_converters'
require 'emasser/help'
require 'emasser/put'

# -----------------------------------------------------
# Test that all required CLI PUT classes are available
describe Emasser::Controls do
  before do
    # run before each test
    @instance = Emasser::Controls.new
  end
  context 'test an instance of Controls class object' do
    it 'should create an instance of Controls (put)' do
      expect(@instance).to be_instance_of(Emasser::Controls)
    end
  end
end

describe Emasser::Poams do
  before do
    # run before each test
    @instance = Emasser::Poams.new
  end
  context 'test an instance of Poams class object' do
    it 'should create an instance of Poams (put)' do
      expect(@instance).to be_instance_of(Emasser::Poams)
    end
  end
end

describe Emasser::Milestones do
  before do
    # run before each test
    @instance = Emasser::Milestones.new
  end
  context 'test an instance of Milestones class object' do
    it 'should create an instance of Milestones (put)' do
      expect(@instance).to be_instance_of(Emasser::Milestones)
    end
  end
end

describe Emasser::Artifacts do
  before do
    # run before each test
    @instance = Emasser::Artifacts.new
  end
  context 'test an instance of Artifacts class object' do
    it 'should create an instance of Artifacts (put)' do
      expect(@instance).to be_instance_of(Emasser::Artifacts)
    end
  end
end

# to run use:
#    rspec spec\test_put_cli_spec.rb  --format documentation
