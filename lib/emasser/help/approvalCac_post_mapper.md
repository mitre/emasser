Submit control to second role of CAC

Endpoint request parameters/fields

Field             Data Type  Details
-------------------------------------------------------------------------------------------------
systemId          Integer    [Required] Unique system identifier 
controlAcronym    String     [Required] Control acronym associated with the POA&M Item. NIST SP 800-53 Revision 4 defined.

comments*         String     [Conditional] Comments related to package approval chain. 10,000 Characters.


*Comments are not a required field at the first role of the CAC but are required at the second
role of the CAC. Comments cannot exceed 10,000 characters.

POST requests will only yield successful results if the Security Control is at the first
stage of the CAC. If the control is not at the first stage, an error will be returned

Example:

bundle exec exe/emasser post pac add [-s, --systemId] <value> [-a, --controlAcronym] <value> [-c, --comments] <value>
