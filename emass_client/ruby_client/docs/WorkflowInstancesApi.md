# SwaggerClient::WorkflowInstancesApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_system_workflow_instances**](WorkflowInstancesApi.md#get_system_workflow_instances) | **GET** /api/systems/{systemId}/workflow-instances | Get workflow instances in a system
[**get_system_workflow_instances_by_workflow_instance_id**](WorkflowInstancesApi.md#get_system_workflow_instances_by_workflow_instance_id) | **GET** /api/systems/{systemId}/workflow-instances/{workflowInstanceId} | Get workflow instance by ID in a system

# **get_system_workflow_instances**
> WorkflowInstancesResponseGet get_system_workflow_instances(system_id, opts)

Get workflow instances in a system

View detailed information on all active and historical workflows for a system `systemId` and filtered by provided parameters.

### Example
```ruby
# load the gem
require 'swagger_client'
# setup authorization
SwaggerClient.configure do |config|
  # Configure API key authorization: apikey
  config.api_key['api-key'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['api-key'] = 'Bearer'

  # Configure API key authorization: userid
  config.api_key['user-uid'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['user-uid'] = 'Bearer'
end

api_instance = SwaggerClient::WorkflowInstancesApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  include_comments: true, # BOOLEAN | **Include Comments**: If no value is specified, the default returns true to not include transition comments.  Note: Corresponds to the Comments textbox that is required at most workflow transitions. Does not include other text input fields such as Terms / Conditions for Authorization. 
  page_index: 0, # Integer | **Page Index**: If no value is specified, the default returns true to not include transition comments.
  since_date: 'since_date_example', # String | **Date**: Filter on authorization/assessment date (Unix date format).  Note: Filters off the lastEditedDate field.  Note: The authorization/assessment decisions on completed workflows  can be edited for up to 30 days after the initial decision is made. 
  status: 'all' # String | **Status**: Filter by status.  If no value is specified, the default returns all to include both active and inactive workflows.  Note: Any workflows at a current stage of Complete or Cancelled are inactive. Ongoing workflows currently at other stages are active. 
}

begin
  #Get workflow instances in a system
  result = api_instance.get_system_workflow_instances(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling WorkflowInstancesApi->get_system_workflow_instances: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **include_comments** | **BOOLEAN**| **Include Comments**: If no value is specified, the default returns true to not include transition comments.  Note: Corresponds to the Comments textbox that is required at most workflow transitions. Does not include other text input fields such as Terms / Conditions for Authorization.  | [optional] [default to true]
 **page_index** | **Integer**| **Page Index**: If no value is specified, the default returns true to not include transition comments. | [optional] [default to 0]
 **since_date** | **String**| **Date**: Filter on authorization/assessment date (Unix date format).  Note: Filters off the lastEditedDate field.  Note: The authorization/assessment decisions on completed workflows  can be edited for up to 30 days after the initial decision is made.  | [optional] 
 **status** | **String**| **Status**: Filter by status.  If no value is specified, the default returns all to include both active and inactive workflows.  Note: Any workflows at a current stage of Complete or Cancelled are inactive. Ongoing workflows currently at other stages are active.  | [optional] [default to all]

### Return type

[**WorkflowInstancesResponseGet**](WorkflowInstancesResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_system_workflow_instances_by_workflow_instance_id**
> WorkflowInstancesResponseGet get_system_workflow_instances_by_workflow_instance_id(system_id, workflow_instance_id)

Get workflow instance by ID in a system

View detailed information on all active and historical workflows for a system `systemId` and `workflowInstanceId`.

### Example
```ruby
# load the gem
require 'swagger_client'
# setup authorization
SwaggerClient.configure do |config|
  # Configure API key authorization: apikey
  config.api_key['api-key'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['api-key'] = 'Bearer'

  # Configure API key authorization: userid
  config.api_key['user-uid'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['user-uid'] = 'Bearer'
end

api_instance = SwaggerClient::WorkflowInstancesApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
workflow_instance_id = 56 # Integer | **Workflow Instance Id**: The unique milestone record identifier.


begin
  #Get workflow instance by ID in a system
  result = api_instance.get_system_workflow_instances_by_workflow_instance_id(system_id, workflow_instance_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling WorkflowInstancesApi->get_system_workflow_instances_by_workflow_instance_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **workflow_instance_id** | **Integer**| **Workflow Instance Id**: The unique milestone record identifier. | 

### Return type

[**WorkflowInstancesResponseGet**](WorkflowInstancesResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



