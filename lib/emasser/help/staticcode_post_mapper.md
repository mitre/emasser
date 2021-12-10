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

rawSeverity*            String     [Optional] Values include the following: (Low, Medium, Moderate, High, Critical)
count                   Integer    [Optional] Number of instances observed for a specified finding

*rawSeverity: In eMASS, values of "Critical" will appear as "Very High", and values of “Medium” will appear as "Moderate". Any values not listed as options in the list above will map to “Unknown” and appear as blank values.

Example:

bundle exec exe/emasser post scan_findings add --systemId [value] --applicationName [value] --version [value] --codeCheckName [value] --scanDate [value] --cweId [value]
