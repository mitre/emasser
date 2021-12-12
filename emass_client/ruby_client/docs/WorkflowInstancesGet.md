# SwaggerClient::WorkflowInstancesGet

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**created_date** | **Integer** | [Read-Only] Date the workflow instance or the workflow transition was created. | [optional] 
**current_stage** | **String** | [Read-Only] Name of the current stage. | [optional] 
**last_edited_by** | **String** | [Read-Only] User that last acted on the workflow. | [optional] 
**last_edited_date** | **Integer** | [Read-Only] Date the workflow was last acted on. | [optional] 
**package_name** | **String** | [Read-Only] The package name. | [optional] 
**system_name** | **String** | [Read-Only] The system name. | [optional] 
**version** | **String** | [Read-Only] Version of the workflow definition. | [optional] 
**workflow** | **String** | [Read-Only] The workflow type. | [optional] 
**workflow_instance_id** | **Integer** | [Read-Only] Unique workflow instance identifier. | [optional] 
**transitions** | [**Array&lt;InstancesTransitions&gt;**](InstancesTransitions.md) |  | [optional] 

