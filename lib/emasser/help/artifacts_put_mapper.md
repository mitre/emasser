Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique eMASS identifier. Will need to provide correct number.
filename                String     [Required] File name should match exactly one file within the provided zip file.
                        Binary     [Required] Application/zip file. Max 30MB per artifact.
isTemplate              Boolean    [Required] Indicates whether an artifact is a template.
type*                   String     [Required] Values include the following: (Procedure, Diagram, Policy, Labor,
                                              Document, Image, Other, Scan Result, Auditor Report)
category*               String     [Required] Values include the following: (Implementation Guidance, Evidence)

description             String     [Optional] Artifact description. 2000 Characters.
refPageNumber           String     [Optional] Artifact reference page number. 50 Characters.
ccis                    String     [Optional] CCIs associated with artifact.
controls                String     [Optional] Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined.
artifactExpirationDate  Date       [Optional] Date Artifact expires and requires review. In Unix Date Format
lastReviewedDate        Date       [Optional] Date Artifact was last reviewed. In Unix Date Format

isInherited             Boolean    [Read-Only] Indicates whether an artifact is inherited.
mimeContentType         String     [Read-Only] Standard MIME content type derived from file extension.
fileSize                String     [Read-Only] File size of attached artifact.

* May also accept custom artifact category values set by system administrators.


Updates one artifact in a system - the API endpoint provide the capability of updating multiple artifacts concurrently, however this CLI only supports updating one Artifact at the time.

The file name provided should match exactly one file within the previously uploaded zip file.


Example:

bundle exec exe/emasser put artifacts update --systemId [value] [--isTemplate or --no-isTemplate] --type [value] --category [value] --files[value...value]
