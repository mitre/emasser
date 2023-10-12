# eMASSer CLI Features

## Environment Variables
To facilitate setting the required environment variables the `eMASSer `CLI utilized the zero-dependency module to load these variables from a `.env` file.  

### Configuring the `.env` File
An `.env-example` file is provided with the required and optional fields.

Modify the `.env_example` as necessary and save it as a `.env` file. 

Place the file on the  path where the `eMASSer` command is executed.

### Required and Optional Environment Variables
The following environment variables are required:
* EMASSER_API_KEY=`<API key>`
* EMASSER_USER_UID=`<unique identifier for the API Key (EMASSER_API_KEY)`
* EMASSER_HOST_URL=`<FQDN of the eMASS server>`
* EMASSER_KEY_FILE_PATH=`<path to your eMASS key in PEM format>`
* EMASSER_CERT_FILE_PATH=`<path to your eMASS certificate in PEM format>`
* EMASSER_KEY_FILE_PASSWORD=`<password for the key given in EMASSER_KEY_FILE_PATH>`
  
The following environment variables are optional*:
* EMASSER_CLIENT_SIDE_VALIDATION=`<client side validation - true or false (default true)>`
* EMASSER_VERIFY_SSL=`<verify SSL - true or false (default true)>`
* EMASSER_VERIFY_SSL_HOST=`<verify host SSL - true or false (default true)>`
* EMASSER_DEBUGGING=`<set debugging - true or false (default false)>`
* EMASSER_CLI_DISPLAY_NULL=`<display null value fields - true or false (default true)>`
* EMASSER_EPOCH_TO_DATETIME=`<convert epoch to data/time value - true or false (default false)>`
  
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

