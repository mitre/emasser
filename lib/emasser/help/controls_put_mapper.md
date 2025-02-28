Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                 Integer   [Required] Unique eMASS identifier. Will need to provide correct number.
acronym                  String    [Required] Required to match the NIST SP 800-53 Revision 4.
responsibleEntities      String    [Required] Include written description of Responsible Entities that are responsible for the Security Control. 
controlDesignation       String    [Required] Values include the following: (Common, System-Specific, Hybrid)
estimatedCompletionDate  Date      [Required] Field is required for Implementation Plan
implementationNarrative  String    [Required] Includes Security Control comments.

commonControlProvider   String     [Conditional] Values include the following: (DoD, Component, Enclave)
naJustification         String     [Conditional] Provide justification for Security Controls deemed Not Applicable to the system.
slcmCriticality         String     [Conditional] Criticality of Security Control regarding SLCM. Character Limit = 2,000
slcmFrequency           String     [Conditional] Values include the following: (Constantly, Daily, Weekly, Monthly, Quarterly,
                                                 Semi-Annually, Annually, Every,Two Years, Every Three Years, Undetermined)
slcmMethod              String     [Conditional] Values include the following: (Automated, Semi-Automated, Manual, Undetermined)
slcmReporting           String     [Conditional] Method for reporting Security Controls for SLCM. Character Limit = 2,000
slcmTracking            String     [Conditional] How Non-Compliant Security Controls will be tracked for SLCM. Character Limit = 2,000
slcmComments            String     [Conditional] Additional comments for Security Control regarding SLCM. Character Limit = 4,000

implementationStatus    String     [Optional] Values include the following: (Planned, Implemented, Inherited, Not Applicable, Manually Inherited)
severity                String     [Optional] Values include the following: (Very Low, Low, Moderate, High, Very High)
vulnerabilitySummary    String     [Optional] Include vulnerability summary. Character Limit = 2,000.
recommendations         String     [Optional] Include recommendations. Character Limit = 2,000.
relevanceOfThreat       String     [Optional] Values include the following: (Very Low, Low, Moderate, High, Very High)
likelihood              String     [Optional] Values include the following: (Very Low, Low, Moderate, High, Very High)
impact                  String     [Optional] Values include the following: (Very Low, Low, Moderate, High, Very High)
impactDescription       String     [Optional] Include description of Security Control's impact.
residualRiskLevel       String     [Optional] Values include the following: (Very Low, Low, Moderate, High, Very High)
testMethod              String     [Optional] Values include the following: ('Test', 'Interview', 'Examine', 'Test, Interview',
                                              'Test, Examine', 'Interview, Examine', 'Test, Interview, Examine')
mitigations             String     [Optional] Identify any mitigations in place for the Non-Compliant Security Control's vulnerabilities. Character Limit = 2,000.
applicationLayer        String     [Optional] If the Financial Management (Navy) overlay is applied to the system,
                                              this field appears and can be populated. Character Limit = 2,000. Navy only.
databaseLayer           String     [Optional] If the Financial Management (Navy) overlay is applied to the system,
                                              this field appears and can be populated. Character Limit = 2,000. Navy only.
operatingSystemLayer    String     [Optional] If the Financial Management (Navy) overlay is applied to the system,
                                              this field appears and can be populated. Character Limit = 2,000. Navy only.


Business Rules

Risk Assessment
  - Risk Assessment information cannot be updated if a Security Control is “Inherited.”
  - Risk Assessment information cannot be updated for a DIACAP system record.
  - Risk Assessment information cannot be updated if Security Control does not exist in the system record.


Implementation Plan

The following fields are required based on the value of the `implementationStatus` field
  |Value                   |Required Fields
  |------------------------|--------------------------------------------------------
  |Planned or Implemented  |controlDesignation, estimatedCompletionDate, responsibleEntities, slcmCriticality, slcmFrequency, slcmMethod, slcmMethod, slcmTracking, slcmComments
  |Not Applicable          |naJustification, controlDesignation, responsibleEntities
  |Manually Inherited      |controlDesignation, estimatedCompletionDate, responsibleEntities, slcmCriticality, slcmFrequency, slcmMethod, slcmMethod, slcmTracking, slcmComments

Implementation Plan cannot be updated if a Security Control is "Inherited" except for the following fields:
    - Common Control Provider (commonControlProvider)
    - Security Control Designation (controlDesignation)
  
The following parameters/fields have the following character limitations:
- Implementation Plan information cannot be saved if the fields below exceed 2,000 character limits:
  - N/A Justification        (naJustification)
  - Responsible Entities     (responsibleEntities) 
  - Implementation Narrative (implementationNarrative)
  - Criticality              (slcmCriticality)
  - Reporting                (slcmReporting)
  - Tracking                 (slcmTracking)
  - Vulnerability Summary    (vulnerabilitySummary)
  - Recommendations          (recommendations)
- Implementation Plan information cannot be saved if the fields below exceed 4,000 character limits:
  - SLCM Comments            (slcmComments)

Implementation Plan information cannot be updated if Security Control does not exist in the system record.

Example:

bundle exec exe/emasser put controls update --systemId [value] --acronym [value] --responsibleEntities [value] --controlDesignation [value] --estimatedCompletionDate [value] --implementationNarrative [value]

Note: The example is only showing the required fields. Refer to instructions listed above for conditional and optional fields requirements.
