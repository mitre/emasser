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
Artifact cannot be saved if the file does not have the following file extensions:
  - .docx,.doc,.txt,.rtf,.xfdl,.xml,.mht,.mhtml,.html,.htm,.pdf
  - .mdb,.accdb,.ppt,.pptx,.xls,.xlsx,.csv,.log
  - .jpeg,.jpg,.tiff,.bmp,.tif,.png,.gif
  - .zip,.rar,.msg,.vsd,.vsw,.vdx, .z{#}, .ckl,.avi,.vsdx

Example:

bundle exec exe/emasser post artifacts upload --systemId [value] --files[value...value]
