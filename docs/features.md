## CLI Features

### Required Environment Variables
Prior of invoking any API command, the following environment variables need to be set:
* EMASSER_API_KEY_API_KEY=`<API key>`
* EMASSER_API_KEY_USER_UID=`<unique identifier of the eMASS user EMASSER_API_KEY_API_KEY belongs to>`
* EMASSER_HOST=`<FQDN of the eMASS server>`
* EMASSER_KEY_FILE_PATH=`<path to your emass key in PEM format>`
* EMASSER_CERT_FILE_PATH=`<path to your emass certificate in PEM format>`
* EMASSER_KEY_PASSWORD=`<password for the key given in EMASSER_KEY_FILE_PATH>`

These variables can be set in the .env file (see the .env-example file)

## API Endpoints Provided

### GET
* [/api/system](#get-system)
* [/api/systems](#get-systems)
* [/api/system-roles](#get-roles)
* [/api/system-roles/{roleCategory}](#get-roles)
* [/api/systems/{systemId}/controls](#get-controls)
* [/api/systems/{systemId}/test-results](#get-testresults)
* [/api​/systems​/{systemId}​/poams](#get-poams)
* [/api/systems/{systemId}/poams/{poamId}](#get-poams)
* [/api/systems/{systemId}/poams/{poamId}/milestones](#get-poams)
* [/api/systems/{systemId}/poams/{poamId}/milestones/{milestoneId})](#get-poams)
* [/api/systems/{systemId}/artifacts](#get-artifacts)
* [/api/systems/{systemId}/artifacts-export](#get-artifacts)
* [/api/systems/{systemId}/approval/cac](#get-approval)
* [/api/systems/{systemId}/approval/pac](#get-approval)

### POST
* [/api/systems/{systemId}/artifacts](#upload)

### PUT
* [/api/systems/{systemId}/controls](#put-controls)

## Endpoints CLI help
Each CLI endpoint command has several layers of help. 
- Using `help` after the `get` command lists all available endpoint calls

    ```
    $ bundle exec exe/emasser get help
    ```

    would list all available `GET` endpoint Commands:

    - emasser get approval                                                       ...
    - emasser get artifacts                                                      ...
    - emasser get controls                                                       ...
    - emasser get help [COMMAND]                                                 ...
    - emasser get poams                                                          ...
    - emasser get roles                                                          ...
    - emasser get system [--system-name [SYSTEM_NAME]] [--system-owner [SYSTEM_OW...
    - emasser get systems [options]                                              ...
    - emasser get test_results                                                   ...

- Preceding any command with `help` provides help for the command

    ```
    $ bundle exec exe/emasser get help artifacts
    ```
    would list all available sub-commands and options for the `get artifacts` endpoint commands:
    - emasser get artifacts export --filename=FILENAME --systemId=N  # Get artifa...
    - emasser get artifacts help [COMMAND]                           # Describe s...
    - emasser get artifacts system --systemId=N                      # Get all sy...

- Using `help` after any command lists all available options 

    ```
    $ bundle exec exe/emasser get artifacts help export
    ```
    would list all available options for the `get artifacts export` endpoint command: 
    - Usage:
      - emasser get artifacts export --filename=FILENAME --systemId=N
    - Options:
      - --systemId=N          # A numeric value representing the system identification
      - --filename=FILENAME   # The artifact file name
      - --compress            # BOOLEAN - true or false.

**The same format is applicable to POST and PUT requests as well.**

## Usage - GET

## ```get system```
---
The GET system is provided for retrieving the system identification based on the SYSTEM_NAME (name) or SYSTEM_OWNER (systemOwner) fields.

**NOTE** This call is based on the /api/systems endpoint

To invoke the `get system` use the following command:

    $ bundle exec exe/emasser get system --system_name "system name" --system_owner "system owner"

If using a platform that has `awk` installed the following command can be used to return only the system Id:

    $ bundle exec exe/emasser get system --system_name "system name" --system_owner "system owner" | awk "{ print $1 }" 


## ```get systems```
----
To invoke the `get systems` use the following command:

    $ bundle exec exe/emasser get systems
- Optional parameters are:
    |parameter               | type or values                                                                                 |
    |------------------------|:-----------------------------------------------------------------------------------------------|
    |--includePackage        |BOOLEAN - true or false                                                                         |
    |--registrationType      |Possible values: assessAndAuthorize, assessOnly, guest, regular, functional,loudServiceProvider |
    |--ditprId               |DoD Information Technology (IT) Portfolio Repository (DITPR) string id                          |
    |--coamsId               |Cyber Operational Attributes Management System (COAMS) string Id                                |
    |--policy                |Possible values: diacap, rmf, reporting                                                         |
    |--includeDitprMetrics   |BOOLEAN - true or false                                                                         |
    |--includeDecommissioned |BOOLEAN - true or false                                                                         |


## ```get roles```
----
There are two get endpoints for system roles:
- all - Retrieves all available roles
    ```
    $ bundle exec exe/emasser get roles all
    ```
- byCategory - Retrieves roles based on the following required parameter:
    ````
    $ bundle exec exe/emasser get roles byCategory --roleCategory=ROLECATEGORY --role=ROLE
    ````
  - required parameters are:
    |parameter       | type or values                            |
    |:---------------|:------------------------------------------|
    |--roleCategory  |Possible values: PAC, CAC, Other           |
    |--role          |Possible values: AO, Auditor, Artifact Manager, C&A Team, IAO, ISSO, PM/IAM, SCA, User Rep (View Only), Validator (IV&V)|


  - optional parameter is:
    |parameter    | type or values                            |
    |-------------|:------------------------------------------|
    |--policy     |Possible values: diacap, rmf, reporting    |
    
## ```get controls```
----
To invoke the `get controls` use the following command:

    $ bundle exec exe/emasser get controls system --systemId=SYSTEMID

  - required parameter is:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |

  - optional parameter is:
    |parameter    | type or values                            |
    |-------------|:------------------------------------------|
    |--acronyms   |The system acronym(s) e.g "AC-1, AC-2" - if not provided all controls for systemId are returned |

## ```get test_results```
----
To invoke the `get test_results` use the following command:

    $ bundle exec exe/emasser get test_results system --systemId=SYSTEMID

  - required parameter is:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |

  - optional parameters are:
    |parameter          | type or values                            |
    |-------------------|:------------------------------------------|
    |--controlAcronyms  |String - The system acronym(s) e.g "AC-1, AC-2" |
    |--ccis             |String - The system CCIS string numerical value |
    |--latestOnly       |BOOLEAN - true or false|


## ```get poams```
----
There are four get endpoints for system poams:
- system - Retrieves all poams for specified system ID
    ````
    $ bundle exec exe/emasser get poams system --systemId=SYSTEMID
    ````
  - required parameter is:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |

  - optional parameters are:
    |parameter                      | type or values                                |
    |-------------------------------|:----------------------------------------------|
    |--scheduledCompletionDateStart |Date - Unix time format (e.g. 1499644800)      |
    |--scheduledCompletionDateEnd   |Date - Unix time format (e.g. 1499990400)      |
    |--controlAcronyms              |String - The system acronym(s) e.g "AC-1, AC-2"|
    |--ccis                         |String - The system CCIS string numerical value|
    |--systemOnly                   |BOOLEAN - true or false|

- byPoamId - Retrieves all poams for specified system and poam ID 
    ````
    $ bundle exec exe/emasser get poams byPoamId --systemId=SYSTEMID --poamId=POAMID
    ````
  - required parameters are:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |
    |--poamId     |Integer - Unique poam identifier   |

- milestones - Retrieves milestone(s) for specified system and poam ID
    ````
    $ bundle exec exe/emasser get poams milestones --systemId=SYSTEMID --poamId=POAMID
    ````
  - required parameters are:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |
    |--poamId     |Integer - Unique poam identifier   |

  - optional parameters are:
    |parameter                      | type or values                                |
    |-------------------------------|:----------------------------------------------|
    |--scheduledCompletionDateStart |Date - Unix time format (e.g. 1499644800)      |
    |--scheduledCompletionDateEnd   |Date - Unix time format (e.g. 1499990400)      |


- byMilestoneId, Retrieve milestone(s) for specified system, poam, and milestone ID"
    ````
    $ bundle exec exe/emasser get poams byMilestoneId --systemId=SYSTEMID --poamId=POAMID --milestoneId=MILESTONEID
    ````
  - required parameters are:
    |parameter     | type or values                       |
    |--------------|:-------------------------------------|
    |--systemId    |Integer - Unique system identifier    |
    |--poamId      |Integer - Unique poam identifier      |
    |--milestoneId |Integer - Unique milestone identifier |


## ```get artifacts```
----
There are two get endpoints that provides the ability to view existing `Artifacts` in a system:

- system - Retrieves one or many artifacts in a system specified system ID
    ````
    $ bundle exec exe/emasser get artifacts system --systemId=SYSTEMID
    ````
  - required parameter is:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |

  - optional parameters are:
    |parameter                      | type or values                                |
    |-------------------------------|:----------------------------------------------|
    |--filename                     |The artifact file name                         |
    |--controlAcronyms              |String - The system acronym(s) e.g "AC-1, AC-2"|
    |--ccis                         |String - The system CCIS string numerical value|
    |--systemOnly                   |BOOLEAN - true or false|

- export - Retrieves the file artifacts (if compress is true the file binary contents are returned, otherwise the file textual contents are returned.)
    ````
    $ bundle exec exe/emasser get artifacts export --systemId=SYSTEMID
    ````
  - required parameters are:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |
    |--filename   |The artifact file name             |
    |--compress   |BOOLEAN - true or false.           |


## ```get approval```
----
Two endpoints are provided, one to view Security Controls’ locations in
the Control Approval Chain (CAC) in a system, the other to view the location 
of a system's package in the Package Approval Chain (PAC).

- cac - Retrieves one or many Control Approval Chain (CAC) in a system specified system ID
    ````
    $ bundle exec exe/emasser get approval cac --systemId=SYSTEMID
    ````
  - required parameter is:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |
  
  - optional parameter is:
    |parameter                      | type or values                                |
    |-------------------------------|:----------------------------------------------|
    |--controlAcronyms              |String - The system acronym(s) e.g "AC-1, AC-2"|



- pac - Retrieves one or more Package Approval Chain (PAC) in a system specified system ID
    ````
    $ bundle exec exe/emasser get approval pac --systemId=SYSTEMID
    ````
  - required parameter is:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |

## Usage - POST
## ``post test_results``
---

## ``post poams``
---

## ``post milestones``
---

## ``post artifacts``
---
Posting artifacts can be accomplished by invoking the following command:

    $ bundle exec exe/emasser upload systemId [file1 ... filen]


## ``post approval``
----
Two endpoints are provided, one to add Security Controls’ locations in
the Control Approval Chain (CAC) for a system, the other to add the location 
of a system's package in the Package Approval Chain (PAC).
- cac
- pac

## Usage - PUT
## ``put controls``
---

The following fields are required:

If Implementation Status `implementationStatus` field value is `Planned` or `Implemented`
```
controlDesignation, estimatedCompletionDate, responsibleEntities, slcmCriticality, slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments
```
If Implementation Status `implementationStatus` field value is `Manually Inherited`
```
commoncontrolprovider, securityControlDesignation, estimatedCompletionDate, responsibleEntities, slcmCriticality, slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments
```

If Implementation Status `implementationStatus` field value is `Not Applicable`
```
naJustification, controlDesignation, responsibleEntities
```
---
If Implementation Status `implementationStatus` field value is `Inherited` only the following
  fields can be updated:
```
commonnControlProvider, controlDesignation
```
---
Implementation Plan information cannot be saved if the fields below exceed 2000 character limits:
```
naJustification, responsibleEntities, comments, slcmCriticality, slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments
```
---
Updating (PUT) a control can be accomplished by invoking the following command:

  ````
  $ bundle exec exe/emasser put controls update [PARAMETERS]
  ````
  - required parameter are:
    |parameter                 | type or values                                                           |
    |--------------------------|:-------------------------------------------------------------------------|
    |--systemId                |Integer - Unique system identifier                                        |
    |--acronym                 |String - The system acronym(s) e.g "AC-1, AC-2"                           |
    |--responsibleEntities     |String - Description of the responsible entities for the Security Control |
    |--controlDesignation      |Possible values: Common, System-Specific, or Hybrid                       |
    |--estimatedCompletionDate |Date - Unix time format (e.g. 1499990400)                                 |
    |--comments                |String - Security control comments                                          |                    
  
  - optional parameters are:
    |parameter              | type or values                                |
    |-----------------------|:----------------------------------------------|
    |--implementationStatus |Possible values: Planned, Implemented, Inherited, Not Applicable, or Manually Inherited|
    |--severity             |Possible values: Very Low, Low, Moderate, High, Very High |
    |--vulnerabiltySummary  |String - The security control vulnerability summary |
    |--recommendations      |String - The security control vulnerability recommendation |
    |--relevanceOfThreat    |Possible values: Very Low, Low, Moderate, High, Very High |
    |--likelihood           |Possible values: Very Low, Low, Moderate, High, Very High |
    |--impact               |Possible values: Very Low, Low, Moderate, High, Very High |
    |--impactDescription    |String, - Description of the security control impact |
    |--residualRiskLevel    |Possible values: Very Low, Low, Moderate, High, Very High |

  - conditional parameters are:
    |parameter               | type or values                                |
    |------------------------|:----------------------------------------------|
    |--commonControlProvider |Possible values: DoD, Component, Enclave|
    |--naJustification       |String - Justification for Security Controls deemed Not Applicable to the system |
    |--slcmCriticality       |String - Criticality of Security Control regarding SLCM |
    |--slcmFrequency         |Possible values - Constantly, Daily, Weekly, Monthly, Quarterly, Semi-Annually, Annually, or Undetermined |
    |--slcmMethod            |Possible values: Automated, Semi-Automated, Manual, or Undetermined |
    |--slcmReporting         |String - The System-Level Continuous Monitoring reporting |
    |--slcmTracking          |String - The System-Level Continuous Monitoring tracking |
    |--slcmComments          |String, - Additional comments for Security Control regarding SLCM |

**Note**
For information at the command line, issue the following command: 
```
$ bundle exec exe/emasser put controls help update
```
## ``put poams``
---

## ``put milestones``
---

## ``put artifacts``
---