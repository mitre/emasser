# SwaggerClient::WorkflowDefinitionsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_workflow_definitions**](WorkflowDefinitionsApi.md#get_workflow_definitions) | **GET** /api/workflow-definitions | Get workflow definitions in a site

# **get_workflow_definitions**
> WorkflowDefinitionResponseGet get_workflow_definitions(opts)

Get workflow definitions in a site

View all workflow schemas available on the eMASS instance filtered by  status `includeInactive` and registration type `registrationType`.

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

api_instance = SwaggerClient::WorkflowDefinitionsApi.new
opts = { 
  include_inactive: true, # BOOLEAN | **Include Inactive**: If no value is specified, the default returns false to not include outdated workflow definitions.
  registration_type: ['registration_type_example'] # Array<String> | **Registration Type**: Filter record by selected registration type, accepts multiple comma separated values
}

begin
  #Get workflow definitions in a site
  result = api_instance.get_workflow_definitions(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling WorkflowDefinitionsApi->get_workflow_definitions: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **include_inactive** | **BOOLEAN**| **Include Inactive**: If no value is specified, the default returns false to not include outdated workflow definitions. | [optional] [default to true]
 **registration_type** | [**Array&lt;String&gt;**](String.md)| **Registration Type**: Filter record by selected registration type, accepts multiple comma separated values | [optional] 

### Return type

[**WorkflowDefinitionResponseGet**](WorkflowDefinitionResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



