require 'thor'
require 'emasser/errors'
require 'emasser/options_parser'
require 'emasser/output_converters'
require 'emasser/input_converters'
require 'emasser/help'
require 'emasser/post'

describe Emasser::TestResults do
  before do
    # run before each test
    @instance = Emasser::TestResults.new
  end
  context 'The TestResults class object' do
    it 'should be equal to an instance of itself' do
      expect(@instance).to be_instance_of(Emasser::TestResults)
    end
  end
end

describe Emasser::Poams do
  before do
    # run before each test
    @instance = Emasser::Poams.new
  end
  context 'The Poams class object' do
    it 'should be equal to an instance of itself' do
      expect(@instance).to be_instance_of(Emasser::Poams)
    end
  end
end

describe Emasser::Milestones do
  before do
    # run before each test
    @instance = Emasser::Milestones.new
  end
  context 'The Milestones class object' do
    it 'should be equal to an instance of itself' do
      expect(@instance).to be_instance_of(Emasser::Milestones)
    end
  end
end

describe Emasser::Artifacts do
  before do
    # run before each test
    @instance = Emasser::Artifacts.new
  end
  context 'The Artifacts class object' do
    it 'should be equal to an instance of itself' do
      expect(@instance).to be_instance_of(Emasser::Artifacts)
    end
  end
end

describe Emasser::CAC do
  before do
    # run before each test
    @instance = Emasser::CAC.new
  end
  context 'The CAC class object' do
    it 'should be equal to an instance of itself' do
      expect(@instance).to be_instance_of(Emasser::CAC)
    end
  end
end
