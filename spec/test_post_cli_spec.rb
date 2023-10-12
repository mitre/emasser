require 'thor'
require 'emasser/errors'
require 'emasser/options_parser'
require 'emasser/output_converters'
require 'emasser/input_converters'
require 'emasser/help'
require 'emasser/post'

# -----------------------------------------------------
# Test that all required CLI POST classes are available
describe Emasser::TestResults do
  before do
    # run before each test
    @instance = Emasser::TestResults.new
  end
  context 'test an instance of TestResults class object' do
    it 'should create an instance of TestResults (post)' do
      expect(@instance).to be_instance_of(Emasser::TestResults)
    end
  end
end

describe Emasser::Poams do
  before do
    # run before each test
    @instance = Emasser::Poams.new
  end
  context 'test an instance of Poams class object' do
    it 'should create an instance of Poams (post)' do
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
    it 'should create an instance of Milestones (post)' do
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
    it 'should create an instance of Artifacts (post)' do
      expect(@instance).to be_instance_of(Emasser::Artifacts)
    end
  end
end

describe Emasser::PAC do
  before do
    # run before each test
    @instance = Emasser::PAC.new
  end
  context 'test an instance of PAC class object' do
    it 'should create an instance of PAC (post)' do
      expect(@instance).to be_instance_of(Emasser::PAC)
    end
  end
end

describe Emasser::CAC do
  before do
    # run before each test
    @instance = Emasser::CAC.new
  end
  context 'test an instance of CAC class object' do
    it 'should create an instance of CAC (post)' do
      expect(@instance).to be_instance_of(Emasser::CAC)
    end
  end
end

describe Emasser::ScanFindings do
  before do
    # run before each test
    @instance = Emasser::ScanFindings.new
  end
  context 'test an instance of ScanFindings class object' do
    it 'should create an instance of ScanFindings (post)' do
      expect(@instance).to be_instance_of(Emasser::ScanFindings)
    end
  end
end

describe Emasser::CloudResource do
  before do
    # run before each test
    @instance = Emasser::CloudResource.new
  end
  context 'test an instance of CloudResource class object' do
    it 'should create an instance of CloudResource (post)' do
      expect(@instance).to be_instance_of(Emasser::CloudResource)
    end
  end
end

describe Emasser::Container do
  before do
    # run before each test
    @instance = Emasser::Container.new
  end
  context 'test an instance of Container class object' do
    it 'should create an instance of Container (post)' do
      expect(@instance).to be_instance_of(Emasser::Container)
    end
  end
end

# to run use:
#    rspec spec\test_post_cli_spec.rb  --format documentation
