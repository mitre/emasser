# SwaggerClient::CmmcGet

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**operation** | **String** | [Read-Only] Indicates the action that should be taken on the assessment record since the provided sinceDate. | [optional] 
**hq_organization_name** | **String** | [Read-Only] The name of the DIB Company. | [optional] 
**duns** | **String** | [Read-Only] The Data Universal Numbering System (DUNS) number. | [optional] 
**unique_entity_identifier** | **String** | [Read-Only] The Unique Entity Identifier assigned to the DIB Company. | [optional] 
**cage_codes** | **String** | [Read-Only] The five position code(s) associated with the Organization Seeking Certification (OSC). | [optional] 
**osc_name** | **String** | [Read-Only] The name of the Organization Seeking Certification. | [optional] 
**scope** | **String** | [Read-Only] The scope of the OSC assessment. | [optional] 
**scope_description** | **String** | [Read-Only] Brief description of the scope of the OSC assessment | [optional] 
**awarded_cmmc_level** | **String** | [Read-Only] The CMMC award level. | [optional] 
**expiration_date** | **Integer** | [Read-Only] Expiration date of the awarded CMMC certification. | [optional] 
**certificate_id** | **String** | [Read-Only] Unique identifier for the assessment/certificate. | [optional] 
**model_version** | **String** | [Read-Only] Version of the CMMC Model used as part of the assessment. | [optional] 
**ssps** | [**Array&lt;Ssps&gt;**](Ssps.md) |  | [optional] 

