Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique eMASS identifier. Will need to provide correct number.
isTemplate              Boolean    [Required] Indicates whether an artifact is a template.
type*                   String     [Required] Values include the following: (Procedure, Diagram, Policy, Labor,
                                              Document, Image, Other, Scan Result, Auditor Report)
category*               String     [Required] Values include the following: (Implementation Guidance, Evidence)
files                   String     [Required] File names (to include path) to be uploaded into eMASS as artifacts

description             String     [Optional] Artifact description. 2000 Characters.
refPageNumber           String     [Optional] Artifact reference page number. 50 Characters.
ccis                    String     [Optional] CCIs associated with artifact.
controls                String     [Optional] Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined.
artifactExpirationDate  Date       [Optional] Date Artifact expires and requires review. In Unix Date Format
lastReviewedDate        Date       [Optional] Date Artifact was last reviewed. In Unix Date Format

isInherited             Boolean    [Read-Only] Indicates whether an artifact is inherited.
mimeContentType         String     [Read-Only] Standard MIME content type derived from file extension.
fileSize                String     [Read-Only] File size of attached artifact.

* May also accept custom artifact type or category values set by system administrators.

The request body of a POST request through the Artifact Endpoint accepts a single binary file with file extension.zip only.

This accepted .zip file should contain one or more files corresponding to existing artifacts or new artifacts that will be created upon successful receipt.

Filename uniqueness throughout eMASS will be enforced by the API.

Upon successful receipt of a file, if a file within the .zip is matched via filename to an artifact existing within the application, the file associated with the artifact will be updated.

If no artifact is matched via filename to the application, a new artifact will be created with the following default values. Any values not specified below will be blank.
  - isTemplate: false
  - type: other
  - category: evidence

To update values other than the file itself, please submit a PUT request.

Business Rules
- Artifact cannot be saved if the file does not have the following file extensions:
  - .docx,.doc,.txt,.rtf,.xfdl,.xml,.mht,.mhtml,.html,.htm,.pdf
  - .mdb,.accdb,.ppt,.pptx,.xls,.xlsx,.csv,.log
  - .jpeg,.jpg,.tiff,.bmp,.tif,.png,.gif
  - .zip,.rar,.msg,.vsd,.vsw,.vdx, .z{#}, .ckl,.avi,.vsdx
- Artifact cannot be saved if File Name (fileName) exceeds 1,000 characters
- Artifact cannot be saved if Description (description) exceeds 2,000 characters
- Artifact cannot be saved if Reference Page Number (refPageNumber) exceeds 50 characters
- Artifact cannot be saved if the file does not have an allowable file extension/type.
- Artifact version cannot be saved if an Artifact with the same file name already exist in the system.
- Artifact cannot be saved if the file size exceeds 30MB.
- Artifact cannot be saved if the Last Review Date is set in the future.


Example:

bundle exec exe/emasser post artifacts upload --systemId [value] [--isTemplate or --no-isTemplate] --type [value] --category [value] --files[value...value]

Note: The example does not list any optional fields
