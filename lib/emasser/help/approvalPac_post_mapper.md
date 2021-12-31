Submit system package for review

Endpoint request parameters/fields

Field         Data Type  Details
-------------------------------------------------------------------------------------------------
systemId      Integer    [Required] Unique system identifier 
workflow      String     [Required] Values include the following: (Assess and Authorize
                                    Assess Only, Security Plan Approval)
name          String     [Required] Package name. 100 Characters.
comments      String     [Required] Comments related to package approval chain. 4000 Characters.

currentRole   String     [Read-Only] Current role in active package.
currentStep   Integer    [Read-Only] Current step in the package Approval Chain.
totalSteps    Integer    [Read-Only] Total number of steps in Package Approval Chain.


Example:
If running from source code:
  bundle exec [ruby] exe/emasser post pac add --systemId [value] --workflow [value] --name [value] --comments [value]
If running from gem:
  emasser post pac add --systemId [value] --workflow [value] --name [value] --comments [value]
