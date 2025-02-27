Add cloud resource and scan results in the assets module for a system

Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                 Integer   [Required] Unique eMASS identifier. Will need to provide correct number.
provider                 String    [Required] Cloud service provider name.
resourceId               String    [Required] Unique identifier/resource namespace for policy compliance result.
resourceName             String    [Required] Friendly name of Cloud resource.
resourceType             String    [Required] Type of Cloud resource.

initiatedBy              String    [Optional] Email of POC.
cspAccountId             String    [Optional] System/owner's CSP account ID/number.
cspRegion                String    [Optional] CSP region of system.
isBaseline               Boolean   [Optional] True/false flag for providing results as baseline.
                                              If true, all existing compliance results for the resourceId will be replaced by results in the current call.
Tags Object
tags                     Object    [Optional] Informational tags associated to results for other metadata
  text                     String    [Optional] Tag metadata information

Compliance Results Object
complianceResults        Object  [Required] Compliance result information
  cspPolicyDefinitionId    String  [Required] Unique identifier/compliance namespace for CSP/Resource’s
                                            policy definition/compliance check.
  policyDefinitionTitle    String  [Required] Friendly policy/compliance check title. Recommend short title
  isCompliant              Boolean [Required] Compliance status of the policy for the identified cloud resource.

  complianceCheckTimestamp Date    [Optional] Unix date format
  control                  String  [Optional] Comma separated correlation to Security Control
                                             (e.g. exact NIST Control acronym).
  assessmentProcedure      String  [Optional] Comma separated correlation to Assessment Procedure
                                              (i.e. CCI number for DoD Control Set).
  complianceReason         String  [Optional] Reason/comments for compliance result
  policyDeploymentName     String  [Optional] Name of policy deployment
  policyDeploymentVersion  String  [Optional] Version of policy deployment.
  severity                 String  [Optional] Values include the following: (Low, Medium, High, Critical)


  The following Cloud Resource parameters/fields have the following character limitations:
- Fields that can not exceed 50 characters:
  - Policy Deployment Version (`policyDeploymentVersion`)
- Fields that can not exceed 100 characters:
  - Assessment Procedure      (`assessmentProcedure`)
  - Security Control Acronym  (`control`)
  - CSP Account ID            (`cspAccountId`)
  - CSP Region                (`cspRegion`)
  - Email of POC              (`initiatedBy`)
  - Cloud Service Provider    (`provider`)
  - Type of Cloud resource    (`resourceType`)
- Fields that can not exceed 500 characters:
  - CSP/Resource’s Policy ID  (`cspPolicyDefinitionId`)
  - Policy Deployment Name    (`policyDeploymentName`)
  - Policy Compliance ID      (`resourceId`)
  - Cloud Resource Name       (`resourceName`)
- Fields that can not exceed 1000 characters:
  - Reason for Compliance (`complianceReason`)
- Fields that can not exceed 2000 characters:
  - Policy Short Title    (`policyDefinitionTitle`)

Example:

bundle exec exe/emasser post cloud_resource add --systemId [value] --provider [value] --resourceId [value] --resourceName [value] --resourceType [value] --cspPolicyDefinitionId [value] --isCompliant or --is-not-Compliant --policyDefinitionTitle [value] --test [value]
