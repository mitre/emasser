Submit system package for review

Endpoint request parameters/fields

Field         Data Type  Details
-------------------------------------------------------------------------------------------------
systemId      Integer    [Required] Unique system identifier 
workflow      String     [Required] Values include the following: (Assess and Authorize
                                    Assess Only, Security Plan Approval)
name          String     [Required] Package name. 100 Characters.
comments      String     [Required] Comments related to package approval chain. 4000 Characters.


Example:

bundle exec exe/emasser post pac add [-s, --systemId] <value> [-f, --workflow] <value> [-n, --name] <value> [-c --comments] <value>
