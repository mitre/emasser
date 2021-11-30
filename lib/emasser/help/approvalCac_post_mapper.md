Submit control to second role of CAC

Endpoint request parameters/fields

Field             Data Type  Details
-------------------------------------------------------------------------------------------------
systemId          Integer    [Required] Unique system identifier 
controlAcronym    String     [Required] Control acronym associated with the POA&M Item. NIST SP 800-53 Revision 4 defined.
complianceStatus  String     [Read-Only] Compliance status of the control.
currentRole*      String     [Read-Only] Current role.
currentStep*      Integer    [Read-Only] Current step in the Control Approval Chain.
totalSteps*       Integer    [Read-Only] Total number of steps in Control Approval Chain.
comments**        String     [Conditional] Comments related to package approval chain. 4000 Characters.

*API fields returned from server are currentStageName, currentStage, and totalStages
**Comments are not a required field at the first role of the CAC but are required at the second
role of the CAC. Comments cannot exceed 2000 characters.

Example:

bundle exec exe/emasser post approval pac --systemId [value] --controlAcronym [value] --comments [value]