Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique eMASS identifier. Will need to provide correct number.
assetName               String     [Required] Name of the hardware asset.

publicFacingFqdn        String     [Conditional] Public facing FQDN. Only applicable if Public Facing is set to true.
publicFacingIpAddress   String     [Conditional] Public facing IP address. Only applicable if Public Facing is set to true.
publicFacingUrls        String     [Conditional] Public facing URL(s). Only applicable if Public Facing is set to true.

componentType*          String     [Optional] Component type of the hardware asset.
nickname                String     [Optional] Nickname of the hardware asset. Character Limit = 100.
assetIpAddress          String     [Optional] IP address of the hardware asset. Character Limit = 100.
publicFacing            Boolean    [Optional] Public facing is defined as any asset that is accessible from a commercial connection.
virtualAsset            Boolean    [Optional] Determine if this is a virtual hardware asset. The default value is false.
manufacturer            String     [Optional] Manufacturer of the hardware asset. Populated with “Virtual” by default if Virtual Asset is true,
                                              however this can be overridden. Character Limit = 100.
modelNumber             String     [Optional] Model number of the hardware asset. Populated with “Virtual” by default if Virtual Asset is true,
                                              however this can be overridden. Character Limit = 100.
serialNumber            String     [Optional] Serial number of the hardware asset. Populated with “Virtual” by default if Virtual Asset is true,
                                              however this can be overridden. Character Limit = 100.
OsIosFwVersion          String     [Optional] OS/iOS/FW version of the hardware asset. Character Limit = 100.
memorySizeType          String     [Optional] Memory size / type of the hardware asset. Character Limit = 100.
location                String     [Optional] Location of the hardware asset. Character Limit = 250.
approvalStatus**        String     [Optional] Approval status of the hardware asset.
criticalAsset           Boolean    [Optional] Indicates whether the asset is a critical information system asset. The default value is false.


* Component Types default values include the following options, however custom values can be entered to create new options:
  Firewall, IDS/IPS, KVM, Router, Server, Switch, Workstation
** Approval Status default values include the following options, however custom values can be entered to create new options:
  Approved - DISA UC APL, Approved - FIPS 140-2, Approved - NIAP CCVES,
  Approved - NSA Crypto, Approved - NSA CSfC, In Progress, Unapproved


Example:

bundle exec exe/emasser post hardware add [-s, --systemId] <value> [-a, --assetName] <value>

Note: The example does not list any optional or conditional fields
