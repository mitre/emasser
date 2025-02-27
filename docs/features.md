# eMASSer CLI Features

## Environment Variables
To facilitate setting the required environment variables the `eMASSer `CLI utilized the zero-dependency module to load these variables from a `.env` file.  

### Configuring the `.env` File
An `.env-example` file is provided with the required and optional fields.

Modify the `.env_example` as necessary and save it as a `.env` file. 

Place the file on the  path where the `eMASSer` command is executed.

### Required and Optional Environment Variables
The following environment variables are required:
* EMASSER_API_KEY=`<The eMASS API key (api-key)>`
* EMASSER_HOST_URL=`<The Full Qualified Domain Name (FQDN) for the eMASS server>`
* EMASSER_KEY_FILE_PATH=`<The eMASS key.pem private key file in PEM format (.pem)>`
* EMASSER_CERT_FILE_PATH=`<The eMASS client.pem certificate file in PEM format (.pem)>`
* EMASSER_KEY_FILE_PASSWORD=`<Secret phrase used to protect the encryption key>`

Certain eMASS integrations may not require (the majority do) this variable:  
* EMASSER_USER_UID=`<The eMASS User Unique Identifier (user-uid)>` 

The following environment variables are optional*:
* EMASSER_CLIENT_SIDE_VALIDATION=`<Client side validation - true or false (default true)>`
* EMASSER_VERIFY_SSL=`<Verify SSL - true or false (default true)>`
* EMASSER_VERIFY_SSL_HOST=`<Verify host SSL - true or false (default true)>`
* EMASSER_DEBUGGING=`<Set debugging - true or false (default false)>`
* EMASSER_CLI_DISPLAY_NULL=`<Display null value fields - true or false (default true)>`
* EMASSER_EPOCH_TO_DATETIME=`<Convert epoch to data/time value - true or false (default false)>`
* EMASSER_DOWNLOAD_DIR=`<Directory where exported files are saved (default eMASSerDownloads)>?`


\* If not provided defaults are used

