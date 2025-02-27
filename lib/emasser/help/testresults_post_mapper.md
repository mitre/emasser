Endpoint request body parameters/fields

Field            Data Type   Details
-------------------------------------------------------------------------------------------------
systemId            Integer  [Required] Unique eMASS identifier. Will need to provide correct number
assessmentProcedure String   [Required] The Security Control Assessment Procedure being assessed.
testedBy            String   [Required] Last Name, First Name. 100 Characters. 
testDate            Date     [Required] Unix time format.
description         String   [Required] Include description of test result. 4000 Characters.
complianceStatus    String   [Required] Values include the following: (Compliant, Non-Compliant, Not Applicable)


Example:

bundle exec exe/emasser post test_results add [-s --systemId] <value> --assessmentProcedure <value> --testedBy <value> --testDate <value? --description <value> --complianceStatus <value>

Note: If no POA&Ms or Assessment Procedure exist for the control (system), you will get this response:
"You have entered a Non-Compliant Test Result. You must create a POA&M Item for this Control and/or AP if one does not already exist."
