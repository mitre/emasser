require 'thor'
require 'emasser/errors'
require 'emasser/options_parser'
require 'emasser/output_converters'
require 'emasser/input_converters'
require 'emasser/help'
require 'emasser/get'
require 'emass_client'

# ----------------------------------------------------
# Test that all required CLI GET classes are available
describe Emasser::Test do
  before do
    # run before each test
    @instance = Emasser::Test.new
  end
  context 'test an instance of Test class object' do
    it 'should create an instance of Test (get)' do
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
    it 'should create an instance of System (get)' do
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
    it 'should create an instance of Systems (get)' do
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
    it 'should create an instance of Roles (get)' do
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
    it 'should create an instance of Controls (get)' do
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
    it 'should create an instance of TestResults (get)' do
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
    it 'should create an instance of Poams (get)' do
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
    it 'should create an instance of Milestones (get)' do
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
    it 'should create an instance of Artifacts (get)' do
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
    it 'should create an instance of CAC (get)' do
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
    it 'should create an instance of PAC (get)' do
      expect(@instance).to be_instance_of(Emasser::PAC)
    end
  end
end

describe Emasser::Hardware do
  before do
    # run before each test
    @instance = Emasser::Hardware.new
  end
  context 'test an instance of Hardware class object' do
    it 'should create an instance of Hardware (get)' do
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
    it 'should create an instance of Software (get)' do
      expect(@instance).to be_instance_of(Emasser::Software)
    end
  end
end

describe Emasser::WorkflowDefinitions do
  before do
    # run before each test
    @instance = Emasser::WorkflowDefinitions.new
  end
  context 'test an instance of WorkflowDefinitions class object' do
    it 'should create an instance of WorkflowDefinitions (get)' do
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
    it 'should create an instance of WorkflowInstances (get)' do
      expect(@instance).to be_instance_of(Emasser::WorkflowInstances)
    end
  end
end

describe Emasser::CMMC do
  before do
    # run before each test
    @instance = Emasser::CMMC.new
  end
  context 'test an instance of CMMC class object' do
    it 'should create an instance of CMMC (get)' do
      expect(@instance).to be_instance_of(Emasser::CMMC)
    end
  end
end

describe 'System Application Findings Dashboards' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemApplicationFindingsDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemApplicationFindingsDashboardsApi' do
    it 'should create an instance of SystemApplicationFindingsDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemApplicationFindingsDashboardsApi)
    end
  end
end



describe 'System Artifacts Dashboards' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemArtifactsDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemArtifactsDashboardsApi' do
    it 'should create an instance of SystemArtifactsDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemArtifactsDashboardsApi)
    end
  end
end

describe 'System Associations Dashboard' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemAssociationsDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemAssociationsDashboardApi' do
    it 'should create an instance of SystemAssociationsDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemAssociationsDashboardApi)
    end
  end
end

describe 'SystemATCIATCDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemATCIATCDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemATCIATCDashboardApi' do
    it 'should create an instance of SystemATCIATCDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemATCIATCDashboardApi)
    end
  end
end

describe 'SystemCONMONIntegrationStatusDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemCONMONIntegrationStatusDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemCONMONIntegrationStatusDashboardApi' do
    it 'should create an instance of SystemCONMONIntegrationStatusDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemCONMONIntegrationStatusDashboardApi)
    end
  end
end

describe 'SystemConnectivityCCSDDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemConnectivityCCSDDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemConnectivityCCSDDashboardsApi' do
    it 'should create an instance of SystemConnectivityCCSDDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemConnectivityCCSDDashboardsApi)
    end
  end
end

describe 'SystemCriticalAssetsDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemCriticalAssetsDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemCriticalAssetsDashboardApi' do
    it 'should create an instance of SystemCriticalAssetsDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemCriticalAssetsDashboardApi)
    end
  end
end

describe 'SystemDeviceFindingsDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemDeviceFindingsDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemDeviceFindingsDashboardsApi' do
    it 'should create an instance of SystemDeviceFindingsDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemDeviceFindingsDashboardsApi)
    end
  end
end

describe 'SystemFISMAMetricsDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemFISMAMetricsDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemFISMAMetricsDashboardApi' do
    it 'should create an instance of SystemFISMAMetricsDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemFISMAMetricsDashboardApi)
    end
  end
end

describe 'SystemHardwareDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemHardwareDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemHardwareDashboardsApi' do
    it 'should create an instance of SystemHardwareDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemHardwareDashboardsApi)
    end
  end
end

describe 'SystemMigrationStatusDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemMigrationStatusDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemMigrationStatusDashboardApi' do
    it 'should create an instance of SystemMigrationStatusDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemMigrationStatusDashboardApi)
    end
  end
end

