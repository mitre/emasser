# require 'dotenv/load'
require 'thor'
require 'emasser/errors'
require 'emasser/options_parser'
require 'emasser/output_converters'
require 'emasser/input_converters'
require 'emasser/help'
require 'emasser/get'

# ----------------------------------------------------
# Test that all required CLI GET classes are available
describe Emasser::Test do
  before do
    # run before each test
    @instance = Emasser::Test.new
  end
  context 'test an instance of Test class object' do
    it 'should create an instance of Test' do
      expect(@instance).to be_instance_of(Emasser::Test)
    end
  end
end

describe Emasser::System do
  before do
    # run before each test
    @instance = Emasser::System.new
  end
  context 'test an instance of System class object' do
    it 'should create an instance of System' do
      expect(@instance).to be_instance_of(Emasser::System)
    end
  end
end

describe Emasser::Systems do
  before do
    # run before each test
    @instance = Emasser::Systems.new
  end
  context 'test an instance of Systems class object' do
    it 'should create an instance of Systems' do
      expect(@instance).to be_instance_of(Emasser::Systems)
    end
  end
end

describe Emasser::Roles do
  before do
    # run before each test
    @instance = Emasser::Roles.new
  end
  context 'test an instance of Roles class object' do
    it 'should create an instance of Roles' do
      expect(@instance).to be_instance_of(Emasser::Roles)
    end
  end
end

describe Emasser::Controls do
  before do
    # run before each test
    @instance = Emasser::Controls.new
  end
  context 'test an instance of Controls class object' do
    it 'should create an instance of Controls' do
      expect(@instance).to be_instance_of(Emasser::Controls)
    end
  end
end

describe Emasser::TestResults do
  before do
    # run before each test
    @instance = Emasser::TestResults.new
  end
  context 'test an instance of TestResults class object' do
    it 'should create an instance of TestResults' do
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
    it 'should create an instance of Poams' do
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
    it 'should create an instance of Milestones' do
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
    it 'should create an instance of Artifacts' do
      expect(@instance).to be_instance_of(Emasser::Artifacts)
    end
  end
end

describe Emasser::CAC do
  before do
    # run before each test
    @instance = Emasser::CAC.new
  end
  context 'test an instance of CAC class object' do
    it 'should create an instance of CAC' do
      expect(@instance).to be_instance_of(Emasser::CAC)
    end
  end
end

describe Emasser::PAC do
  before do
    # run before each test
    @instance = Emasser::PAC.new
  end
  context 'test an instance of PAC class object' do
    it 'should create an instance of PAC' do
      expect(@instance).to be_instance_of(Emasser::PAC)
    end
  end
end

describe Emasser::CMMC do
  before do
    # run before each test
    @instance = Emasser::CMMC.new
  end
  context 'test an instance of CMMC class object' do
    it 'should create an instance of CMMC' do
      expect(@instance).to be_instance_of(Emasser::CMMC)
    end
  end
end

describe Emasser::WorkflowDefinitions do
  before do
    # run before each test
    @instance = Emasser::WorkflowDefinitions.new
  end
  context 'test an instance of WorkflowDefinitions class object' do
    it 'should create an instance of WorkflowDefinitions' do
      expect(@instance).to be_instance_of(Emasser::WorkflowDefinitions)
    end
  end
end

describe Emasser::WorkflowInstances do
  before do
    # run before each test
    @instance = Emasser::WorkflowInstances.new
  end
  context 'test an instance of WorkflowInstances class object' do
    it 'should create an instance of WorkflowInstances' do
      expect(@instance).to be_instance_of(Emasser::WorkflowInstances)
    end
  end
end

# To run use
#    rspec spec\test_get_cli_spec.rb  --format documentation
