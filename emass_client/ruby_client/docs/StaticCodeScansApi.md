# SwaggerClient::StaticCodeScansApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_static_code_scans_by_system_id**](StaticCodeScansApi.md#add_static_code_scans_by_system_id) | **POST** /api/systems/{systemId}/static-code-scans | Upload static code scans or Clear static code scans

# **add_static_code_scans_by_system_id**
> Success200Response add_static_code_scans_by_system_id(bodysystem_id)

Upload static code scans or Clear static code scans

Upload or clear application scan findings into a system's `systemId` assets module.  **Note:** To clear an application's findings, use only the field `clearFindings` as the Request body and set it to true.

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

  # Configure API key authorization: mockType
  config.api_key['Prefer'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Prefer'] = 'Bearer'

  # Configure API key authorization: userid
  config.api_key['user-uid'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['user-uid'] = 'Bearer'
end

api_instance = SwaggerClient::StaticCodeScansApi.new
body = SwaggerClient::StaticCodeRequiredPost.new # StaticCodeRequiredPost | Update an existing Artifact by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Upload static code scans or Clear static code scans
  result = api_instance.add_static_code_scans_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling StaticCodeScansApi->add_static_code_scans_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**StaticCodeRequiredPost**](StaticCodeRequiredPost.md)| Update an existing Artifact by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Success200Response**](Success200Response.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



