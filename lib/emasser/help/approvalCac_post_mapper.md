Submit control to second role of CAC

Endpoint request parameters/fields

Field             Data Type  Details
-------------------------------------------------------------------------------------------------
systemId          Integer    [Required] Unique system identifier 
controlAcronym    String     [Required] Control acronym associated with the POA&M Item. NIST SP 800-53 Revision 4 defined.
complianceStatus  String     [Read-Only] Compliance status of the control.
currentStageName  String     [Read-Only] Current role.
currentStage      Integer    [Read-Only] Current step in the Control Approval Chain.
totalStages       Integer    [Read-Only] Total number of steps in Control Approval Chain.
comments*         String     [Conditional] Comments related to package approval chain. 10,000 Characters.

*Comments are not a required field at the first role of the CAC but are required at the second
role of the CAC. Comments cannot exceed 10,000 characters.

Example:

bundle exec exe/emasser post cac add --systemId [value] --controlAcronym [value] --comments [value]