Endpoint request body parameters/fields

Field            Data Type   Details
-------------------------------------------------------------------------------------------------
systemId         Integer     [Required] Unique eMASS identifier. Will need to provide correct number
cci              String      [Required] CCI associated with the test result.
isInherited      Boolean     [Read-Only] Indicates whether a test result is inherited.
testedBy         String      [Required] Last Name, First Name. 100 Characters. 
testDate         Date        [Required] Unix time format.
description      String      [Required] Include description of test result. 4000 Characters.
type             String      [Read-Only] Indicates the location in the Control Approval Chain when the test result is submitted.
complianceStatus String      [Required] Values include the following: (Compliant, Non-Compliant, Not Applicable)

control          String      [Read-Only] Control acronym associated with the test result. NIST SP 800-53 Revision 4 defined.

Example:

bundle exec exe/emasser post test_results add --systemId [value] --cci [value] --testedBy [value] --testDate [value] --description [value] --complianceStatus [value]

Note: If no POA&Ms or AP exist for the control (system), you will get this response:
"You have entered a Non-Compliant Test Result. You must create a POA&M Item for this Control and/or AP if one does not already exist."
