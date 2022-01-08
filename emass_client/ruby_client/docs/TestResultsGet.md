# EmassClient::TestResultsGet

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**system_id** | **Integer** | [Required] Unique eMASS identifier. Will need to provide correct number | [optional] 
**control** | **String** | [Read-Only] Control acronym associated with the test result. NIST SP 800-53 Revision 4 defined. | [optional] 
**cci** | **String** | [Required] CCI associated with test result. | [optional] 
**is_inherited** | **BOOLEAN** | [Read-only] Indicates whether a test result is inherited. | [optional] 
**tested_by** | **String** | [Required] Last Name, First Name. 100 Characters. | [optional] 
**test_date** | **Integer** | [Required] Unix time format. | [optional] 
**description** | **String** | [Required] Include description of test result. 4000 Characters. | [optional] 
**type** | **String** | [Read-Only] Indicates the location in the Control Approval Chain when the test result is submitted. | [optional] 
**compliance_status** | **String** | [Required] Test result compliance status | [optional] 
