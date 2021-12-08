# SwaggerClient::WorkflowDefinitionGet

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**description** | **String** | [Read-Only] Description of the workflow or the stage transition. For stage transitions, this matches the action dropdown that appears for PAC users. | [optional] 
**is_active** | **BOOLEAN** | [Read-Only] Returns true if the workflow is available to the site. | [optional] 
**name** | **String** | [Read-Only] Name of the workflow stage. | [optional] 
**version** | **String** | [Read-Only] Version of the workflow definition. | [optional] 
**workflow** | **String** | [Read-Only] The workflow type. | [optional] 
**stages** | [**Array&lt;Stage&gt;**](Stage.md) |  | [optional] 

