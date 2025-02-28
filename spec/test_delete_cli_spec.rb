require 'thor'
require 'emasser/errors'
require 'emasser/output_converters'
require 'emasser/help'
require 'emasser/delete'

# -----------------------------------------------------
# Test that all required CLI DELETE classes are available
describe Emasser::Poams do
  before do
    # run before each test
    @instance = Emasser::Poams.new
  end
  context 'test an instance of Poams class object' do
    it 'should create an instance of Poams (delete)' do
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
    it 'should create an instance of Milestones (delete)' do
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
    it 'should create an instance of Artifacts (delete)' do
      expect(@instance).to be_instance_of(Emasser::Artifacts)
    end
  end
end

describe Emasser::Hardware do
  before do
    # run before each test
    @instance = Emasser::Hardware.new
  end
  context 'test an instance of Hardware class object' do
    it 'should create an instance of Hardware (delete)' do
      expect(@instance).to be_instance_of(Emasser::Hardware)
    end
  end
end

describe Emasser::Software do
  before do
    # run before each test
    @instance = Emasser::Software.new
  end
  context 'test an instance of Software class object' do
    it 'should create an instance of Software (delete)' do
      expect(@instance).to be_instance_of(Emasser::Software)
    end
  end
end

describe Emasser::CloudResource do
  before do
    # run before each test
    @instance = Emasser::CloudResource.new
  end
  context 'test an instance of CloudResource class object' do
    it 'should create an instance of CloudResource (delete)' do
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
    it 'should create an instance of Container (delete)' do
      expect(@instance).to be_instance_of(Emasser::Container)
    end
  end
end

# To run use
#    rspec spec\test_delete_cli_spec.rb  --format documentation
