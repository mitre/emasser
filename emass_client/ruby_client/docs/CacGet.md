# EmassClient::CacGet

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**system_id** | **Integer** | [Required] Unique eMASS system identifier. | [optional] 
**control_acronym** | **String** | [Required] System acronym name. | [optional] 
**compliance_status** | **String** | [Read-only] Compliance status of the control. | [optional] 
**current_stage_name** | **String** | [Read-Only] Role in current stage. | [optional] 
**current_stage** | **Integer** | [Read-Only] Current step in the Control Approval Chain. | [optional] 
**total_stages** | **Integer** | [Read-Only] Total number of steps in Control Approval Chain. | [optional] 
**comments** | **String** | [Conditional] Control Approval Chain comments - 2000 Characters. | [optional] 

