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
* [/api](#get-test-connection)
* [/api/system](#get-system)
* [/api/systems](#get-systems)
* [/api/system-roles](#get-roles)
* [/api/system-roles/{roleCategory}](#get-roles)
* [/api/systems/{systemId}/controls](#get-controls)
* [/api/systems/{systemId}/test-results](#get-test_results)
* [/api​/systems​/{systemId}​/poams](#get-poams)
* [/api/systems/{systemId}/poams/{poamId}](#get-poams)
* [/api/systems/{systemId}/poams/{poamId}/milestones](#get-milestones)
* [/api/systems/{systemId}/poams/{poamId}/milestones/{milestoneId})](#get-milestones)
* [/api/systems/{systemId}/artifacts](#get-artifacts)
* [/api/systems/{systemId}/artifacts-export](#get-artifacts)
* [/api/systems/{systemId}/approval/cac](#get-approval)
* [/api/systems/{systemId}/approval/pac](#get-approval)
* [/api/cmmc-assessments](#get-cmmc)
* [/api/workflow-definitions](#get-workflow_definitions)
* [/api/systems/{systemId}/workflow-instances](#get-workflow_instances)

### POST
* [/api/systems/{systemId}/test-results](#post-test_results)
* [/api/systems/{systemId}/poam](#post-poams)
* [/api/systems/{systemId}/poam/{poamId}/milestones](#post-milestones)
* [/api/systems/{systemId}/artifacts](#post-artifacts)
* [/api/systems/{systemId}/approval/cac](#post-approval)
* [/api/systems/{systemId}/approval/pac](#post-approval)
  
### PUT
* [/api/systems/{systemId}/controls](#put-controls)

## Endpoints CLI help
Each CLI endpoint command has several layers of help. 
- Using `help` after a `get, put, post, or delete` command lists all available endpoint calls

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

**The same format is applicable to POST and PUT requests as well, however there may be additional help content**


## Common Endpoint Requests Information
  - To invoke any boolean parameters use --fieldName for TRUE and --no-fieldName for FALSE

## Usage - GET

## ```get test connection```
[top](#api-endpoints-provided)

---
The Test Connection endpoint provides the ability to verify connection to the web service.

    $ bundle exec exe/emasser get test connection

A return of success from the call indicates that the CLI can reach the configure server URL.
References [Required Environment Variables](#required-environment-variables) list above.

## ```get system```
[top](#api-endpoints-provided)

---
The `get system id` is a notified call by the CLI to find a system ID based on the system `name` or `owner`

The `get system byId` is an eMASS GET request

### get system id
Retrieves a system identification based on the SYSTEM_NAME (name) or SYSTEM_OWNER (systemOwner) fields.

**NOTE** This call is based on the /api/systems endpoint

To invoke the `get system` use the following command:

    $ bundle exec exe/emasser get system id --system_name "system name" --system_owner "system owner"

If using a platform that has `awk` installed the following command can be used to return only the system Id:

    $ bundle exec exe/emasser get system --system_name "system name" --system_owner "system owner" | awk "{ print $1 }" 


### get system byId
To view a system  by its identification (Id) use the following command:

    $ bundle exec exe/emasser get system byId

  - required parameter is:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |
- Optional parameters are:
    |parameter               | type or values                          |
    |------------------------|:----------------------------------------|
    |--includePackage        |BOOLEAN - true or false                  |
    |--policy                |Possible values: diacap, rmf, reporting  |


## ```get systems```
[top](#api-endpoints-provided)

----
To view systems use the following command:

    $ bundle exec exe/emasser get systems all
- Optional parameters are:
    |parameter               | type or values                                                              |
    |------------------------|:----------------------------------------------------------------------------|
    |--coamsId               |Cyber Operational Attributes Management System (COAMS) string Id             |   
    |--ditprId               |DoD Information Technology (IT) Portfolio Repository (DITPR) string id       |     
    |--includeDecommissioned |BOOLEAN - true or false                                                      |    
    |--includeDitprMetrics   |BOOLEAN - true or false                                                      |
    |--includePackage        |BOOLEAN - true or false                                                      |
    |--policy                |Possible values: diacap, rmf, reporting                                      |
    |--registrationType      |Possible values: assessAndAuthorize, assessOnly, guest, regular, functional, |
    |                        |                 loudServiceProvider, commonControlProvider                  |
    |--reportsForScorecard   |BOOLEAN - true or false                                                      |
  


## ```get roles```
[top](#api-endpoints-provided)

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

  - optional parameter are:
    |parameter               | type or values                          |
    |------------------------|:----------------------------------------|
    |--policy                |Possible values: diacap, rmf, reporting  |
    |--includeDecommissioned |BOOLEAN - true or false                  |
    
## ```get controls```
[top](#api-endpoints-provided)

----
To view controls use the following command:

    $ bundle exec exe/emasser get controls forSystem --systemId=SYSTEMID

  - required parameter is:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |

  - optional parameter is:
    |parameter    | type or values                            |
    |-------------|:------------------------------------------|
    |--acronyms   |The system acronym(s) e.g "AC-1, AC-2" - if not provided all controls for systemId are returned |

## ```get test_results```
[top](#api-endpoints-provided)

----
To view test results use the following command:

    $ bundle exec exe/emasser get test_results forSystem --systemId=SYSTEMID

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
[top](#api-endpoints-provided)

----
There are two get endpoints for system poams:
- forSystem - Retrieves all poams for specified system ID
    ````
    $ bundle exec exe/emasser get poams forSystem --systemId=SYSTEMID
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

## ```get milestones```
[top](#api-endpoints-provided)

----
There are two get endpoints for system milestones:
- byPoamId - Retrieves milestone(s) for specified system and poam ID
    ````
    $ bundle exec exe/emasser get milestones byPoamId --systemId=SYSTEMID --poamId=POAMID
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
[top](#api-endpoints-provided)

----
There are two get endpoints that provides the ability to view existing `Artifacts` in a system:

- forSystem - Retrieves one or many artifacts in a system specified system ID
    ````
    $ bundle exec exe/emasser get artifacts forSystem --systemId=SYSTEMID
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
[top](#api-endpoints-provided)

----
Two endpoints are provided, one to view Security Controls’ locations in
the Control Approval Chain (CAC) in a system, the other to view the location 
of a system's package in the Package Approval Chain (PAC).

- cac - Retrieves one or many Control Approval Chain (CAC) in a system specified system ID
    ````
    $ bundle exec exe/emasser get cac controls --systemId=SYSTEMID
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
    $ bundle exec exe/emasser get pac package --systemId=SYSTEMID
    ````
  - required parameter is:
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |--systemId   |Integer - Unique system identifier |




## ```get cmmc```
[top](#api-endpoints-provided)

----
To view Cybersecurity Maturity Model Certification (CMMC) Assessments use the following command:

    $ bundle exec exe/emasser get workflow_definitions forSite --sinceDate=SINCEDATE 

  - Required parameters are:
    |parameter       | type or values                        |
    |----------------|:--------------------------------------|
    |--sinceDate     |Date - The CMMC date. Unix date format |

## ```get workflow_definitions```
[top](#api-endpoints-provided)

----
To view Workflow Definitions use the following command:

    $ bundle exec exe/emasser get workflow_definitions forSite

  - Optional parameters are:
    |parameter            | type or values                                                              |
    |---------------------|:----------------------------------------------------------------------------|
    |--includeInactive    |BOOLEAN - true or false                                                      |    
    |--registrationType   |Possible values: assessAndAuthorize, assessOnly, guest, regular, functional, |
    |                     |                 loudServiceProvider, commonControlProvider                  |

## ```get workflow_instances```
[top](#api-endpoints-provided)

----
There are two get endpoints to view workflow instances:
  - forSystem
    $ bundle exec exe/emasser get workflow_instances forSystem --systemId=SYSTEMID

    - required parameter is:
      |parameter    | type or values                    |
      |-------------|:----------------------------------|
      |--systemId   |Integer - Unique system identifier |

    - Optional parameters are:
      |parameter          | type or values                                     |
      |-------------------|:---------------------------------------------------|
      |--includeComments  |BOOLEAN - true or false                             |    
      |--pageIndex        |Integer - The page number to query                  |
      |--sinceDate        |Date - The Workflow Instance date. Unix date format |
      |--status           |Possible values: active, inactive, all              | 

  - byWorkflowInstanceId
    $ bundle exec exe/emasser get workflow_instances byWorkflowInstanceId --systemId=SYSTEMID --workflowInstanceId=--WORKFLOWID

    - required parameter is:
      |parameter            | type or values                               |
      |---------------------|:---------------------------------------------|
      |--systemId           |Integer - Unique system identifier            |
      |--workflowInstanceId |Integer - Unique workflow instance identifier |

## Usage - POST
## ``post test_results``
[top](#api-endpoints-provided)

---
Test Result add (POST) endpoint API business rules.

  |Business Rule                                                        | Parameter/Field  |
  |---------------------------------------------------------------------|:-----------------|
  | Tests Results cannot be saved if the “Test Date” is in the future.  | `testDate` |
  | Test Results cannot be saved if a Security Control is “Inherited” in the system record. | `description` |
  | Test Results cannot be saved if an Assessment Procedure is “Inherited” in the system record. | `description` |
  | Test Results cannot be saved if the AP does not exist in the system. | `description` |
  | Test Results cannot be saved if the control is marked “Not Applicable” by an Overlay. | `description` |
  | Test Results cannot be saved if the control is required to be assessed as “Applicable” by an Overlay.| `description` |
  | Test Results cannot be saved if the Tests Results entered is greater than 4000 characters.|`description`|
  | Test Results cannot be saved if the following fields are missing data: | `complianceStatus`, `testDate`, `testedBy`, `description`|
  | Test results cannot be saved if there is more than one test result per CCI |`cci`|

---
To add (POST) test results use the following command:

  ````
  $ bundle exec exe/emasser post test_results add --systemId [value] --cci [value] --testedBy [value] --testDate [value] --description [value] --complianceStatus [value]
  ````
Note: If no POA&Ms or AP exist for the control (system), you will get this response:
"You have entered a Non-Compliant Test Result. You must create a POA&M Item for this Control and/or AP if one does not already exist."

  - required parameter are:
    |parameter          | type or values                                              |
    |-------------------|:------------------------------------------------------------|
    |--systemId         |Integer - Unique system identifier                           |
    |--cci              |String - CCI associated with the test result. e.g "00221"    |
    |--testedBy         |String - Last Name, First Name. 100 Characters.              |
    |--testDate         |Date - Unix time format (e.g. 1499990400)                    |
    |--description      |String - Include description of test result. 4000 Characters |
    |--complianceStatus |Possible values: Compliant, Non-Compliant, Not Applicable    |

**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser post test_results help add
```


## ``post poams``
[top](#api-endpoints-provided)

---
Plan of Action and Milestones (POA&M) add (POST) endpoint API business rules.

The following fields are required based on the contents of the status field
  |status          |Required Fields
  |----------------|--------------------------------------------------------
  |Risk Accepted   |comments 
  |Ongoing         |scheduledCompletionDate, milestones (at least 1)
  |Completed       |scheduledCompletionDate, comments, completionDate, milestones (at least 1)
  |Not Applicable  |POAM can not be created

If a POC email is supplied, the application will attempt to locate a user
already registered within the application and pre-populate any information
not explicitly supplied in the request. If no such user is found, these
fields are required within the request.
  - pocOrganization, pocFirstName, pocLastName, pocEmail, pocPhoneNumber

Business logic, the following rules apply when adding POA&Ms

- POA&M Items cannot be saved if associated Security Control or AP is inherited.
- POA&M Items cannot be created manually if a Security Control or AP is Not Applicable.
- Completed POA&M Item cannot be saved if Completion Date is in the future.
- Completed POA&M Item cannot be saved if Completion Date (completionDate) is in the future.
- Risk Accepted POA&M Item cannot be saved with a Scheduled Completion Date or Milestones
- POA&M Items with a review status of “Not Approved” cannot be saved if Milestone Scheduled Completion Date exceeds POA&M Item  Scheduled Completion Date.
- POA&M Items with a review status of “Approved” can be saved if Milestone Scheduled Completion Date exceeds POA&M Item Scheduled Completion Date.
- POA&M Items that have a status of “Completed” and a status of “Ongoing” cannot be saved without Milestones.
- POA&M Items that have a status of “Risk Accepted” cannot have milestones.
- POA&M Items with a review status of “Approved” that have a status of “Completed” and “Ongoing” cannot update Scheduled Completion Date.
- POA&M Items that have a review status of “Approved” are required to have a Severity Value assigned.
- POA&M Items cannot be updated if they are included in an active package.
- Archived POA&M Items cannot be updated.
- POA&M Items with a status of “Not Applicable” will be updated through test result creation.
- If the Security Control or Assessment Procedure does not exist in the system we may have to just import POA&M Item at the System Level.


The following parameters/fields have the following character limitations:
- POA&M Item cannot be saved if the Point of Contact fields exceed 100 characters:
  - Office / Organization (pocOrganization)
  - First Name            (pocFirstName)
  - Last Name             (pocLastName)
  - Email                 (email)
  - Phone Number          (pocPhoneNumber)
- POA&M Items cannot be saved if Mitigation field (mitigation) exceeds 2000 characters.
- POA&M Items cannot be saved if Source Identifying Vulnerability field exceeds 2000 characters.
- POA&M Items cannot be saved if Comments (comments) field exceeds 2000 characters 
- POA&M Items cannot be saved if Resource (resource) field exceeds 250 characters.
- POA&M Items cannot be saved if Milestone Description exceeds 2000 characters.


To add (POST) POA&Ms use the following command:
```
$ bundle exec exe/emasser post poams add --systemId [value] --status [value] --vulnerabilityDescription [value] --sourceIdentVuln [value] --pocOrganization [value] --resources [value]
```
**Note:** The example is only showing the required fields. Refer to instructions listed above for conditional and optional fields requirements.

  - required parameter are:
    |parameter                  | type or values                                                         |
    |---------------------------|:-----------------------------------------------------------------------|
    |--systemId                 |Integer - Unique system identifier                                      |
    |--status                   |Possible Values: Ongoing,Risk Accepted,Completed,Not Applicable         |
    |--vulnerabilityDescription |String - Vulnerability description for the POA&M Item. 2000 Characters  |
    |--sourceIdentVuln          |String - Include Source Identifying Vulnerability text. 2000 Characters |
    |--pocOrganization          |String - Organization/Office represented. 100 Characters                |
    |--resources                |String - List of resources used. Character Limit = 250                  |

    ** If any poc information is provided all POC fields are required. See additional details for POC fields below.

  - conditional parameters are:
    |parameter                 | type or values                                                                        |
    |--------------------------|:--------------------------------------------------------------------------------------|
    |--milestones              |JSON -  see milestone format                                                           |
    |--pocFirstName            |String - First name of POC. 100 Characters                                             |
    |--pocLastName             |String - Last name of POC. 100 Characters                                              |
    |--pocEmail                |String - Email address of POC. 100 Characters                                          | 
    |--pocPhoneNumber          |String - Phone number of POC (area code) ***-**** format. 100 Characters               |     
    |--severity                |Possible values - Very Low, Low, Moderate, High, Very High                             |
    |--scheduledCompletionDate |Date - Required for ongoing and completed POA&M items. Unix time format                |
    |--completionDate          |Date - Field is required for completed POA&M items. Unix time format                   |
    |--comments                |String - Field is required for completed and risk accepted POA&M items. 2000 Characters|

    ** If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request:
      pocFirstName, pocLastName, pocPhoneNumber

    Milestone Format:
      - --milestone description:[value] scheduledCompletionDate:[value]

  - optional parameters are:
    |parameter           | type or values                                                                           |
    |--------------------|:-----------------------------------------------------------------------------------------|
    |--externalUid       |String - External unique identifier for use with associating POA&M Items. 100 Characters  |
    |--controlAcronym    |String - Control acronym associated with the POA&M Item. NIST SP 800-53 Revision 4 defined|
    |--cci               |String - CCI associated with the test result                                              |
    |--securityChecks    |String - Security Checks that are associated with the POA&M                               |
    |--rawSeverity       |Possible values: I, II, III                                                               |
    |--resources         |String - List of resources used. 250 Characters                                           |
    |--relevanceOfThreat |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--likelihood        |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--impact            |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--impactDescription |String - Include description of Security Control’s impact                                 |
    |--residualRiskLevel |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--recommendations   |String - Include recommendations. Character Limit 2,000                                   |
    |--mitigation        |String - Include mitigation explanation. 2000 Characters                                  |


**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser post poams help add
```

## ``post milestones``
[top](#api-endpoints-provided)

---
To add (POST) milestones in a system for one or more POA&M items use the following command:

````
  $ bundle exec exe/emasser post poams add_milestones --systemId [value] --poamId [value] --description [value] --scheduledCompletionDate [value]
````
  - required parameter are:
    |parameter                  | type or values                                      |
    |---------------------------|:----------------------------------------------------|
    |--systemId                 |Integer - Unique system identifier                   |
    |--poamId                   |Integer - Unique item identifier                     |
    |--description              |String - Milestone item description. 2000 Characters |
    |--scheduledCompletionDate  |Date - Schedule completion date. Unix date format    |

  - optional parameter are:
    |parameter     | type or values                                      |
    |--------------|:----------------------------------------------------| 
    |--isActive    |Boolean - Set to false only in the case where POA&M PUT would delete specified milestone. Not available for other requests|

**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser post poams help add_milestones
```


## ``post artifacts``
[top](#api-endpoints-provided)

---
The add (POST) artifacts endpoint accepts a single binary file with file extension.zip only. The command line (CI) reads zips the files provided into a zip file.

Business Rules:
```
Filename uniqueness throughout eMASS will be enforced by the API.
```

```
Upon successful receipt of a file, if a file within the .zip is matched via filename to an artifact existing within the application, the file associated with the artifact will be updated.
```

```
If no artifact is matched via filename to the application, a new artifact will be created with the following default values. Any values not specified below will be blank.
  - isTemplate: false
  - type: other
  - category: evidence
```

```
Artifact cannot be saved if the file does not have the following file extensions:
  - .docx,.doc,.txt,.rtf,.xfdl,.xml,.mht,.mhtml,.html,.htm,.pdf
  - .mdb,.accdb,.ppt,.pptx,.xls,.xlsx,.csv,.log
  - .jpeg,.jpg,.tiff,.bmp,.tif,.png,.gif
  - .zip,.rar,.msg,.vsd,.vsw,.vdx, .z{#}, .ckl,.avi,.vsdx
```

Posting artifacts can be accomplished by invoking the following command:

```
$ bundle exec exe/emasser post artifacts upload --systemId [value] [--isTemplate or --no-isTemplate] --type [value] --category [value] --files[value...value]
```

  - required parameter are:
    |parameter       | type or values                                      |
    |----------------|:----------------------------------------------------|
    |--systemId      |Integer - Unique system identifier                   |
    |--isTemplate    |Boolean - Indicates whether an artifact is a template|
    |--type          |Possible Values: Procedure, Diagram, Policy, Labor, Document, Image, Other, Scan Result, Auditor Report|
    |--category      |Possible Values: Implementation Guidance, Evidence    |

  - optional parameter are:
    |parameter                | type or values                                        |
    |-------------------------|:------------------------------------------------------| 
    |--description            |String - Artifact description. 2000 Characters         |
    |--refPageNumber          |String - Artifact reference page number. 50 Characters |
    |--ccis                   |String -  CCIs associated with artifact                |
    |--controls               |String - Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined|
    |--artifactExpirationDate |Date - Date Artifact expires and requires review. In Unix Date Format|
    |--lastReviewedDate       |Date - Date Artifact was last reviewed. In Unix Date Format          |


**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser post artifacts help upload
```


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
The following Business Rules apply when adding (POST) Controls:

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
    |--comments                |String - Security control comments                                        |            
  
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
For information at the command line use: 
```
$ bundle exec exe/emasser put controls help update
```

## ``put poams``
---

## ``put milestones``
---

## ``put artifacts``
---
To update values other than the file itself, please submit a PUT request.