describe 'SystemPOAMDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemPOAMDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemPOAMDashboardsApi' do
    it 'should create an instance of SystemPOAMDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemPOAMDashboardsApi)
    end
  end
end

describe 'SystemPortsProtocolsDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemPortsProtocolsDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemPortsProtocolsDashboardsApi' do
    it 'should create an instance of SystemPortsProtocolsDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemPortsProtocolsDashboardsApi)
    end
  end
end

describe 'SystemPrivacyDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemPrivacyDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemPrivacyDashboardApi' do
    it 'should create an instance of SystemPrivacyDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemPrivacyDashboardApi)
    end
  end
end

describe 'SystemQuestionnaireDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemQuestionnaireDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemQuestionnaireDashboardsApi' do
    it 'should create an instance of SystemQuestionnaireDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemQuestionnaireDashboardsApi)
    end
  end

end

describe 'SystemRolesApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemRolesApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemRolesApi' do
    it 'should create an instance of SystemRolesApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemRolesApi)
    end
  end
end

describe 'SystemSecurityControlsDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemSecurityControlsDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemSecurityControlsDashboardsApi' do
    it 'should create an instance of SystemSecurityControlsDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemSecurityControlsDashboardsApi)
    end
  end
end

describe 'SystemSensorHardwareDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemSensorHardwareDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemSensorHardwareDashboardsApi' do
    it 'should create an instance of SystemSensorHardwareDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemSensorHardwareDashboardsApi)
    end
  end
end

describe 'SystemSensorSoftwareDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemSensorSoftwareDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemSensorSoftwareDashboardsApi' do
    it 'should create an instance of SystemSensorSoftwareDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemSensorSoftwareDashboardsApi)
    end
  end
end

describe 'SystemSoftwareDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemSoftwareDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemSoftwareDashboardsApi' do
    it 'should create an instance of SystemSoftwareDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemSoftwareDashboardsApi)
    end
  end
end

describe 'System Status Dashboard' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemStatusDashboardApi.new
  end

  describe 'test an instance of SystemStatusDashboardApi' do
    it 'should create an instance of SystemStatusDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemStatusDashboardApi)
    end
  end

end

describe 'SystemTermsConditionsDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemTermsConditionsDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemTermsConditionsDashboardsApi' do
    it 'should create an instance of SystemTermsConditionsDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemTermsConditionsDashboardsApi)
    end
  end
end

describe 'SystemVulnerabilityDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemVulnerabilityDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemVulnerabilityDashboardApi' do
    it 'should create an instance of SystemVulnerabilityDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemVulnerabilityDashboardApi)
    end
  end
end

describe 'SystemWorkflowsDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::SystemWorkflowsDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of SystemWorkflowsDashboardsApi' do
    it 'should create an instance of SystemWorkflowsDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::SystemWorkflowsDashboardsApi)
    end
  end
end

describe 'UserSystemAssignmentsDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::UserSystemAssignmentsDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of UserSystemAssignmentsDashboardApi' do
    it 'should create an instance of UserSystemAssignmentsDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::UserSystemAssignmentsDashboardApi)
    end
  end
end

describe 'VASystemDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::VASystemDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of VASystemDashboardsApi' do
    it 'should create an instance of VASystemDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::VASystemDashboardsApi)
    end
  end
end

describe 'VAOMBFISMADashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::VAOMBFISMADashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of VAOMBFISMADashboardApi' do
    it 'should create an instance of VAOMBFISMADashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::VAOMBFISMADashboardApi)
    end
  end
end

describe 'CMMCAssessmentDashboardsApi' do
  before do
    # run before each test
    @api_instance = EmassClient::CMMCAssessmentDashboardsApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of CMMCAssessmentDashboardsApi' do
    it 'should create an instance of CMMCAssessmentDashboardsApi' do
      expect(@api_instance).to be_instance_of(EmassClient::CMMCAssessmentDashboardsApi)
    end
  end
end

describe 'CoastGuardSystemFISMAMetricsDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::CoastGuardSystemFISMAMetricsDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of CoastGuardSystemFISMAMetricsDashboardApi' do
    it 'should create an instance of CoastGuardSystemFISMAMetricsDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::CoastGuardSystemFISMAMetricsDashboardApi)
    end
  end
end

describe 'OrganizationMigrationStatusDashboardApi' do
  before do
    # run before each test
    @api_instance = EmassClient::OrganizationMigrationStatusDashboardApi.new
  end

  after do
    # run after each test
  end

  describe 'test an instance of OrganizationMigrationStatusDashboardApi' do
    it 'should create an instance of OrganizationMigrationStatusDashboardApi' do
      expect(@api_instance).to be_instance_of(EmassClient::OrganizationMigrationStatusDashboardApi)
    end
  end
end

# To run use
#    rspec spec\test_get_cli_spec.rb  --format documentation
