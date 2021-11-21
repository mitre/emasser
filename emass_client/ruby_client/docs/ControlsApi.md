# SwaggerClient::ControlsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_system_by_system_id**](ControlsApi.md#get_system_by_system_id) | **GET** /api/systems/{systemId}/controls | Get control information in a system for one or many controls
[**update_control_by_system_id**](ControlsApi.md#update_control_by_system_id) | **PUT** /api/systems/{systemId}/controls | Update control information in a system for one or many controls

# **get_system_by_system_id**
> ControlsResponseGet get_system_by_system_id(system_id, opts)

Get control information in a system for one or many controls

Returns system control information for matching `systemId` path parameter

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

api_instance = SwaggerClient::ControlsApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  acronyms: 'PM-6' # String | **Acronym**: The system acronym(s) being queried (single value or comma delimited values).
}

begin
  #Get control information in a system for one or many controls
  result = api_instance.get_system_by_system_id(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ControlsApi->get_system_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **acronyms** | **String**| **Acronym**: The system acronym(s) being queried (single value or comma delimited values). | [optional] [default to PM-6]

### Return type

[**ControlsResponseGet**](ControlsResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **update_control_by_system_id**
> ControlsResponsePut update_control_by_system_id(bodysystem_id)

Update control information in a system for one or many controls

Update an existing control by System Id based on the following rules:<br> | Implementation Status `implementationStatus` | Required Fields |----------------------------------------------|--------------------------------------------------- | Planned  or Implemented                      | `controlDesignation`, `estimatedCompletionDate`, `responsibleEntities`, `slcmCriticality`, `slcmFrequency`, `slcmMethod`, `slcmReporting`, `slcmTracking`, `slcmComments` | Not Applicable                               | `naJustification`, `controlDesignation`, `responsibleEntities` | Manually Inherited                           | `commonControlProvider`, `securityControlDesignation`, `estimatedCompletionDate`, `responsibleEntities`, `slcmCriticality`, `slcmFrequency`, `slcmMethod`, `slcmReporting`, `slcmTracking`, `slcmComments` | Inherited                                    | Only the following fields can be updated: `commonnControlProvider`, `controlDesignation`

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

api_instance = SwaggerClient::ControlsApi.new
body = SwaggerClient::ControlsRequestPutBody.new # ControlsRequestPutBody | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Update control information in a system for one or many controls
  result = api_instance.update_control_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ControlsApi->update_control_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ControlsRequestPutBody**](ControlsRequestPutBody.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ControlsResponsePut**](ControlsResponsePut.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/plain



