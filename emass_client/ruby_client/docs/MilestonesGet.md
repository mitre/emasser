# EmassClient::MilestonesGet

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**system_id** | **Integer** | [Required] Unique eMASS system identifier. | [optional] 
**milestone_id** | **Integer** | [Required] Unique item identifier | [optional] 
**poam_id** | **Integer** | [Required] Unique item identifier | [optional] 
**description** | **String** | [Required] Include milestone description. | [optional] 
**scheduled_completion_date** | **Integer** | [Required] Required for ongoing and completed POA&amp;M items. Unix time format. | [optional] 
**review_status** | **String** | [Read-Only] Values include the following options: (Not Approved,Under Review,Approved) | [optional] 

