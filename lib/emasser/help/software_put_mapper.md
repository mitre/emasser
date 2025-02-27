Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique eMASS identifier. Will need to provide correct number.
softwareId              String     [Required] Unique software identifier.
softwareVendor          String     [Required] Vendor of the software asset. Character Limit = 100.
softwareName            String     [Required] Name of the software asset. Character Limit = 100.
version                 String     [Required] Version of the software asset. Character Limit = 100.

approvalDate            Date       [Conditional] Approval date of the software asset. If Approval Status is set to “Unapproved”
                                                 or “In Progress”, Approval Date will be set to null. Unix date format.

softwareType*           String     [Optional] Type of the software asset. Character Limit = 100.
parentSystem            String     [Optional] Parent system of the software asset. Character Limit = 100.
subsystem               String     [Optional] Subsystem of the software asset. Character Limit = 100.
network                 String     [Optional] Network of the software asset. Character Limit = 100.
hostingEnvironment      String     [Optional] Hosting environment of the software asset. Character Limit = 100.
softwareDependencies    String     [Optional] Dependencies for the software asset. Character Limit = 100.
cryptographicHash       String     [Optional] Cryptographic hash for the software asset. Character Limit = 100.
inServiceData           String     [Optional] In service data for the software asset. Character Limit = 100.
itBudgetUii             String     [Optional] IT budget UII for the software asset. Character Limit = 50.
fiscalYear              String     [Optional] Fiscal year (FY) for the software asset. Character Limit = 20.
popEndDate              Date       [Optional] Period of performance (POP) end date for the software asset. Unix time format.
licenseOrContract       String     [Optional] License or contract for the software asset. Character Limit = 250.
licenseTerm             String     [Optional] License term for the software asset. Character Limit = 100.
costPerLicense          Double     [Optional] Cost per license for the software asset. Number will be converted to display 2 decimal points.
totalLicenses           Integer    [Optional] Number of total licenses for the software asset.
totalLicenseCost        Double     [Optional] Total cost of the licenses for the software asset. Number will be converted to display 2 decimal points.
licensesUsed            Integer    [Optional] Number of licenses used for the software asset.
licensePoc              String     [Optional] Point of contact (POC) for the software asset. Character Limit = 100.
licenseRenewalDate      Date       [Optional] License renewal date for the software asset. Unix date format.
licenseExpirationDate   Date       [Optional] License expiration date for the software asset. Unix date format.
approvalStatus**        String     [Optional] Approval status of the software asset. Character Limit = 100.
releaseDate             Date       [Optional] Release date of the software asset. Unix date format.
maintenanceDate         Date       [Optional] Maintenance date of the software asset. Unix date format.
retirementDate          Date       [Optional] Retirement date of the software asset. Unix date format.
endOfLifeSupportDate    Date       [Optional] End of life/support date of the software asset. Unix date format.
criticalAsset           Boolean    [Optional] Indicates whether the asset is a critical information system asset. The default value is false.
location                String     [Optional] Location of the software asset Character Limit = 250.
purpose                 String     [Optional] Purpose of the software asset. Character Limit = 1,000.
extendedEndOfLifeSupportDate Date  [Optional] If set, the Extended End of Life/Support Date cannot occur prior to the End of Life/Support Date. Unix date format.
unsupportedOperatingSystem Boolean [Optional] Unsupported operating system. VA only.
unapprovedSoftwareFromTrm  Boolean [Optional] Unapproved software from TRM. VA only.
approvedWaiver             Boolean [Optional] Approved waiver. VA only.


* Software Type - default values include the following options, however custom values can be entered to create new options:
  COTS Application, GOTS Application, Office Automation, Security Application, Server Application, Web Application

** Approval Status default values include the following options, however custom values can be entered to create new options:
  Approved - DISA UC APL, Approved - FIPS 140-2, Approved - NIAP CCVES,
  Approved - NSA Crypto, Approved - NSA CSfC, In Progress, Unapproved


Example:

bundle exec exe/emasser post software update [-s, --systemId] <value> [-S --softwareId] <value> [-V, --softwareVendor] <value>  [-N, --softwareName] <value> [-v --version] <value>

Note: The example does not list any optional or conditional fields