The proper format to set these variables in the `.env` files is as follows:
```bash
export [VARIABLE_NAME]='value'
```
***NOTE***
`eMASSer` requires authentication to an eMASS instance as well as authorization to use the eMASS API. This authentication and authorization is **not** a function of `eMASSer` and needs to be accomplished with the eMASS instances owner organization. Further information about eMASS credential requirements refer to [Defense Counterintelligence and Security Agency](https://www.dcsa.mil/is/emass/) about eMASS access.

---
## Common eMASSer Endpoint Requests Information
  - To invoke any boolean parameters use --parameterName for TRUE and --no-parameterName for FALSE
  - The eMASS API provides the capability of updating multiple entries within several endpoints, however the `eMASSer` CLI, in some cases only supports updating one entry at the time.

## Invoking eMASSer CLI Commands

The CLI invoke commands listed in this document shows them when executing from the source code (after a pull from GitHub). Please reference the [`eMASSer` README](https://mitre.github.io/emasser/) on how to invoke the CLI using other available executables (gem or docker).

## GET Endpoints
#### Test Connection
  * [/api](#get-test-connection)

#### System
  * [/api/system](#get-system)
  * [/api/systems](#get-systems)
  * [/api/systems/{systemId}](#get-system)

#### System Roles
  * [/api/system-roles](#get-roles)
  * [/api/system-roles/{roleCategory}](#get-roles)

#### Controls
  * [/api/systems/{systemId}/controls](#get-controls)

#### Test Results
  * [/api/systems/{systemId}/test-results](#get-test_results)

#### POA&Ms
  * [/api/systems/{systemId}/poams](#get-poams)
  * [/api/systems/{systemId}/poams/{poamId}](#get-poams)

#### Milestones
  * [/api/systems/{systemId}/poams/{poamId}/milestones](#get-milestones)
  * [/api/systems/{systemId}/poams/{poamId}/milestones/{milestoneId})](#get-milestones)

#### Artifacts
  * [/api/systems/{systemId}/artifacts](#get-artifacts)
  * [/api/systems/{systemId}/artifacts-export](#get-artifacts)

#### CAC
  * [/api/systems/{systemId}/approval/cac](#get-cac)

#### PAC
  * [/api/systems/{systemId}/approval/pac](#get-pac)

#### Hardware Baseline
  * [/api/systems/{systemId}/hw-baseline](#get-hardware)

#### Software Baseline
  * [/api/systems/{systemId}/sw-baseline](#get-software)
  
#### CMMC Assessment
  * [/api/cmmc-assessments](#get-cmmc)

#### Workflow Definition
  * [/api/workflow-definitions](#get-workflow_definitions)

#### Workflow Instances
  * [/api/systems/{systemId}/workflow-instances](#get-workflow_instances)

### [Dashboards](#get-dashboards)

 
## POST Endpoints
* [/api/api-key](#post-register-cert)
* [/api/systems/{systemId}/test-results](#post-test_results)
* [/api/systems/{systemId}/poam](#post-poams)
* [/api/systems/{systemId}/poam/{poamId}/milestones](#post-milestones)
* [/api/systems/{systemId}/artifacts](#post-artifacts)
* [/api/systems/{systemId}/approval/cac](#post-cac)
* [/api/systems/{systemId}/approval/pac](#post-pac)
* [/api/systems/{systemId}/hw-baseline](#post-hardware)
* [/api/systems/{systemId}/sw-baseline](#post-software)
* [/api/systems/{systemId}/device-scan-results](#post-device-scan-results)
* [/api/systems/{systemId}/cloud-resource-results](#post-cloud_resource)
* [/api/systems/{systemId}/container-scan-results](#post-container)
* [/api/systems/{systemId}/static-code-scans](#post-static_code_scan)


## PUT Endpoints
* [/api/systems/{systemId}/controls](#put-controls)
* [/api/systems/{systemId}/poams](#put-poams)
* [/api/systems/{systemId}/poams/{poamId}/milestones](#put-milestones)
* [/api/systems/{systemId}/artifacts](#put-artifacts)
* [/api/systems/{systemId}/hw-baseline](#put-hardware)
* [/api/systems/{systemId}/sw-baseline](#put-software)

## DELETE Endpoints
* [/api/systems/{systemId}/poams](#delete-poams)
* [/api/systems/{systemId}/poams/{poamId}/milestones](#delete-milestones)
* [/api/systems/{systemId}/artifacts](#delete-artifacts)
* [/api/systems/{systemId}/hw-baseline](#delete-hardware)
* [/api/systems/{systemId}/sw-baseline](#delete-software)
* [/api/systems/{systemId}/cloud-resource-results](#delete-cloud-resource)
* [/api/systems/{systemId}/container-scan-results](#delete-container)

# Endpoints CLI help

Each CLI endpoint command has several layers of help. 
- Using `help` after a `get, put, post, or delete` command lists all available endpoint calls. The following command would list all available `GET` endpoints commands.

    ```bash
    $ bundle exec exe/emasser get help
    Commands:
      emasser get artifacts             # Get system Artifacts
      emasser get cac                   # Get location of one or many controls in CAC
      emasser get cmmc                  # Get CMMC assessment information
      emasser get controls              # Get system Controls
      emasser get dashboards            # Get dashboard information
      emasser get hardware              # Get one or many hardware assets in a system
      emasser get milestones            # Get system Milestones
      emasser get pac                   # Get status of active workflows in a system
      emasser get poams                 # Get system Poams
      emasser get roles                 # Get all system roles or by category Id
      emasser get software              # Get one or many software assets in a system
      emasser get system                # Get a system ID given name/owner, or ge...
      emasser get systems               # Get all systems
      emasser get test                  # Test connection to the configured eMASS...
      emasser get test_results          # Get system Test Results
      emasser get workflow_definitions  # Get workflow definitions in a site
      emasser get workflow_instances    # Get workflow instance by system and/or ...
    ```
- Preceding any command with `help` provides help for the command. The following command would list all available sub-commands and options for the `get artifacts` endpoint command.
    ```bash
    $ bundle exec exe/emasser get help artifacts
    commands:
      emasser get artifacts export -f, --filename=FILENAME -s, --systemId=N  # Get artifa...
      emasser get artifacts forSystem -s, --systemId=N                       # Get all sy...
      emasser get artifacts help [COMMAND]                                   # Describe s...
    ```
- Using `help` after any command lists all available options. The following command would list all available options for the `get artifacts export` endpoint command. 
    ```bash
    $ bundle exec exe/emasser get artifacts help export
    Usage:
      emasser get artifacts export -f, --filename=FILENAME -s, --systemId=N

    Options:
      -s, --systemId=N                     # A numeric value representing the system identification
      -f, --filename=FILENAME              # The artifact file name
      -C, |compress], |no-compress]    # BOOLEAN - true or false.
      -o, |printToStdout=PRINTTOSTDOUT]  # Output file content to terminal - not valid for zip files      
    ```
**The same format is applicable for POST, PUT and DELETE requests as well, however there may be additional help content**


## Usage - GET
### ```get test connection``` 
---
The Test Connection endpoint provides the ability to verify connection to the web service.

    $ bundle exec exe/emasser get test connection

A return of success from the call indicates that the CLI can reach the configure server URL.
References [Required Environment Variables](#required-environment-variables) for the necessary environment variables.

[top](#test-connection)
### ```get system```

---
The `get system` command is not a sanctioned eMASS endpoint, it makes use of the `get systems` endpoint with added business logic.

There are two commands provided by the get system:

- The `get system id` - returns system ID's based on the system `name` or `owner`
- The `get system byId` - returns the system content for parameter system ID
### get system id
Retrieves a system identification based on the SYSTEM_NAME (name) or SYSTEM_OWNER (systemOwner) fields.

To invoke the `get system id` use the following command:

    $ bundle exec exe/emasser get system id --system_name "system name" --system_owner "system owner"

If using a platform that has `awk` installed the following command can be used to return only the system Id:

    $ bundle exec exe/emasser get system --system_name "system name" --system_owner "system owner" | awk "{ print $1 }" 
### get system byId
Retrieves the system content for provided identification (ID) number. To invoke the endpoint use  the following command:

    $ bundle exec exe/emasser get system byId

  - required parameter is:
  
      |parameter    | type or values                    |
      |-------------|:----------------------------------|
      |-s, --systemId   |Integer - Unique system identifier |

  - Optional parameters are:

    |parameter               | type or values                          |
    |------------------------|:----------------------------------------|
    |-I, --includePackage        |BOOLEAN - true or false                  |
    |-p, --policy                |Possible values: diacap, rmf, reporting  |

[top](#system)
### ```get systems```

----
To retrieve controls use the following command:
- all - Retrieves all available systems
    ```
    $ bundle exec exe/emasser get systems all
    ```

  - Optional parameters are:
  
    |parameter               | type or values                                                              |
    |------------------------|:----------------------------------------------------------------------------|
    |-c, --coamsId               |Cyber Operational Attributes Management System (COAMS) string Id             |   
    |-t, --ditprId               |DoD Information Technology (IT) Portfolio Repository (DITPR) string id       |
    |-r, --registrationType      |Possible values: assessAndAuthorize, assessOnly, guest, regular, functional, |
    |                            |                 cloudServiceProvider, commonControlProvider                 |    
    |-I, --includeDecommissioned |BOOLEAN - true or false                                                      |    
    |-M, --includeDitprMetrics   |BOOLEAN - true or false                                                      |
    |-P, --includePackage        |BOOLEAN - true or false                                                      |
    |-p, --policy                |Possible values: diacap, rmf, reporting                                      |
    |_S, --reportsForScorecard   |BOOLEAN - true or false                                                      |
  
[top](#system)
### ```get roles```

----
There are two get endpoints for system roles:
- all - Retrieves all available roles
    ```
    $ bundle exec exe/emasser get roles all
    ```
- byCategory - Retrieves roles based on the following required parameter:
    ````
    $ bundle exec exe/emasser get roles byCategory -c, --roleCategory=ROLECATEGORY -r, --role=ROLE
    ````
  - required parameters are:
  
    |parameter       | type or values                            |
    |:---------------|:------------------------------------------|
    |-c, --roleCategory  |Possible values: PAC, CAC, Other           |
    |-r, --role          |Possible values: AO, Auditor, Artifact Manager, C&A Team, IAO, ISSO, PM/IAM, SCA, User Rep (View Only), Validator (IV&V)|

  - optional parameter are:
  
    |parameter               | type or values                          |
    |------------------------|:----------------------------------------|
    |-p, --policy            |Possible values: diacap, rmf, reporting  |


[top](#system-roles)
### ```get controls```

----
To retrieve controls use the following command:

    $ bundle exec exe/emasser get controls forSystem -s, --systemId=SYSTEMID

  - required parameter is:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |

  - optional parameter is:

    |parameter      | type or values                            |
    |---------------|:------------------------------------------|
    |-a, --acronyms |The system acronym(s) e.g "AC-1, AC-2" - if not provided all controls for systemId are returned |

[top](#controls)
### ```get test_results```

----
To retrieve test results use the following command:

    $ bundle exec exe/emasser get test_results forSystem -s, --systemId=SYSTEMID

  - required parameter is:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |

  - optional parameters are:

    |parameter          | type or values                            |
    |-------------------|:------------------------------------------|
    |-a, --controlAcronyms     |String - The system acronym(s) e.g "AC-1, AC-2" |
    |-p, --assessmentProcedures|String - The system Security Control Assessment Procedure e.g "AC-1.1,AC-1.2"|
    |-c, --ccis                |String - The system CCIS string numerical value |
    |-L, --latestOnly          |BOOLEAN - true or false|

[top](#test-results)
### ```get poams```

----
There are two get endpoints for system poams:
- forSystem - Retrieves all poams for specified system ID
    ````
    $ bundle exec exe/emasser get poams forSystem -s, --systemId=SYSTEMID
    ````
  - required parameter is:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |

  - optional parameters are:

    |parameter                      | type or values                                |
    |-------------------------------|:----------------------------------------------|
    |-d, --scheduledCompletionDateStart |Date - Unix time format (e.g. 1499644800)      |
    |-e, --scheduledCompletionDateEnd   |Date - Unix time format (e.g. 1499990400)      |
    |-a, --controlAcronyms              |String - The system acronym(s) e.g "AC-1, AC-2"|
    |-p, --assessmentProcedures         |String - The system Security Control Assessment Procedure e.g "AC-1.1,AC-1.2"|
    |-c, --ccis                         |String - The system CCIS string numerical value|
    |-Y, --systemOnly                   |BOOLEAN - true or false|


- byPoamId - Retrieves all poams for specified system and poam ID 
    ````
    $ bundle exec exe/emasser get poams byPoamId -s, --systemId=SYSTEMID -p, --poamId=POAMID
    ````
  - required parameters are:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId |Integer - Unique system identifier |
    |-p, --poamId   |Integer - Unique poam identifier   |

[top](#poams)
### ```get milestones```

----
There are two get endpoints for system milestones:
- byPoamId - Retrieves milestone(s) for specified system and poam ID
    ````
    $ bundle exec exe/emasser get milestones byPoamId -s, --systemId=SYSTEMID -p, --poamId=POAMID
    ````
  - required parameters are:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |
    |-p, --poamId     |Integer - Unique poam identifier   |

  - optional parameters are:

    |parameter                      | type or values                                |
    |-------------------------------|:----------------------------------------------|
    |-d, --scheduledCompletionDateStart |Date - Unix time format (e.g. 1499644800)      |
    |-e, --scheduledCompletionDateEnd   |Date - Unix time format (e.g. 1499990400)      |


- byMilestoneId, Retrieve milestone(s) for specified system, poam, and milestone ID"
    ````
    $ bundle exec exe/emasser get poams byMilestoneId -s, --systemId=SYSTEMID -p, --poamId=POAMID -m, --milestoneId=MILESTONEID
    ````
  - required parameters are:

    |parameter     | type or values                       |
    |--------------|:-------------------------------------|
    |-s, --systemId    |Integer - Unique system identifier    |
    |-p, --poamId      |Integer - Unique poam identifier      |
    |-m, --milestoneId |Integer - Unique milestone identifier |

[top](#milestones)
### ```get artifacts```

----
There are two get endpoints that provides the ability to view existing `Artifacts` in a system:

- forSystem - Retrieves one or many artifacts in a system specified system ID
    ````
    $ bundle exec exe/emasser get artifacts forSystem -s, --systemId=SYSTEMID
    ````
  - required parameter is:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |

  - optional parameters are:

    |parameter                  | type or values                                |
    |---------------------------|:----------------------------------------------|
    |-f, --filename             |The artifact file name                         |
    |-a, --controlAcronyms      |String - The system acronym(s) e.g "AC-1, AC-2"|
    |-p, --assessmentProcedures |String - The system Security Control Assessment Procedure e.g "AC-1.1,AC-1.2"|
    |-c, --ccis                 |String - The system CCIS string numerical value|
    |-Y, --systemOnly           |BOOLEAN - true or false|


- export - Retrieves the file artifacts (if compress is true the file binary contents are returned, otherwise the file textual contents are returned.)
  ````
  $ bundle exec exe/emasser get artifacts export -s, --systemId=SYSTEMID
  ````
  - required parameters are:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |
    |-f, --filename   |The artifact file name             |
  
  - optional parameter is:
  
    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-C, --compress      |BOOLEAN - true or false.           |
    |-o, --printToStdout |BOOLEAN - true or false - Output file content to terminal - not valid for zip files|

[top](#artifacts)
### ```get cac```

----
To view one or many Control Approval Chain (CAC) in a system specified system ID use the following command:
  ```
  $ bundle exec exe/emasser get cac controls -s, --systemId=SYSTEMID
  ```
  - required parameter is:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |
  
  - optional parameter is:

    |parameter             | type or values                                |
    |----------------------|:----------------------------------------------|
    |-a, --controlAcronyms |String - The system acronym(s) e.g "AC-1, AC-2"|

[top](#cac)
### ```get pac```

----
To view one or many Package Approval Chain (PAC) in a system specified system ID use the following command:

  ````
  $ bundle exec exe/emasser get pac package -s, --systemId=SYSTEMID
  ````
  - required parameter is:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |

[top](#pac)
### ```get hardware```

---
To view Hardware Baseline assets use the following command:

  ````
  $ bundle exec exe/emasser get hardware assets -s, --systemId=SYSTEMID
  ````
  - required parameter is:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |

  - Optional flags (parameters) are:

    |parameter          | type or values                                                |
    |-------------------|:--------------------------------------------------------------|
    |-i, --pageIndex        |Integer - The index of the starting page (default first page 0)|
    |-s, --pageSize         |Integer - The number of entries per page (default 20000)       |

  
[top](#hardware-baseline)
### ```get software```

---
To view Software Baseline assets use the following command:

  ````
  $ bundle exec exe/emasser get software assets -s, --systemId=SYSTEMID
  ````
  - required parameter is:

    |parameter    | type or values                    |
    |-------------|:----------------------------------|
    |-s, --systemId   |Integer - Unique system identifier |
  
  - Optional flags (parameters) are:

    |parameter          | type or values                                                |
    |-------------------|:--------------------------------------------------------------|
    |-i, --pageIndex        |Integer - The index of the starting page (default first page 0)|
    |-s, --pageSize         |Integer - The number of entries per page (default 20000)       |

[top](#software-baseline)
### ```get cmmc```

----
To view Cybersecurity Maturity Model Certification (CMMC) Assessments use the following command:

    $ bundle exec exe/emasser get cmmc assessments -d, --sinceDate=SINCEDATE 

  - Required parameter is:

    |parameter       | type or values                        |
    |----------------|:--------------------------------------|
    |-d, --sinceDate |Date - The CMMC date. Unix date format |

[top](#cmmc-assessment)
### ```get workflow_definitions```

----
To view Workflow Definitions use the following command:

    $ bundle exec exe/emasser get workflow_definitions forSite

  - Optional parameters are:

    |parameter            | type or values                                                              |
    |---------------------|:----------------------------------------------------------------------------|
    |-I, --includeInactive  |BOOLEAN - true or false                                                      |    
    |-r, --registrationType |Possible values: assessAndAuthorize, assessOnly, guest, regular, functional, |
    |                       |                 cloudServiceProvider, commonControlProvider                 |

[top](#workflow-definition)
### ```get workflow_instances```

----
There are two get endpoints to view workflow instances:
  - all
    ```
    $ bundle exec exe/emasser get workflow_instances all
    ```
    - Optional parameters are:

      |parameter          | type or values                                     |
      |-------------------|:---------------------------------------------------|
      |-C, --includeComments            |BOOLEAN - true or false               |   
      |-D, --includeDecommissionSystems |BOOLEAN - true or false.              | 
      |-p, --pageIndex        |Integer - The page number to query              |
      |-d, --sinceDate        |Date - The Workflow Instance date. Unix date format |
      |-s, --status           |Possible values: active, inactive, all              | 

  - byInstanceId
    ```
    $ bundle exec exe/emasser get workflow_instances byInstanceId --workflowInstanceId=WORKFLOWID
    ```
    - required parameter is:

      |parameter            | type or values                               |
      |---------------------|:---------------------------------------------|
      |-w, --workflowInstanceId |Integer - Unique workflow instance identifier |

[top](#workflow-instances)
### ```get dashboards```

----
The Dashboards endpoints provide the ability to view data contained in dashboard exports. In the eMASS front end, these dashboard exports are generated as Excel exports.

All endpoint calls utilize the same parameter values, they are:
  - Required parameter is:

    |parameter     | type or values                                  |
    |--------------|:------------------------------------------------|
    |-o, --orgId       |Integer - The organization identification number |

  - Optional flags (parameters) are:

    |parameter          | type or values                                                |
    |-------------------|:--------------------------------------------------------------|
    |-I, --excludeInherited |BOOLEAN - If no value is specified, includes inherited data    |
    |-i, --pageIndex        |Integer - The index of the starting page (default first page 0)|
    |-s, --pageSize         |Integer - The number of entries per page (default 20000)       |

The following dashboard endpoint commands are available

```bash
  emasser get dashboards application_findings_details           # Get system ...
  emasser get dashboards application_findings_summary           # Get system ...
  emasser get dashboards artifacts_details                      # Get systems...
  emasser get dashboards artifacts_summary                      # Get systems...
  emasser get dashboards assessment_procedures_details          # Get systems...
  emasser get dashboards assignments_details                    # Get user sy...
  emasser get dashboards associations_details                   # Get system ...
  emasser get dashboards atc_iatc_details                       # Get systems...
  emasser get dashboards cmmc_compliance_summary                # Get CMMC As...
  emasser get dashboards cmmc_requirement_objectives_details    # Get CMMC As...
  emasser get dashboards cmmc_security_requirements_details     # Get CMMC As...
  emasser get dashboards cmmc_status_summary                    # Get CMMC As...
  emasser get dashboards coastguard_fisma_metrics               # Get coastgu...
  emasser get dashboards connectivity_ccsd_details              # Get systems...
  emasser get dashboards connectivity_ccsd_summary              # Get systems...
  emasser get dashboards control_compliance_summary             # Get systems...
  emasser get dashboards critical_assets_summary                # Get system ...
  emasser get dashboards device_findings_details                # Get system ...
  emasser get dashboards device_findings_summary                # Get system ...
  emasser get dashboards fisma_inventory_crypto_summary         # Get VA syst...
  emasser get dashboards fisma_inventory_summary                # Get VA syst...
  emasser get dashboards fisma_metrics                          # Get FISMA m...
  emasser get dashboards fisma_saop_summary                     # Get VA OMB-...
  emasser get dashboards hardware_details                       # Get system ...
  emasser get dashboards hardware_summary                       # Get system ...
  emasser get dashboards integration_status_summary             # Get system ...
  emasser get dashboards organization_migration_status_summary  # Get organiz...
  emasser get dashboards poam_details                           # Get system ...
  emasser get dashboards poam_summary                           # Get systems...
  emasser get dashboards ports_protocols_details                # Get system ...
  emasser get dashboards ports_protocols_summary                # Get system ...
  emasser get dashboards privacy_summary                        # Get user sy...
  emasser get dashboards questionnaire_details                  # Get systems...
  emasser get dashboards questionnaire_summary                  # Get systems...
  emasser get dashboards security_control_details               # Get systems...
  emasser get dashboards sensor_hardware_details                # Get system ...
  emasser get dashboards sensor_hardware_summary                # Get system ...
  emasser get dashboards sensor_software_counts                 # Get system ...
  emasser get dashboards sensor_software_details                # Get system ...
  emasser get dashboards sensor_software_summary                # Get system ...
  emasser get dashboards software_details                       # Get system ...
  emasser get dashboards software_summary                       # Get system ...
  emasser get dashboards status_details                         # Get systems...
  emasser get dashboards system_migration_status_summary        # Get system ...
  emasser get dashboards terms_conditions_details               # Get systems...
  emasser get dashboards terms_conditions_summary               # Get systems...
  emasser get dashboards threat_architecture_details            # Get VA Syst...
  emasser get dashboards threat_risk_details                    # Get VA Syst...
  emasser get dashboards threat_risk_summary                    # Get VA Syst...
  emasser get dashboards va_a2_summary                          # Get VA syst...
  emasser get dashboards va_aa_summary                          # Get VA syst...
  emasser get dashboards va_icamp_tableau_poam_details          # Get VA ICAM...
  emasser get dashboards va_pl_109_summary                      # Get VA Syst...
  emasser get dashboards vulnerability_summary                  # Get system ...
  emasser get dashboards workflows_history_details              # Get system ...
  emasser get dashboards workflows_history_stage_details        # Get system ...
  emasser get dashboards workflows_history_summary              # Get system ...
```
[top](#dashboards)


## Usage - POST

### ``post register cert``
---
The Registration endpoint provides the ability to register a certificate & obtain an API-key.

```
$ bundle exec exe/emasser post register cert
```

[top](#post-endpoints)
### ``post test_results``
---
Test Result add (POST) endpoint API business rules.

  |Business Rule                                                        | Parameter/Field  |
  |---------------------------------------------------------------------|:-----------------|
  | Tests Results cannot be saved if the "Test Date" is in the future.  | `testDate` |
  | Test Results cannot be saved if a Security Control is "Inherited" in the system record. | `description` |
  | Test Results cannot be saved if an Assessment Procedure is "Inherited" in the system record. | `description` |
  | Test Results cannot be saved if the Assessment Procedure does not exist in the system. | `description` |
  | Test Results cannot be saved if the control is marked "Not Applicable" by an Overlay. | `description` |
  | Test Results cannot be saved if the control is required to be assessed as "Applicable" by an Overlay.| `description` |
  | Test Results cannot be saved if the Tests Results entered is greater than 4000 characters.|`description`|
  | Test Results cannot be saved if the following fields are missing data: | `complianceStatus`, `testDate`, `testedBy`, `description`|

---
To add (POST) test results use the following command:

  ````
  $ bundle exec exe/emasser post test_results add [-s --systemId] <value> --assessmentProcedure <value> --testedBy <value> --testDate <value? --description <value> --complianceStatus <value>
  ````
Note: If no POA&Ms or Assessment Procedure exist for the control (system), you will get this response:
"You have entered a Non-Compliant Test Result. You must create a POA&M Item for this Control and/or AP if one does not already exist."

  - required parameter are:

    |parameter             | type or values                                                   |
    |----------------------|:-----------------------------------------------------------------|
    |-s, --systemId        |Integer - Unique system identifier                                |
    |--assessmentProcedure |String - The Security Control Assessment Procedure being assessed |
    |--testedBy            |String - Last Name, First Name. 100 Characters.                   |
    |--testDate            |Date - Unix time format (e.g. 1499990400)                         |
    |--description         |String - Include description of test result. 4000 Characters      |
    |--complianceStatus    |Possible values: Compliant, Non-Compliant, Not Applicable         |

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post test_results help add
```
[top](#post-endpoints)
### ``post poams``
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
- POA&M Items with a review status of "Not Approved" cannot be saved if Milestone Scheduled Completion Date exceeds POA&M Item  Scheduled Completion Date.
- POA&M Items with a review status of "Approved" can be saved if Milestone Scheduled Completion Date exceeds POA&M Item Scheduled Completion Date.
- POA&M Items that have a status of "Completed" and a status of "Ongoing" cannot be saved without Milestones.
- POA&M Items that have a status of "Risk Accepted" cannot have milestones.
- POA&M Items with a review status of "Approved" that have a status of "Completed" and "Ongoing" cannot update Scheduled Completion Date.
- POA&M Items that have a review status of "Approved" are required to have a Severity Value assigned.
- POA&M Items cannot be updated if they are included in an active package.
- Archived POA&M Items cannot be updated.
- POA&M Items with a status of "Not Applicable" will be updated through test result creation.
- If the Security Control or Assessment Procedure does not exist in the system we may have to just import POA&M Item at the System Level.


The following POA&M parameters/fields have the following character limitations:
- Fields that can not exceed 100 characters:
  - Office / Organization (`pocOrganization`)
  - First Name            (`pocFirstName`)
  - Last Name             (`pocLastName`)
  - Email                 (`email`)
  - Phone Number          (`pocPhoneNumber`)
  - External Unique ID    (`externalUid`)
- Fields that can not exceed 250 characters:
  - Resource              (`resource`)
- Fields have can not exceed 2000 character: 
  - Vulnerability Description        (`vulnerabilityDescription`)
  - Source Identifying Vulnerability (`sourceIdentVuln`)
  - Recommendations                  (`recommendations`)
  - Risk Accepted Comments           (`comments`) 
  - Milestone Description            (`description`)
  - Mitigation Justification         (`mitigation`)

To add (POST) POA&Ms use the following command:
```
$ bundle exec exe/emasser post poams add [-s, --systemId] <value> --status <value> --vulnerabilityDescription <value> --sourceIdentifyingVulnerability <value> --pocOrganization <value> --resources <value>
```
**Notes:** 
  - The above listed parameters/fields are the minimal required.
  - Based on the value for the status (--status) parameter additional fields are required
  - Refer to instructions listed above for conditional and optional fields requirements.
  - When a milestone is required the format is:
    - --milestone description:[value] scheduledCompletionDate:[value]
  
**If a milestone Id is provided (--milestone milestoneId:[value]) the POA&M with the provided milestone Id is updated and the new POA&M milestones is set to null.**

---
Client API parameters/fields (required, conditional, and optional).
  - required parameter are:

    |parameter                        | type or values                                                 |
    |---------------------------------|:---------------------------------------------------------------|
    |-s, --systemId                   |Integer - Unique system identifier                              |
    |--status                         |Possible Values: Ongoing,Risk Accepted,Completed,Not Applicable |
    |--vulnerabilityDescription       |String - Vulnerability description for the POA&M Item           |
    |--sourceIdentifyingVulnerability |String - Include Source Identifying Vulnerability text          |
    |--pocOrganization                |String - Organization/Office represented                        |
    |--resources                      |String - List of resources used. Character Limit = 250          |

    ** If any poc information is provided all POC fields are required. See additional details for POC fields below.

  - conditional parameters are*:

    |parameter                 | type or values                                                          |
    |--------------------------|:------------------------------------------------------------------------|
    |--milestones              |JSON -  see milestone format                                             |
    |--pocFirstName            |String - First name of POC                                               |
    |--pocLastName             |String - Last name of POC                                                |
    |--pocEmail**              |String - Email address of POC                                            | 
    |--pocPhoneNumber          |String - Phone number of POC (area code) ***-**** format                 |     
    |--severity                |Possible values - Very Low, Low, Moderate, High, Very High               |
    |--scheduledCompletionDate |Date - Required for ongoing and completed POA&M items. Unix time format  |
    |--completionDate          |Date - Field is required for completed POA&M items. Unix time format     |
    |--comments                |String - Field is required for completed and risk accepted POA&M items.  |

    \* Conditional parameters listed here are for Army organiztions, see Note below for additional command line help.

    ** If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request:
      pocFirstName, pocLastName, pocPhoneNumber

    Milestone Format:
      - --milestone description:[value] scheduledCompletionDate:[value]

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post poams help add
```
[top](#post-endpoints)
### ``post milestones``
---
To add (POST) milestones in a system for one or more POA&M items use the following command:

````
  $ bundle exec exe/emasser post milestones add [-s, --systemId] <value> [-p, --poamId] <value> [-d, --description] <value> [c, --scheduledCompletionDate] <value>
````
  - required parameter are:

    |parameter                     | type or values                                      |
    |------------------------------|:----------------------------------------------------|
    |-s, --systemId                |Integer - Unique system identifier                   |
    |-p, --poamId                  |Integer - Unique item identifier                     |
    |-d, --description             |String - Milestone item description. 2000 Characters |
    |-c, --scheduledCompletionDate |Date - Schedule completion date. Unix date format    |


**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post milestones help add
```
[top](#post-endpoints)
### ``post artifacts``
---
The add (POST) artifacts endpoint accepts a single binary file with file extension.zip only. The command line (CI) reads the files provided and zips them before sending to eMASS.

```
If no artifact is matched via filename to the application, a new artifact will be created with the following default values. Any values not specified below will be blank.
  - isTemplate: false
  - type: other
  - category: evidence
```

Business Rules
- Artifact cannot be saved if File Name (fileName) exceeds 1,000 characters
- Artifact cannot be saved if Name (name) exceeds 100 characters
- Artifact cannot be saved if Description (description) exceeds 10,000 characters
- Artifact cannot be saved if Reference Page Number (refPageNumber) exceeds 50 characters
- Artifact cannot be saved if the file does not have an allowable file extension/type.
- Artifact version cannot be saved if an Artifact with the same file name already exist in the system.
- Artifact cannot be saved if the file size exceeds 30MB.
- Artifact cannot be saved if the Last Review Date is set in the future.
- Artifact cannot be saved if the following fields are missing data:
  -  Filename
  -  Type
  -  Category
---
To add (POST) artifacts use the following command:

```
$ bundle exec exe/emasser post artifacts upload [-s, --systemId] <value> [-f, --files] <value...value> [-B, --isBulk or --no-isBulk] -[-T, --isTemplate or --no-isTemplate] [-t, --type] <value> [-c, --category] <value>
```

  - required parameter are:

    |parameter           | type or values                                      |
    |--------------------|:----------------------------------------------------|
    |-s, --systemId      |Integer - Unique system identifier                   |
    |-T, --isTemplate    |Boolean - Indicates whether an artifact is a template|
    |-t, --type          |Possible Values: Procedure, Diagram, Policy, Labor, Document, Image, Other, Scan Result, Auditor Report|
    |-c, --category      |Possible Values: Implementation Guidance, Evidence    |
    |-f, --files         |String - File names (to include path) to be uploaded into eMASS as artifacts |

  - optional parameter are:

    |parameter       | type or values                                        |
    |----------------|:------------------------------------------------------| 
    |-B, --isBulk    |Boolean - Set to false for single file upload, true for multiple file upload (expects a .zip file)|


**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post artifacts help upload
```
[top](#post-endpoints)
### ``post cac``
----
Submit control to second role of CAC

Business Rule
- Comments are not required at the first role of the CAC but are required at the second role of the CAC. Comments cannot exceed 10,000 characters.

To add (POST) test CAC use the following command:

  ````
  $ bundle exec exe/emasser post pac add [-s, --systemId] <value> [-a, --controlAcronym] <value> [-c, --comments] <value>
  ````
  - required parameter are:

    |parameter              | type or values                                              |
    |-----------------------|:------------------------------------------------------------|
    |-s, --systemId         |Integer - Unique system identifier                           |
    |-a, --controlAcronym   |String - Control acronym associated with the POA&M Item. NIST SP 800-53 Revision 4 defined |

  - conditional parameter is:

    |parameter          | type or values                             |
    |-------------------|:-------------------------------------------|
    |-c, --comments     |String -The control approval chain comments |

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post cac help add
```
[top](#post-endpoints)
### ``post pac``
----
Submit control to second role of CAC

To add (POST) test PAC use the following command:

  ````
  $ bundle exec exe/emasser post pac add [-s, --systemId] <value> [-f, --workflow] <value> [-n, --name] <value> [-c --comments] <value>
  ````
  - required parameter are:

    |parameter      | type or values                                                            |
    |---------------|:--------------------------------------------------------------------------|
    |-s, --systemId |Integer - Unique system identifier                                         |
    |-f, --workflow |Possible Values: Assess and Authorize, Assess Only, Security Plan Approval |
    |-n, --name     |String - Package name. 100 Characters                                      |
    |-c, --comments |String - Comments submitted upon initiation of the indicated workflow, 4,000 character|

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post pac help add
```
[top](#post-endpoints)
### ``post hardware``
---
Add (POST) one or many hardware assets in a system.

  ````
  $ bundle exec exe/emasser post hardware add [-s, --systemId] <value> [-a, --assetName] <value>
  ````

  - required parameter are:

    |parameter       | type or values                     |
    |----------------|:-----------------------------------|
    |-s, --systemId  |Integer - Unique system identifier  |
    |-a, --assetName |String - Name of the hardware asset |


**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post hardware help add
```

[top](#post-endpoints)
### ``post software``
---
Add (POST) one or many software assets in a system.

  ````
  $ bundle exec exe/emasser post software add [-s, --systemId] <value> [-V --softwareVendor] <value> [-N, --softwareName] <value> [-v, --version] <value>
  ````

  - required parameter are:

    |parameter               | type or values                                                 |
    |------------------------|:---------------------------------------------------------------|
    |-s, --systemId          |Integer - A numeric value representing the system identification|
    |-S, --softwareId        |String - Unique software identifier                             |
    |-V, --softwareVendor    |String - Vendor of the software asset                           |
    |-N, --softwareName      |String - Name of the software asset                             |
    |-v, --version           |String - Version of the software asset                          |

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post software help add
```

[top](#post-endpoints)
### ``post device scan results``
The body of a request through the Device Scan Results POST endpoint accepts a single binary file. Specific file extensions are expected depending upon the scanType parameter. For example, .ckl or .cklb files are accepted when using scanType is set to disaStigViewerCklCklb.

When set to acasAsrArf or policyAuditor, a .zip file is expected which should contain a single scan result (for example, a single pair of .asr and .arf files). Single files are expected for all other scan types as this endpoint requires files to be uploaded consecutively as opposed to in bulk.

Current scan types that are supported:
  - ACAS: ASR/ARF
  - ACAS: NESSUS
  - DISA STIG Viewer: CKL/CKLB
  - DISA STIG Viewer: CMRS
  - Policy Auditor
  - SCAP Compliance Checker

***NOTE:*** The CLI accepts multiple files, adds them to a zip archive and submits to the endpoint.

To add a upload device scan results in the assets module for a system use the following command:
````
  $ bundle exec exe/emasser post device_scans  add -s, --systemId [value] -f, --filename [file1 file2 ...] -t, --scanType [type]

````
  - required parameter are:

    |parameter           | type or values                                                            |
    |--------------------|:--------------------------------------------------------------------------|
    |-s, --systemId      |Integer - Unique system identifier                                         |
    |-f, --filename      |string - The file(s) to upload (see information above)                     |
    |-t, --scanType      |String - The device scan type to upload|
    ||Options are: [acasAsrArf, acasNessus, disaStigViewerCklCklb, disaStigViewerCmrs, policyAuditor, or scapComplianceChecker]


  - optional parameters are:

    |parameter          | type or values                                        |
    |-------------------|:------------------------------------------------------|
    |-B, --isBaseline   |Boolean - Indicates that the imported file represents a baseline scan that includes all findings and results |  

[top](#post-endpoints)
### ``post cloud_resource``
---

The following Cloud Resource parameters/fields have the following character limitations:
- Fields that can not exceed 50 characters:
  - Policy Deployment Version (`policyDeploymentVersion`)
- Fields that can not exceed 100 characters:
  - Assessment Procedure      (`assessmentProcedure`)
  - Security Control Acronym  (`control`)
  - CSP Account ID            (`cspAccountId`)
  - CSP Region                (`cspRegion`)
  - Email of POC              (`initiatedBy`)
  - Cloud Service Provider    (`provider`)
  - Type of Cloud resource    (`resourceType`)
- Fields that can not exceed 500 characters:
  - CSP/Resource’s Policy ID  (`cspPolicyDefinitionId`)
  - Policy Deployment Name    (`policyDeploymentName`)
  - Policy Compliance ID      (`resourceId`)
  - Cloud Resource Name       (`resourceName`)
- Fields that can not exceed 1000 characters:
  - Reason for Compliance (`complianceReason`)
- Fields that can not exceed 2000 characters:
  - Policy Short Title    (`policyDefinitionTitle`)

To add a cloud resource and their scan results in the assets module for a system use the following command:
````
  $ bundle exec exe/emasser post cloud_resource add -s, --systemId [value] --provider [value] --resourceId [value] --resourceName [value] --resourceType [value] --cspPolicyDefinitionId [value] --isCompliant or --is-not-Compliant --policyDefinitionTitle [value] --test [value]
````
  - required parameter are:

    |parameter               | type or values                                                            |
    |------------------------|:--------------------------------------------------------------------------|
    |-s, --systemId              |Integer - Unique system identifier                                         |
    |--provider              |string - Cloud service provider name                                       |
    |--resourceId            |String - Unique identifier/resource namespace for policy compliance result |
    |--resourceName          |String - Friendly name of Cloud resource                                   |
    |--resourceType          |String - Type of Cloud resource                                            |
    |--cspPolicyDefinitionId |String - Unique identifier/compliance namespace for CSP/Resource\'s policy definition/compliance check|
    |--isCompliant | Boolean - Compliance status of the policy for the identified cloud resource         |
    |--policyDefinitionTitle | String - Friendly policy/compliance check title. Recommend short title    |

  - optional parameters are:

    |parameter          | type or values                                        |
    |-------------------|:------------------------------------------------------|
    |--initiatedBy      |String - Person initiating the process email address |  
    |--cspAccountId     |String - System/owner\'s CSP account ID/number |
    |--cspRegion        |String - CSP region of system |
    |--isBaseline       |Boolean - Flag that indicates in results is a baseline |    
    |Tags Object (tags)|
    |--text | String - Text that specifies the tag type |
    |Compliance Results Array Objects (complianceResults)|
    |--assessmentProcedure      |String - Comma separated correlation to Assessment Procedure (i.e. CCI number for DoD Control Set) |
    |--complianceCheckTimestamp |Date - The compliance check date - Unix time format |
    |--complianceReason         |String - Reason/comments for compliance result |
    |--control                  |String - Comma separated correlation to Security Control (e.g. exact NIST Control acronym) |
    |--policyDeploymentName     |String - Name of policy deployment |
    |--policyDeploymentVersion  |String - Version of policy deployment |
    |--severity                 |Possible Values: Low, Medium, High, Critical |
    

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post cloud_resource help add
```    

[top](#post-endpoints)
### ``post container``
---
The following Container parameters/fields have the following character limitations:
- Fields that can not exceed 100 characters:
  - STIG Benchmark ID      (`benchmark`)
  - Container Namespace    (`namespace`)
  - Kubernetes assigned IP (`podIp`)
  - Kubernetes Pod Name)   (`podName`)
- Fields that can not exceed 500 characters:
  - Container ID              (`containerId`)
  - Friendly Container Name    (`containerName`)
- Fields that can not exceed 1000 characters:
  - Result Comments (`message`)

To add containers and their scan results in the assets module for a system use the following command:
````
  $ bundle exec ruby exe/emasser post container add -s, --systemId [value] --containerId [value] --containerName [value] --time [value] --benchmark [value] --lastSeen [value] --ruleId [value] --status [value]
 
````

  - required parameter are:

    |parameter               | type or values                                                            |
    |------------------------|:--------------------------------------------------------------------------|
    |-s, --systemId              |Integer - Unique system identifier                                         |
    |--containerId           |String - Unique identifier of the container  |
    |--containerName         |String - Friendly name of the container      |
    |--time                  |Date   - Datetime of scan/result. Unix date format |
    |Bench Marks Object (benchmarks)|
    |--benchmark         |String - Identifier of the benchmark/grouping of compliance results  |
    |benchmarks.results  |Object
    |--ruleId            |String - Identifier for the compliance result, vulnerability, etc.
    |--status            |String - Benchmark result status
    |--lastSeen          |Date - Date last seen, Unix date format

  - optional parameters are:

    |parameter                   | type or values                                        |
    |----------------------------|:------------------------------------------------------|
    |--podName          |String - Name of pod (e.g. Kubernetes pod) |
    |--podIp            |String - IP address of pod  |
    |--namespace        |String - Namespace of container in container orchestration (e.g. Kubernetes namespace)|
    |Tags Object (tags)|
    |--text | String - Text that specifies the tag type |
    |Bench Marks Object (benchmarks)
    |--isBaseline       |Boolean - True/false flag for providing results as baseline. If true, all existing compliance results for the provided benchmark within the container will be replaced by results in the current call|
    |benchmarks.results  |Object
    |--message           |String - Comments for the result

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post container help add
```
[top](#post-endpoints)
### ``post static_code_scan``
----
To add (POST) static code scans use the following command:

  ````
  $ bundle exec exe/emasser post scan_findings add -s, --systemId [value] --applicationName [value] --version [value] --codeCheckName [value] --scanDate [value] --cweId [value]
  ````
  - required parameter are:

    |parameter          | type or values                                             |
    |-------------------|:-----------------------------------------------------------|
    |-s, --systemId         |Integer - Unique system identifier                          |
    |--applicationName  |String - Name of the software application that was assessed |
    |--version          |String - The version of the application                     |
    |--codeCheckName    |Strings - Name of the software vulnerability or weakness    |
    |--scanDate         |Date - The findings scan date - Unix time format            |
    |--cweId            |String - The Common Weakness Enumerator (CWE) identifier    |

  - optional parameters are:

    |parameter          | type or values                                        |
    |-------------------|:------------------------------------------------------|
    |--rawSeverity*     |Possible Values: Low, Medium, Moderate, High, Critical |  
    |--count            |Integer - Number of instances observed for a specified |

*rawSeverity: In eMASS, values of "Critical" will appear as "Very High", and values of "Medium" will appear as "Moderate". Any values not listed as options in the list above will map to "Unknown" and appear as blank values.

To clear (POST) static code scans use the following command:

  ````
  $ bundle exec exe/emasser post scan_findings clear -s, --systemId [value] --applicationName [value] --version [value] --clearFindings
  ````
  - required parameter are:

    |parameter          | type or values                                             |
    |-------------------|:-----------------------------------------------------------|
    |-s, --systemId         |Integer - Unique system identifier                          |
    |--applicationName  |String - Name of the software application that was assessed |
    |--clearFindings*   |Boolean - To clear an application's findings set it to true |

*The clearFindings field is an optional field, but required with a value of "True" to clear out all application findings for a single application/version pairing.

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser post scan_findings help add
```
[top](#post-endpoints)


## Usage - PUT

### ``put controls``

----
Business Rules

The following fields are required based on the value of the `implementationStatus` field

  |Value                   |Required Fields
  |------------------------|--------------------------------------------------------
  |Planned or Implemented  |controlDesignation, estimatedCompletionDate, responsibleEntities, slcmCriticality, slcmFrequency, slcmMethod, slcmMethod, slcmTracking, slcmComments
  |Not Applicable          |naJustification, controlDesignation, responsibleEntities
  |Manually Inherited      |controlDesignation, estimatedCompletionDate, responsibleEntities, slcmCriticality, slcmFrequency, slcmMethod, slcmMethod, slcmTracking, slcmComments

Implementation Plan cannot be updated if a Security Control is "Inherited" except for the following fields:
  - Common Control Provider (commonControlProvider)
  - Security Control Designation (controlDesignation)
  
The following parameters/fields have the following character limitations:
- Implementation Plan information cannot be saved if the fields below exceed 2,000 character limits:
  - N/A Justification        (`naJustification`)
  - Responsible Entities     (`responsibleEntities`) 
  - Implementation Narrative (`implementationNarrative`)
  - Criticality              (`slcmCriticality`)
  - Reporting                (`slcmReporting`)
  - Tracking                 (`slcmTracking`)
  - Vulnerability Summary    (`vulnerabilitySummary`)
  - Recommendations          (`recommendations`)
- Implementation Plan information cannot be saved if the fields below exceed 4,000 character limits:
  - SLCM Comments            (`slcmComments`)

Implementation Plan information cannot be updated if Security Control does not exist in the system record.

---
Updating (PUT) a Control can be accomplished by invoking the following command:
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
    |--mitigation           |String - Information about the Non-Compliant Security Control's vulnerabilities|
    |--applicationLayer     |String - Navy specific applicablr to Financial Management overlay|
    |--databaseLayer        |String - Navy specific applicablr to Financial Management overlay|
    |--operatingSystemLayer |String - Navy specific applicablr to Financial Management overlay|


**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser put controls help update
```
[top](#put-emdpoints)
### ``put poams``

----
Business Rules

The following fields are required based on the value of the `status` field

  |Value           |Required Fields
  |----------------|--------------------------------------------------------
  |Risk Accepted   |comments, resources
  |Ongoing         |scheduledCompletionDate, resources, milestones (at least 1)
  |Completed       |scheduledCompletionDate, comments, resources,
  |                |completionDate, milestones (at least 1)
  |Not Applicable  |POAM can not be created

If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request.
  - pocOrganization, pocFirstName, pocLastName, pocEmail, pocPhoneNumber

Business logic, the following rules apply when adding POA&Ms

- POA&M Item cannot be saved if associated Security Control or AP is inherited.
- POA&M Item cannot be created manually if a Security Control or AP is Not Applicable.
- Completed POA&M Item cannot be saved if Completion Date is in the future.
- Completed POA&M Item cannot be saved if Completion Date (completionDate) is in the future.
- Risk Accepted POA&M Item cannot be saved with a Scheduled Completion Date (scheduledCompletionDate) or Milestones
- POA&M Item with a review status of "Not Approved" cannot be saved if Milestone Scheduled Completion Date exceeds POA&M Item  Scheduled Completion Date.
- POA&M Item with a review status of "Approved" can be saved if Milestone Scheduled Completion Date exceeds POA&M Item Scheduled Completion Date.
- POA&M Items that have a status of "Completed" and a status of "Ongoing" cannot be saved without Milestones.
- POA&M Items that have a status of "Risk Accepted" cannot have milestones.
- POA&M Items with a review status of "Approved" that have a status of "Completed" and "Ongoing" cannot update Scheduled Completion Date.
- POA&M Items that have a review status of "Approved" are required to have a Severity Value assigned.
- POA&M Items cannot be updated if they are included in an active package.
- Archived POA&M Items cannot be updated.
- POA&M Items with a status of "Not Applicable" will be updated through test result creation.
- If the Security Control or Assessment Procedure does not exist in the system we may have to just import POA&M Item at the System Level.


The following parameters/fields have the following character limitations:
- POA&M Item cannot be saved if the Point of Contact fields exceed 100 characters:
  - Office / Organization (pocOrganization)
  - First Name            (pocFirstName)
  - Last Name             (pocLastName)
  - Email                 (email)
  - Phone Number          (pocPhoneNumber)
- POA&M Item cannot be saved if Mitigation field (mitigation) exceeds 2,000 characters.
- POA&M Item cannot be saved if Source Identifying Vulnerability field (sourceIdentVuln) exceeds 2,000 characters.
- POA&M Item cannot be saved if Comments field (comments) exceeds 2,000 characters 
- POA&M Item cannot be saved if Resource field (resource) exceeds 250 characters.
- POA&M Items cannot be saved if Milestone Description (description) exceeds 2,000 characters.


The following POA&M parameters/fields have the following character limitations:
- Fields that can not exceed 100 characters:
  - Office / Organization (`pocOrganization`)
  - First Name            (`pocFirstName`)
  - Last Name             (`pocLastName`)
  - Email                 (`email`)
  - Phone Number          (`pocPhoneNumber`)
  - External Unique ID    (`externalUid`)
- Fields that can not exceed 250 characters:
  - Resource              (`resource`)
- Fields have can not exceed 2000 character: 
  - Vulnerability Description        (`vulnerabilityDescription`)
  - Source Identifying Vulnerability (`sourceIdentVuln`)
  - Recommendations                  (`recommendations`)
  - Risk Accepted Comments           (`comments`) 
  - Milestone Description            (`description`)
  - Mitigation Justification         (`mitigation`)


---
Updating (PUT) a POA&M can be accomplished by invoking the following command:
  ````
  $ bundle exec exe/emasser put poams update [PARAMETERS]
  ````
  - required parameter are:

    |parameter                  | type or values                                                 |
    |---------------------------|:---------------------------------------------------------------|
    |-s, --systemId                 |Integer - Unique system identifier                              |
    |--displayPoamId            |Integer - Globally unique identifier for individual POA&M Items |
    |--status                   |Possible Values: Ongoing,Risk Accepted,Completed,Not Applicable |
    |--vulnerabilityDescription |String - Vulnerability description for the POA&M Item           |
    |--sourceIdentVuln          |String - Include Source Identifying Vulnerability text          |
    |--pocOrganization          |String - Organization/Office represented                        |
    |--resources                |String - List of resources used. Character Limit = 250          |
    
    ** If any poc information is provided all POC fields are required. See additional details for POC fields below.

  - conditional parameters are:

    |parameter                 | type or values                                                         |
    |--------------------------|:-----------------------------------------------------------------------|
    |--milestones              |JSON -  see milestone format                                            |
    |--pocFirstName            |String - First name of POC                                              |
    |--pocLastName             |String - Last name of POC                                               |
    |--pocEmail                |String - Email address of POC                                           | 
    |--pocPhoneNumber          |String - Phone number of POC (area code) ***-**** format                |     
    |--severity                |Possible values - Very Low, Low, Moderate, High, Very High              |
    |--scheduledCompletionDate |Date - Required for ongoing and completed POA&M items. Unix time format |
    |--completionDate          |Date - Field is required for completed POA&M items. Unix time format    |
    |--comments                |String - Field is required for completed and risk accepted POA&M items  |
    |--isActive                |Boolean - Used to delete milestones when updating a POA&M               |

    ** If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request:
      pocFirstName, pocLastName, pocPhoneNumber

    Milestone Format:
      - --milestone milestoneId:[value] description:[value] scheduledCompletionDate:[value]
      - If a milestoneId is not provide a new milestone is created

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser put poams help update
```
[top](#put-endpoints)
### ``put milestones``

----

Updating (PUT) milestones in a system for one or more POA&M items use the following command:

````
  $ bundle exec exe/emasser post milestones update [-s, --systemId] <value> [-p, --poamId] <value> [-m, --milestoneId] <value> [-d, --description] <value> [c, --scheduledCompletionDate] <value>
````
  - required parameter are:

    |parameter                      | type or values                                      |
    |-------------------------------|:----------------------------------------------------|
    |-s, --systemId                 |Integer - Unique system identifier                   |
    |-p, --poamId                   |Integer - Unique poam identifier                     |
    |-m, --milestoneId              |Integer - Unique milestone identifier                |
    |-d, --description              |String - Milestone item description. 2000 Characters |
    |-c, --scheduledCompletionDate  |Date - Schedule completion date. Unix date format    |


**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser put milestones help update
```
[top](#put-endpoints)
### ``put artifacts``

----
Business Rules

- Artifact cannot be saved if File Name (fileName) exceeds 1,000 characters
- Artifact cannot be saved if Name (name) exceeds 100 characters
- Artifact cannot be saved if Description (description) exceeds 10,000 characters
- Artifact cannot be saved if Reference Page Number (refPageNumber) exceeds 50 characters
- Artifact cannot be saved if the file does not have an allowable file extension/type.
- Artifact version cannot be saved if an Artifact with the same file name already exist in the system.
- Artifact cannot be saved if the file size exceeds 30MB.
- Artifact cannot be saved if the Last Review Date is set in the future.
- Artifact cannot be saved if the following fields are missing data:
  -  Filename
  -  Type
  -  Category

Updating (PUT) milestones in a system for one or more POA&M items use the following command:

````
  $ bundle exec exe/emasser put artifacts update [-s, --systemId] <value> [-f, --filename] <value> [-T, --isTemplate or --no-isTemplate] [-t, --type] <value> [-c, --category] <value> 
````
  - required parameter are:

    |parameter         | type or values                                      |
    |------------------|:----------------------------------------------------|
    |-s, --systemId    |Integer - Unique system identifier                   |
    |-f, --filename    |String - File name should match exactly one file within the provided zip file|
    |                  |Binary  - Application/zip file. Max 30MB per artifact |
    |-T, --isTemplate  |Boolean - Indicates whether an artifact is a template|
    |-t, --type*       |Possible Values: Procedure, Diagram, Policy, Labor, Document, Image, Other, Scan Result, Auditor Report|
    |-c, --category*   |Possible Values: Implementation Guidance, Evidence    |

    *May also accept custom artifact category values set by system administrators.

  - optional parameter are:

    |parameter                | type or values                                        |
    |-------------------------|:------------------------------------------------------|
    |--name                   |String - Artifact name. Character Limit = 100          | 
    |--description            |String - Artifact description. 2000 Characters         |
    |--refPageNumber          |String - Artifact reference page number. 50 Characters |
    |--controls               |String - Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined|
    |--assessmentProcedures   |String - The Security Control Assessment Procedure being associated with the artifact|
    |--expirationDate         |Date   - Date Artifact expires and requires review - Unix time format|
    |--lastReviewedDate       |Date   - Date Artifact was last reviewed. In Unix Date Format|
    |--signedDate             |Date   - Date artifact was signed. In Unix Date Format|

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser put artifacts help update
```
[top](#put-endpoints)
### ``put hardware``
---
Update (PUT) one or many hardware assets in a system.

  ````
  $ bundle exec exe/emasser post hardware add [-s, --systemId] <value> [-h, --hardwareId] <value> [-a, --assetName] <value>
  ````

  - required parameter are:

    |parameter       | type or values                     |
    |----------------|:-----------------------------------|
    |-s, --systemId  |Integer - Unique system identifier  |
    |-h, --hardwareId|String  - GUID identifying the specific hardware asset|
    |-a, --assetName |String  - Name of the hardware asset |


**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser put hardware help add
```

[top](#put-endpoints)
### ``put software``
---
Update (PUT) one or many software assets in a system.

  ````
  $ bundle exec exe/emasser post software update [-s, --systemId] <value> [-S --softwareId] <value> [-V, --softwareVendor] <value>  [-N, --softwareName] <value> [-v --version] <value>
  ````

  - required parameter are:

    |parameter               | type or values                                                 |
    |------------------------|:---------------------------------------------------------------|
    |-s, --systemId          |Integer - A numeric value representing the system identification|
    |-S, --softwareId        |String - Unique software identifier                             |
    |-V, --softwareVendor    |String - Vendor of the software asset                           |
    |-N, --softwareName      |String - Name of the software asset                             |
    |-v, --version           |String - Version of the software asset                          |

**Note**
For additional information about command line usages invoke the following help command: 
```
$ bundle exec exe/emasser put software help add
```

[top](#put-endpoints)


## Usage - DELETE

### ``delete poams``

----
Remove one or many poa&m items in a system

To remove (DELETE) one or more POA&M items use the following command:
```
$ bundle exec exe/emasser delete poams remove [-s, --systemId] <value> [-p, --poamId] <value>
```
[top](#delete-endpoints)
### ``delete milestones``

----
Remove milestones in a system for one or many POA&M items

To delete a milestone the record must be inactive by having the field isActive set to false (isActive=false).

The server returns an empty object upon successfully deleting a milestone.

The last milestone can not be deleted, at-least on must exist.

To remove (DELETE) one or more Milestones in a system use the following command:
```
$ bundle exec exe/emasser delete milestones remove [-s, --systemId] <value> [-p, --poamId] <value> [-m, --milestoneId] <value>
```
[top](#delete-endpoints)
### ``delete artifacts``

---
Remove one or many artifacts in a system

Provide single file or a space/comma delimited list of file names to be removed from the system (systemId)

To remove (DELETE) one or more Artifacts from a system use the following command:
```
Delete one file:
$ bundle exec exe/emasser delete artifacts remove [-s, --systemId] <value> [-f, --files] <value> 
Delete multiple files (can be space of comma delimited)
$ bundle exec exe/emasser delete artifacts remove [-s, --systemId] <value> [-f, --files] <value ... value>

```
[top](#delete-endpoints)
### ``delete hardware``
---
Delete one or many one or multiple assets from a system Hardware Baseline for a system

To remove (DELETE) a hardware asset use the following command:
```
$ bundle exec exe/emasser delete hardware remove [-s, --systemId] <value> [-h, --hardwareIds] <value ... value>
```

[top](#delete-endpoints)
### ``delete software``
---
Delete one or many one or multiple assets from a system Software Baselinefor a system

To remove (DELETE) a software asset use the following command:
```
$ bundle exec exe/emasser delete software remove [-s, --systemId] <value> [-w, --softwareIds] <value ... value>
```
[top](#delete-endpoints)
### ``delete cloud resource``
---
Delete one or many Cloud Resources and their scan results in the assets module for a system

To remove (DELETE) one or many cloud resources in a system use the following command:
```
$ bundle exec exe/emasser delete cloud_resource remove [-s, --systemId] <value> [-r, --resourceId] <value>
```
[top](#delete-endpoints)
### ``delete container``
---
Delete one or many containers scan results in the assets module for a system

To remove (DELETE) one or many containers in a system use the following command:
```
bundle exec exe/emasser delete container remove [-s, --systemId] <value> [-c, --containerId] <value>
```
[top](#delete-endpoints)