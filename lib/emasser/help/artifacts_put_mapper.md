Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique eMASS identifier. Will need to provide correct number.
filename                String     [Required] File name should match exactly one file within the provided zip file.
isTemplate              Boolean    [Required] Indicates whether an artifact is a template.
type*                   String     [Required] Values include the following: (Procedure, Diagram, Policy, Labor,
                                              Document, Image, Other, Scan Result, Auditor Report)
category*               String     [Required] Values include the following: (Implementation Guidance, Evidence)

name                    String     [Optional] Artifact name. Character Limit = 100.
description             String     [Optional] Artifact description. 2000 Characters.
refPageNumber           String     [Optional] Artifact reference page number. 50 Characters.
controls                String     [Optional] Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined.
assessmentProcedures    String     [Optional] The Security Control Assessment Procedure being associated with the artifact.
expirationDate          Date       [Optional] Date artifact expires and requires review. Unix date format.
lastReviewedDate        Date       [Optional] Date Artifact was last reviewed. In Unix Date Format
signedDate              Date       [Optional] Date artifact was signed. In Unix Date Format


* May also accept custom artifact category values set by system administrators.

Updates one artifact in a system - the API endpoint provide the capability of updating multiple artifacts concurrently, however this CLI only supports updating one Artifact at the time.


The body of a request through the Artifacts PUT endpoint accepts the fields in the below Sample Request Body.
Name and isTemplate are non-nullable fields, so name will default to the filename, while isTemplate will
default to false if those fields are not specified in the PUT.

Also, note that one-to-many fields (controls and ccis) will also be replaced with the values specified in the PUT.
If existing control or cci mappings exist in eMASS, the values in the PUT will not append, but rather replace all
existing control and cci mappings with the values in the request body.

Note that the PUT request will replace all existing data with the field/value combinations included in the request body. If any fields are not included, the absent fields will become null.

Business Rules
- Artifact cannot be saved if File Name (fileName) exceeds 1,000 characters
- Artifact cannot be saved if Name (name) exceeds 100 characters
- Artifact cannot be saved if Description (description) exceeds 10,000 characters
- Artifact cannot be saved if Reference Page Number (refPageNumber) exceeds 50 characters
- Artifact cannot be saved if the file does not have an allowable file extension/type.
- Artifact version cannot be saved if an Artifact with the same file name already exist in the system.
- Artifact cannot be saved if the file size exceeds 30MB.
- Artifact cannot be saved if the Last Review Date is set in the future.
- Artifact cannot be saved if the following fields are missing data:
  -  Filename
  -  Type
  -  Category

Example:

bundle exec exe/emasser put artifacts update [-s, --systemId] <value> [-f, --filename] <value> [-T, --isTemplate or --no-isTemplate] [-t, --type] <value> [-c, --category] <value> 
