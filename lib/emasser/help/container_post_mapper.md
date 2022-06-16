Add cloud resource and scan results in the assets module for a system

Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                 Integer   [Required] Unique eMASS identifier. Will need to provide correct number.
containerId              String    [Required] Unique identifier of the container.
containerName            String    [Required] Friendly name of the container.
time                     Date      [Required] Datetime of scan/result. Unix date format.

podName                  String    [Optional] Name of pod (e.g. Kubernetes pod).
podIp                    String    [Optional] IP address of pod.
namespace                String    [Optional] Namespace of container in container orchestration (e.g. Kubernetes namespace).

tags                     Object    [Optional] Informational tags associated to results for other metadata.
  text                   String    [Optional] Tag metadata information.

benchmarks               Object
  benchmark              String    [Required] Identifier of the benchmark/grouping of compliance results. 
                                   (e.g. for STIG results, provide the benchmark id for the STIG technology).
  isBaseline             Boolean   [Optional] True/false flag for providing results as baseline. If true, all existing
                                   compliance results for the provided benchmark within the container will be replaced
                                   by results in the current call.
  results                Object                                 
    ruleId               String    [Required] Identifier for the compliance result, vulnerability, etc.
    status               String    [Required] Benchmark result status
    lastSeen             Date      [Required] Date last seen, Unix date format
    message              String    [Optional] Comments for the result

The following Container parameters/fields have the following character limitations:
- Fields that can not exceed 100 characters:
  - STIG Benchmark ID      (`benchmark`)
  - Container Namespace    (`namespace`)
  - Kubernetes assigned IP (`podIp`)
  - Kubernetes Pod Name)   (`podName`)
- Fields that can not exceed 500 characters:
  - Container ID              (`containerId`)
  - Friendly Container Name   (`containerName`)
- Fields that can not exceed 1000 characters:
  - Result Comments (`message`)

Example:
bundle exec ruby exe/emasser post container add --systemId [value] --containerId [value] --containerName [value] --time [value] --benchmark [value] --lastSeen [value] --ruleId [value] --status [value]
