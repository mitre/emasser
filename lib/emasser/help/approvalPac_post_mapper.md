Submit system package for review

Endpoint request parameters/fields

Field         Data Type  Details
-------------------------------------------------------------------------------------------------
systemId      Integer    [Required] Unique system identifier 
type          String     [Required] Values include the following: (Assess and Authorize
                                    Assess Only, Security Plan Approval)
name          String     [Required] Package name. 100 Characters.
currentRole   String     [Read-Only] Current role in active package.
currentStep   Integer    [Read-Only] Current step in the package Approval Chain.
totalSteps    Integer    [Read-Only] Total number of steps in Package Approval Chain.
comments      String     [Required] Comments related to package approval chain. 4000 Characters.

Example:

bundle exec exe/emasser post approval pac --systemId [value] --type [value] --name [value] --comments [value]