#### System Endpoints
  * [/api/system](#get-system)
  * [/api/systems](#get-systems)
  * [/api/systems/{systemId}](#get-system)

#### System Roles Endpoints
  * [/api/system-roles](#get-roles)
  * [/api/system-roles/{roleCategory}](#get-roles)

#### Controls Endpoint 
  * [/api/systems/{systemId}/controls](#get-controls)

#### Test Results Endpoint
  * [/api/systems/{systemId}/test-results](#get-test_results)

#### POA&Ms Endpoints
  * [/api/systems/{systemId}/poams](#get-poams)
  * [/api/systems/{systemId}/poams/{poamId}](#get-poams)

#### Milestones Endpoints
  * [/api/systems/{systemId}/poams/{poamId}/milestones](#get-milestones)
  * [/api/systems/{systemId}/poams/{poamId}/milestones/{milestoneId})](#get-milestones)

#### Artifacts Endpoints
  * [/api/systems/{systemId}/artifacts](#get-artifacts)
  * [/api/systems/{systemId}/artifacts-export](#get-artifacts)

#### CAC Endpoint
  * [/api/systems/{systemId}/approval/cac](#get-cac)

#### PAC Endpoint
  * [/api/systems/{systemId}/approval/pac](#get-pac)

#### CMMC Assessment Endpoint
  * [/api/cmmc-assessments](#get-cmmc)

#### Workflow Definition Endpoint
  * [/api/workflow-definitions](#get-workflow_definitions)

#### Workflow Instances Endpoint
  * [/api/systems/{systemId}/workflow-instances](#get-workflow_instances)

### [Dashboards](#get-dashboards)

#### System Status Dashboard
  * [/api/dashboards/system-status-details](#system-status-endpoint)

#### Enterprise Terms Conditions Dashboard
  * [/api/dashboards/system-terms-conditions-summary](#system-terms-conditions-endpoints)
  * [/api/dashboards/system-terms-conditions-details](#system-terms-conditions-endpoints)

### Enterprise Security Controls Dashboard  
  * [/api/dashboards/system-control-compliance-summary](#enterprise-security-controls-endpoints)
  * [/api/dashboards/system-security-controls-details](#enterprise-security-controls-endpoints)
  * [/api/dashboards/system-assessment-procedures-details](#enterprise-security-controls-endpoints)

### Enterprise POA&M Dashboard
  * [/api/dashboards/system-poam-summary](#enterprise-poam-endpoints)
  * [/api/dashboards/system-poam-details](#enterprise-poam-endpoints)

### Enterprise Artifacts Dashboard
  * [/api/dashboards/system-artifacts-summary](#enterprise-artifacts-endpoints)
  * [/api/dashboards/system-artifacts-details](#enterprise-artifacts-endpoints)

### Hardware Baseline Dashboard
  * [/api/dashboards/system-hardware-summary](#hardware-baseline-endpoints)
  * [/api/dashboards/system-hardware-details](#hardware-baseline-endpoints)

### Enterprise Sensor-based Hardware Resources Dashboard
  * [/api/dashboards/system-sensor-hardware-summary](#enterprise-sensor-based-hardware-resources-endpoints)
  * [/api/dashboards/system-sensor-hardware-details](#enterprise-sensor-based-hardware-resources-endpoints)

### Software Baseline Dashboard
  * [/api/dashboards/system-software-summary](#software-baseline-endpoints)
  * [/api/dashboards/system-software-details](#software-baseline-endpoints)

### Enterprise Sensor-based Software Resources Dashboard
  * [/api/dashboards/system-sensor-software-summary](#enterprise-sensor-based-software-resources-endpoints)
  * [/api/dashboards/system-sensor-software-details](#enterprise-sensor-based-software-resources-endpoints)
  * [/api/dashboards/system-sensor-software-counts](#enterprise-sensor-based-software-resources-endpoints)

### Enterprise Vulnerability Dashboard
  * [/api/dashboards/system-vulnerability-summary](#enterprise-vulnerability-endpoints)
  * [/api/dashboards/system-device-findings-summary](#enterprise-vulnerability-endpoints)
  * [/api/dashboards/system-device-findings-details](#enterprise-vulnerability-endpoints)

### Ports and Protocols Dashboard
  * [/api/dashboards/system-ports-protocols-summary](#ports-and-protocols-endpoints)
  * [/api/dashboards/system-ports-protocols-details](#ports-and-protocols-endpoints)

### System CONMON Integration Status Dashboard
  * [/api/dashboards/system-conmon-integration-status-summary](#system-conmon-integration-status-endpoint)

### System Associations Dashboard
  * [/api/dashboards/system-associations-details](#system-associations-endpoint)

### Users Dashboard
  * [/api/dashboards/user-system-assignments-details](#users-endpoint)

### Privacy Compliance Dashboard
  * [/api/dashboards/system-privacy-summary](#privacy-compliance-endpoints)
  * [/api/dashboards/va-omb-fisma-saop-summary](#privacy-compliance-endpoints)

### System A&A Summary Dashboard
  * [/api/dashboards/va-system-aa-summary](#system-aa-summary-endpoint)

### System A2.0 Summary Dashboard
  * [/api/dashboards/va-system-a2-summary](#system-a20-summary-endpoint)

### System P.L. 109 Reporting Summary Dashboard
  * [/api/dashboards/va-system-pl-109-reporting-summary](#system-pl-109-reporting-summary-endpoint)

### FISMA Inventory Summary Dashboard
  * [/api/dashboards/va-system-fisma-inventory-summary](#fisma-inventory-summary-endpoints)
  * [/api/dashboards/va-system-fisma-inventory-crypto-summary](#fisma-inventory-summary-endpoints)

### Threat Risks Dashboard
  * [/api/dashboards/va-system-threat-risks-summary](#threat-risks-endpoints)
  * [/api/dashboards/va-system-threat-sources-details](#threat-risks-endpoints)
  * [/api/dashboards/va-system-threat-architecture-details](#threat-risks-endpoints)
 
## POST Endpoints
* [/api/systems/{systemId}/test-results](#post-test_results)
* [/api/systems/{systemId}/poam](#post-poams)
* [/api/systems/{systemId}/poam/{poamId}/milestones](#post-milestones)
* [/api/systems/{systemId}/artifacts](#post-artifacts)
* [/api/systems/{systemId}/approval/cac](#post-cac)
* [/api/systems/{systemId}/approval/pac](#post-pac)
* [/api/systems/{systemId}/static-code-scans](#post-static_code_scan)
* [/api/systems/{systemId}/cloud-resource-results](#post-cloud_resource)
* [/api/systems/{systemId}/container-scan-results](#post-container)

## PUT Endpoints
* [/api/systems/{systemId}/controls](#put-controls)
* [/api/systems/{systemId}/poams](#put-poams)
* [/api/systems/{systemId}/poams/{poamId}/milestones](#put-milestones)
* [/api/systems/{systemId}/artifacts](#put-artifacts)

## DELETE Endpoints
* [/api/systems/{systemId}/poams](#delete-poams)
* [/api/systems/{systemId}/poams/{poamId}/milestones](#delete-milestones)
* [/api/systems/{systemId}/artifacts](#delete-artifacts)
* [/api/systems/{systemId}/cloud-resource-results](#delete-cloud-resource)
* [/api/systems/{systemId}/container-scan-results](#delete-container)

# Endpoints CLI help

Each CLI endpoint command has several layers of help. 
- Using `help` after a `get, put, post, or delete` command lists all available endpoint calls. The following command would list all available `GET` endpoints commands.

    ```bash
    $ bundle exec exe/emasser get help
    Commands:
      emasser get artifacts             # Get system Artifacts
      emasser get cac                   # Get location of one or many controls in...
      emasser get cmmc                  # Get CMMC assessment information
      emasser get controls              # Get system Controls
      emasser get dashboards            # Get dashboard information
      emasser get help [COMMAND]        # Describe subcommands or one specific su...
      emasser get milestones            # Get system Milestones
      emasser get pac                   # Get status of active workflows in a system
      emasser get poams                 # Get system Poams
      emasser get roles                 # Get all system roles or by category Id
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
      -C, [--compress], [--no-compress]    # BOOLEAN - true or false.
      -o, [--printToStdout=PRINTTOSTDOUT]  # Output file content to terminal - not valid for zip files      
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

[top](#system-endpoints)

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
  
[top](#system-endpoints)
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


[top](#system-roles-endpoints)
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

[top](#controls-endpoint)
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

[top](#test-results-endpoint)
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

[top](#poams-endpoints)
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

[top](#milestones-endpoints)
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

[top](#artifacts-endpoints)
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

[top](#cac-endpoint)
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

[top](#pac-endpoint)
### ```get cmmc```

----
To view Cybersecurity Maturity Model Certification (CMMC) Assessments use the following command:

    $ bundle exec exe/emasser get cmmc assessments -d, --sinceDate=SINCEDATE 

  - Required parameter is:

    |parameter       | type or values                        |
    |----------------|:--------------------------------------|
    |-d, --sinceDate |Date - The CMMC date. Unix date format |

[top](#cmmc-assessment-endpoint)
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

[top](#workflow-definition-endpoint)
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

[top](#workflow-instances-endpoint)
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
[top](#dashboards)

#### System Status Endpoint
  - Get systems status detail dashboard information
    ```
    $ bundle exec exe/emasser get dashboards status_details [-o, --orgId] <value> [options]
    ```
    [top](#system-status-dashboard)
#### System Terms Conditions Endpoints
  - Get system terms/conditions summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards terms_conditions_summary [-o, --orgId] <value> [options]
    ```
  - Get system terms/conditions details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards terms_conditions_detail [-o, --orgId] <value> [options]
    ```
  [top](#enterprise-terms-conditions-dashboard)
### Enterprise Security Controls Endpoints  
  - Get systems control compliance summary dashboard information    
    ```
    $ bundle exec exe/emasser get dashboards control_compliance_summary [-o, --orgId] <value> [options]
    ```
  - Get systems security control details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards security_control_details [-o, --orgId] <value> [options]
    ```
  - Get systems assessment procedures details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards assessment_procedures_details [-o, --orgId] <value> [options]
    ```
  [top](#enterprise-security-controls-dashboard)
### Enterprise POA&M Endpoints

  - Get systems POA&Ms summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards poam_summary [-o, --orgId] <value> [options]
    ```
  - Get system POA&Ms details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards poam_details [-o, --orgId] <value> [options]
    ```
  [top](#enterprise-poam-dashboard)
### Enterprise Artifacts Endpoints
  - Get artifacts summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards artifacts_summary [-o, --orgId] <value> [options]
    ```
  - Get artifacts details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards artifacts_details [-o, --orgId] <value> [options]
    ```
  [top](#enterprise-artifacts-dashboard)
### Hardware Baseline Endpoints
  - Get system hardware summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards hardware_summary [-o, --orgId] <value> [options]
    ```
  - Get system hardware details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards hardware_details [-o, --orgId] <value> [options]
    ```
  [top](#hardware-baseline-dashboard)
### Enterprise Sensor-based Hardware Resources Endpoints
  - Get sensor hardware summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards sensor_hardware_summary [-o, --orgId] <value> [options]
    ```
  - Get sensor hardware details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards sensor_hardware_details [-o, --orgId] <value> [options]
    ```
  [top](#enterprise-sensor-based-hardware-resources-dashboard)
### Software Baseline Endpoints
  - Get software baseline summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards software_summary [-o, --orgId] <value> [options]
    ```
  - Get software baseline details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards software_details [-o, --orgId] <value> [options]
    ```
  [top](#software-baseline-dashboard)

### Enterprise Sensor-based Software Resources Endpoints
  - Get sensor based software resources summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards sensor_software_summary [-o, --orgId] <value> [options]
    ```
  - Get sensor based software resources details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards sensor_software_details [-o, --orgId] <value> [options]
    ```
  - Get sensor based software resources counts dashboard information
    ```
    $ bundle exec exe/emasser get dashboards sensor_software_counts [-o, --orgId] <value> [options]
    ```
  [top](#enterprise-sensor-based-software-resources-dashboard)
### Enterprise Vulnerability Endpoints
  - Get vulnerability summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards vulnerability_summary [-o, --orgId] <value> [options]
    ```
  - Get device findings summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards device_findings_summary [-o, --orgId] <value> [options]
    ```
  - Get device findings details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards device_findings_details [-o, --orgId] <value> [options]
    ```  
  [top](#enterprise-vulnerability-dashboard)
### Ports and Protocols Endpoints
  - Get ports and protocols summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards ports_protocols_summary [-o, --orgId] <value> [options]
    ```
  - Get ports and protocols details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards ports_protocols_details [-o, --orgId] <value> [options]
    ```
  [top](#ports-and-protocols-dashboard)

### System CONMON Integration Status Endpoint
  - Get CONMON integration status summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards integration_status_summary [-o, --orgId] <value> [options]
    ```
  [top](#system-conmon-integration-status-dashboard)
### System Associations Endpoint
  - Get system associations details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards associations_details [-o, --orgId] <value> [options]
    ```
  [top](#system-associations-dashboard)
### Users Endpoint
  - Get user system assignments details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards assignments_details [-o, --orgId] <value> [options]
    ```
  [top](#users-dashboard)
### Privacy Compliance Endpoints  
  - Get user system privacy summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards privacy_summary [-o, --orgId] <value> [options]
    ```
  - Get VA OMB-FISMA SAOP summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards fisma_saop_summary [-o, --orgId] <value> [options]
    ```
  [top](#privacy-compliance-dashboard)
### System A&A Summary Endpoint
  - Get VA system A&A summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards va_aa_summary [-o, --orgId] <value> [options]
    ```
  [top](#system-aa-summary-dashboard)
### System A2.0 Summary Endpoint
  - Get VA system A2.0 summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards va_a2_summary [-o, --orgId] <value> [options]
    ```
  [top](#system-a20-summary-dashboard)
### System P.L. 109 Reporting Summary Endpoint
  - Get VA System P.L. 109 reporting summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards va_pl_109_summary [-o, --orgId] <value> [options]
    ```
  [top](#system-pl-109-reporting-summary-dashboard)
### FISMA Inventory Summary Endpoints
  - Get VA system FISMA inventory summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards fisma_inventory_summary [-o, --orgId] <value> [options]
    ```
  - Get VA system FISMA inventory summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards fisma_inventory_crypto_summary [-o, --orgId] <value> [options]
    ```
  [top](#fisma-inventory-summary-dashboard)
### Threat Risks Endpoints
  - Get VA threat risk summary dashboard information
    ```
    $ bundle exec exe/emasser get dashboards va_threat_risk_summary [-o, --orgId] <value> [options]
    ```
  - Get VA threat source details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards va_threat_source_details [-o, --orgId] <value> [options]
    ```
  - Get VA threat architecture details dashboard information
    ```
    $ bundle exec exe/emasser get dashboards va_threat_architecture_details [-o, --orgId] <value> [options]
    ```
  [top](#threat-risks-dashboard)

## Usage - POST

### ``post test_results``
---
Test Result add (POST) endpoint API business rules.

  |Business Rule                                                        | Parameter/Field  |
  |---------------------------------------------------------------------|:-----------------|
  | Tests Results cannot be saved if the "Test Date" is in the future.  | `testDate` |
  | Test Results cannot be saved if a Security Control is "Inherited" in the system record. | `description` |
  | Test Results cannot be saved if an Assessment Procedure is "Inherited" in the system record. | `description` |
  | Test Results cannot be saved if the AP does not exist in the system. | `description` |
  | Test Results cannot be saved if the control is marked "Not Applicable" by an Overlay. | `description` |
  | Test Results cannot be saved if the control is required to be assessed as "Applicable" by an Overlay.| `description` |
  | Test Results cannot be saved if the Tests Results entered is greater than 4000 characters.|`description`|
  | Test Results cannot be saved if the following fields are missing data: | `complianceStatus`, `testDate`, `testedBy`, `description`|
  | Test results cannot be saved if there is more than one test result per CCI |`cci`|

---
To add (POST) test results use the following command:

  ````
  $ bundle exec exe/emasser post test_results add -s, --systemId [value] --cci [value] --testedBy [value] --testDate [value] --description [value] --complianceStatus [value]
  ````
Note: If no POA&Ms or AP exist for the control (system), you will get this response:
"You have entered a Non-Compliant Test Result. You must create a POA&M Item for this Control and/or AP if one does not already exist."

  - required parameter are:

    |parameter          | type or values                                              |
    |-------------------|:------------------------------------------------------------|
    |-s, --systemId         |Integer - Unique system identifier                           |
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
$ bundle exec exe/emasser post poams add -s, --systemId [value] --status [value] --vulnerabilityDescription [value] --sourceIdentVuln [value] --pocOrganization [value] --resources [value]
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

    |parameter                  | type or values                                                 |
    |---------------------------|:---------------------------------------------------------------|
    |-s, --systemId                 |Integer - Unique system identifier                              |
    |--status                   |Possible Values: Ongoing,Risk Accepted,Completed,Not Applicable |
    |--vulnerabilityDescription |String - Vulnerability description for the POA&M Item           |
    |--sourceIdentVuln          |String - Include Source Identifying Vulnerability text          |
    |--pocOrganization          |String - Organization/Office represented       |
    |--resources                |String - List of resources used. Character Limit = 250          |

    ** If any poc information is provided all POC fields are required. See additional details for POC fields below.

  - conditional parameters are:

    |parameter                 | type or values                                                          |
    |--------------------------|:------------------------------------------------------------------------|
    |--milestones              |JSON -  see milestone format                                             |
    |--pocFirstName            |String - First name of POC                                               |
    |--pocLastName             |String - Last name of POC                                                |
    |--pocEmail                |String - Email address of POC                                            | 
    |--pocPhoneNumber          |String - Phone number of POC (area code) ***-**** format                 |     
    |--severity                |Possible values - Very Low, Low, Moderate, High, Very High               |
    |--scheduledCompletionDate |Date - Required for ongoing and completed POA&M items. Unix time format  |
    |--completionDate          |Date - Field is required for completed POA&M items. Unix time format     |
    |--comments                |String - Field is required for completed and risk accepted POA&M items.  |

    ** If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request:
      pocFirstName, pocLastName, pocPhoneNumber

    Milestone Format:
      - --milestone description:[value] scheduledCompletionDate:[value]

  - optional parameters are:

    |parameter           | type or values                                                                           |
    |--------------------|:-----------------------------------------------------------------------------------------|
    |--externalUid       |String - External unique identifier for use with associating POA&M Items                  |
    |--controlAcronym    |String - Control acronym associated with the POA&M Item. NIST SP 800-53 Revision 4 defined|
    |--cci               |String - CCI associated with the test result                                              |
    |--securityChecks    |String - Security Checks that are associated with the POA&M                               |
    |--rawSeverity       |Possible values: I, II, III                                                               |
    |--relevanceOfThreat |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--likelihood        |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--impact            |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--impactDescription |String - Include description of Security Control’s impact                                 |
    |--residualRiskLevel |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--recommendations   |String - Include recommendations                                                          |
    |--mitigation        |String - Include mitigation explanation                                                   |


**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser post poams help add
```
[top](#post-endpoints)

### ``post milestones``
---
To add (POST) milestones in a system for one or more POA&M items use the following command:

````
  $ bundle exec exe/emasser post milestones add -s, --systemId [value] -p, --poamId [value] --description [value] --scheduledCompletionDate [value]
````
  - required parameter are:

    |parameter                  | type or values                                      |
    |---------------------------|:----------------------------------------------------|
    |-s, --systemId             |Integer - Unique system identifier                   |
    |-p, --poamId               |Integer - Unique item identifier                     |
    |--description              |String - Milestone item description. 2000 Characters |
    |--scheduledCompletionDate  |Date - Schedule completion date. Unix date format    |


**Note**
For information at the command line use: 
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

Business Rules:
- Artifact cannot be saved if the file does not have the following file extensions:
  - .docx,.doc,.txt,.rtf,.xfdl,.xml,.mht,.mhtml,.html,.htm,.pdf
  - .mdb,.accdb,.ppt,.pptx,.xls,.xlsx,.csv,.log
  - .jpeg,.jpg,.tiff,.bmp,.tif,.png,.gif
  - .zip,.rar,.msg,.vsd,.vsw,.vdx, .z{#}, .ckl,.avi,.vsdx
- Artifact cannot be saved if File Name (fileName) exceeds 1,000 characters
- Artifact cannot be saved if Description (description) exceeds 2,000 characters
- Artifact cannot be saved if Reference Page Number (refPageNumber) exceeds 50 characters
- Artifact version cannot be saved if an Artifact with the same file name already exist in the system.
- Artifact cannot be saved if the file size exceeds 30MB.
- Artifact cannot be saved if the Last Review Date is set in the future.
---
To add (POST) artifacts use the following command:

```
$ bundle exec exe/emasser post artifacts upload -s, --systemId [value] [--isTemplate or --no-isTemplate] --type [value] --category [value] --files [value...value]
```

  - required parameter are:

    |parameter       | type or values                                      |
    |----------------|:----------------------------------------------------|
    |-s, --systemId      |Integer - Unique system identifier                   |
    |--isTemplate    |Boolean - Indicates whether an artifact is a template|
    |--type          |Possible Values: Procedure, Diagram, Policy, Labor, Document, Image, Other, Scan Result, Auditor Report|
    |--category      |Possible Values: Implementation Guidance, Evidence    |
    |--files         |String - File names (to include path) to be uploaded into eMASS as artifacts |

  - optional parameter are:

    |parameter                | type or values                                        |
    |-------------------------|:------------------------------------------------------| 
    |--description            |String - Artifact description. 2000 Characters         |
    |--refPageNumber          |String - Artifact reference page number. 50 Characters |
    |-c, --ccis                   |String -  CCIs associated with artifact                |
    |--controls               |String - Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined|
    |--artifactExpirationDate |Date - Date Artifact expires and requires review. In Unix Date Format|
    |--lastReviewedDate       |Date - Date Artifact was last reviewed. In Unix Date Format          |


**Note**
For information at the command line use: 
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
  $ bundle exec exe/emasser post pac add -s, --systemId [value] --controlAcronym [value] --comments [value]
  ````
  - required parameter are:

    |parameter          | type or values                                              |
    |-------------------|:------------------------------------------------------------|
    |-s, --systemId         |Integer - Unique system identifier                           |
    |--controlAcronym   |String - Control acronym associated with the POA&M Item. NIST SP 800-53 Revision 4 defined |

  - conditional parameter is:

    |parameter          | type or values                             |
    |-------------------|:-------------------------------------------|
    |--comments         |String -The control approval chain comments |

**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser post cac help add
```
[top](#post-endpoints)

### ``post pac``
----
Submit control to second role of CAC

To add (POST) test PAC use the following command:

  ````
  $ bundle exec exe/emasser post pac add -s, --systemId [value] --workflow [value] --name [value] --comments [value]
  ````
  - required parameter are:

    |parameter     | type or values                                                            |
    |--------------|:--------------------------------------------------------------------------|
    |-s, --systemId    |Integer - Unique system identifier                                         |
    |--workflow    |Possible Values: Assess and Authorize, Assess Only, Security Plan Approval |
    |--name        |String - Package name. 100 Characters                                      |
    |--comments    |String - Comments submitted upon initiation of the indicated workflow, 4,000 character|

**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser post pac help add
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
For information at the command line use: 
```
$ bundle exec exe/emasser post scan_findings help add
```
[top](#post-endpoints)

### ```post cloud_resource```
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
For information at the command line use: 
```
$ bundle exec exe/emasser post cloud_resource help add
```    

[top](#post-endpoints)


### ```post container```
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
For information at the command line use: 
```
$ bundle exec exe/emasser post container help add
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
    |-s, --systemId                |Integer - Unique system identifier                                        |
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

  - optional parameters are:

    |parameter           | type or values                                                                           |
    |--------------------|:-----------------------------------------------------------------------------------------|
    |--externalUid       |String - External unique identifier for use with associating POA&M Items                  |
    |--controlAcronym    |String - Control acronym associated with the POA&M Item. NIST SP 800-53 Revision 4 defined|
    |--cci               |String - CCI associated with the test result                                              |
    |--securityChecks    |String - Security Checks that are associated with the POA&M                               |
    |--rawSeverity       |Possible values: I, II, III                                                               |
    |--relevanceOfThreat |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--likelihood        |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--impact            |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--impactDescription |String - Include description of Security Control’s impact                                 |
    |--residualRiskLevel |Possible values: Very Low, Low, Moderate, High, Very High                                 |
    |--recommendations   |String - Include recommendations                                                          |
    |--mitigation        |String - Include mitigation explanation. 2000 Characters                                  |

**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser put poams help update
```
[top](#put-endpoints)

### ``put milestones``

----

To add (POST) milestones in a system for one or more POA&M items use the following command:

````
  $ bundle exec exe/emasser put milestones update [PARAMETERS]
````
  - required parameter are:

    |parameter                  | type or values                                      |
    |---------------------------|:----------------------------------------------------|
    |-s, --systemId                 |Integer - Unique system identifier                   |
    |-p, --poamId                   |Integer - Unique poam identifier                     |
    |-m, --milestoneId              |Integer - Unique milestone identifier                |
    |--description              |String - Milestone item description. 2000 Characters |
    |--scheduledCompletionDate  |Date - Schedule completion date. Unix date format    |


**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser put milestones help update
```
[top](#put-endpoints)

### ``put artifacts``

----
Business Rules

- Artifact cannot be saved if the file does not have the following file extensions:
  - .docx,.doc,.txt,.rtf,.xfdl,.xml,.mht,.mhtml,.html,.htm,.pdf
  - .mdb,.accdb,.ppt,.pptx,.xls,.xlsx,.csv,.log
  - .jpeg,.jpg,.tiff,.bmp,.tif,.png,.gif
  - .zip,.rar,.msg,.vsd,.vsw,.vdx, .z{#}, .ckl,.avi,.vsdx
- Artifact cannot be saved if File Name (fileName) exceeds 1,000 characters
- Artifact cannot be saved if Description (description) exceeds 2,000 characters
- Artifact cannot be saved if Reference Page Number (refPageNumber) exceeds 50 characters
- Artifact cannot be saved if the file does not have an allowable file extension/type.
- Artifact version cannot be saved if an Artifact with the same file name already exist in the system.
- Artifact cannot be saved if the file size exceeds 30MB.
- Artifact cannot be saved if the Last Review Date is set in the future.

To add (POST) milestones in a system for one or more POA&M items use the following command:

````
  $ bundle exec exe/emasser put artifacts update [PARAMETERS]
````
  - required parameter are:

    |parameter       | type or values                                      |
    |----------------|:----------------------------------------------------|
    |-s, --systemId      |Integer - Unique system identifier                   |
    |-f, --filename        |String - File name should match exactly one file within the provided zip file|
    |                |Binary  - Application/zip file. Max 30MB per artifact |
    |--isTemplate    |Boolean - Indicates whether an artifact is a template|
    |--type*         |Possible Values: Procedure, Diagram, Policy, Labor, Document, Image, Other, Scan Result, Auditor Report|
    |--category*     |Possible Values: Implementation Guidance, Evidence    |

    *May also accept custom artifact category values set by system administrators.

  - optional parameter are:

    |parameter                | type or values                                        |
    |-------------------------|:------------------------------------------------------| 
    |--description            |String - Artifact description. 2000 Characters         |
    |--refPageNumber          |String - Artifact reference page number. 50 Characters |
    |-c, --ccis                   |String -  CCIs associated with artifact                |
    |--controls               |String - Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined|
    |--artifactExpirationDate |Date - Date Artifact expires and requires review. In Unix Date Format|
    |--lastReviewedDate       |Date - Date Artifact was last reviewed. In Unix Date Format          |


**Note**
For information at the command line use: 
```
$ bundle exec exe/emasser put artifacts help update
```
[top](#put-endpoints)

## Usage - DELETE

### ``delete poams``

----
Remove one or many poa&m items in a system

To remove (DELETE) one or more POA&M items use the following command:
```
bundle exec exe/emasser delete poams remove -s, --systemId [value] -p, --poamId [value]
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
bundle exec exe/emasser delete milestones remove -s, --systemId [value] -p, --poamId [value] -m, --milestoneId [value]
```
[top](#delete-endpoints)

### ``delete artifacts``

---
Remove one or many artifacts in a system

Provide single file or a space/comma delimited list of file names to be removed from the system (systemId)

To remove (DELETE) one or more Artifacts from a system use the following command:
```
bundle exec exe/emasser delete artifacts remove -s, --systemId [value] -f, --files [value]
or
bundle exec exe/emasser delete artifacts remove -s, --systemId [value] -f, --files [value value...] 
or
bundle exec exe/emasser delete artifacts remove -s, --systemId [value] -f, --files [value, value...] 
```
[top](#delete-endpoints)

### ``delete cloud resource``
---
Delete one or many Cloud Resources and their scan results in the assets module for a system

To remove (DELETE) one or many cloud resources in a system use the following command:
```
bundle exec exe/emasser delete cloud_resource remove -c, --resourceId [value] -s, --systemId [value]
```
[top](#delete-endpoints)

### ``delete container``
---
Delete one or many containers scan results in the assets module for a system

To remove (DELETE) one or many containers in a system use the following command:
```
bundle exec exe/emasser delete container remove -c, --containerId [value] -s, --systemId [value]
```
[top](#delete-endpoints)