# SwaggerClient::ApprovalPacGet

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** | [Required] Values include the following:(Assess and Authorize, Assess Only, Security Plan) | [optional] 
**name** | **String** | [Required] Package name. 100 Characters. | [optional] 
**current_role** | **String** | [Read-Only] Current role in active package. | [optional] 
**current_step** | **Integer** | [Read-Only] Current step in the Package Approval Chain. | [optional] 
**total_steps** | **Integer** | [Read-Only] Total number of steps in Package Approval Chain. | [optional] 
**comments** | **String** | [Required] Character Limit &#x3D; 2,000. | [optional] 

