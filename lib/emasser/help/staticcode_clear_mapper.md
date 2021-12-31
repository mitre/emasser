Add static code scans into a system asset module

Endpoint request parameters/fields

Field            Data Type  Details
------------------------------------------------------------------------------------------
systemId         Integer    [Required] Unique system identifier
applicationName  String     [Required] Name of the software application that was assessed
version          String     [Required] The version of the application
clearFindings*   Boolean    [Required] To clear an application's findings set it to true

*The clearFindings field is an optional field, but required with a value of "True" to clear out all application findings for a single application/version pairing.
  
Example:
If running from source code:
  bundle exec [ruby] exe/emasser post scan_findings clear --systemId [value] --applicationName [value] --version [value] --clearFindings
If running from gem:
  emasser post scan_findings clear --systemId [value] --applicationName [value] --version [value] --clearFindings
