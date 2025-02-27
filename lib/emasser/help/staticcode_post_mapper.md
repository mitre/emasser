Add static code scans into a system asset module

Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique system identifier
applicationName         String     [Required] Name of the software application that was assessed
version                 String     [Required] The version of the application
codeCheckName           String     [Required] Name of the software vulnerability or weakness
scanDate                Integer    [Required] The findings scan date - Unix time format
cweId                   String     [Required] The Common Weakness Enumerator (CWE) identifier


Example:

bundle exec exe/emasser post scan_findings add --systemId [value] --applicationName [value] --version [value] --codeCheckName [value] --scanDate [value] --cweId [value]
