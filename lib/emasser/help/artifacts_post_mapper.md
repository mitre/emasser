Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique eMASS identifier. Will need to provide correct number.
files*                  String     [Required] Artifact file(s) to post to the given system
isTemplate              Boolean    [Required] Indicates whether an artifact is a template.
type**                  String     [Required] Values include the following: (Procedure, Diagram, Policy, Labor,
                                              Document, Image, Other, Scan Result, Auditor Report)
category**              String     [Required] Values include the following: (Implementation Guidance, Evidence)


isBulk                  Boolean    [Optional] If no value is specified, the default is false, and an individual
                                              artifact file is expected. When set to true, a .zip file is expected
                                              which can contain multiple artifact files.

\* The CLI accepts a single (can be a zip file) or multiple files were the CLI archives them into a zip file.

** May also accept custom artifact type or category values set by system administrators.

The body of a request through the Artifacts POST endpoint accepts a single binary file.
Two Artifact POST methods are currently accepted: individual and bulk.

Filename uniqueness within an eMASS system will be enforced by the API for both methods.

For POST requests that should result in a single artifact, the request should include the file.

For POST requests that should result in the creation of many artifacts, the request should include
a single file with the extension ".zip" only and the parameter isBulk should be set to true.
This .zip file should contain one or more files corresponding to existing artifacts or new
artifacts that will be created upon successful receipt.

Upon successful receipt of one or many artifacts, if a file is matched via filename to an artifact
existing within the application, the file associated with the artifact will be updated.

If no artifact is matched via filename to the application, a new artifact will be created with
the following default values. Any values not specified below will be null.
  - isTemplate: false
  - type: other
  - category: evidence

To update values other than the file itself, please submit a PUT request.

Example:

bundle exec exe/emasser post artifacts upload [-s, --systemId] <value> [-f, --files] <value...value> [-B, --isBulk or --no-isBulk] -[-T, --isTemplate or --no-isTemplate] [-t, --type] <value> [-c, --category] <value>

Note: The example does not list any optional fields
