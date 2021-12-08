# SwaggerClient::StaticCodeScansApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_pac_approval_chain_by_system_id**](StaticCodeScansApi.md#add_pac_approval_chain_by_system_id) | **POST** /api/systems/{systemId}/static-code-scans | Upload static code scans or Clear static code scans

# **add_pac_approval_chain_by_system_id**
> PacResponsePost add_pac_approval_chain_by_system_id(bodysystem_id)

Upload static code scans or Clear static code scans

Upload or clear application scan findings into a system’s `systemId` assets module.

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

api_instance = SwaggerClient::StaticCodeScansApi.new
body = SwaggerClient::PacRequestPostBody.new # PacRequestPostBody | Update an existing Artifact by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Upload static code scans or Clear static code scans
  result = api_instance.add_pac_approval_chain_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling StaticCodeScansApi->add_pac_approval_chain_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**PacRequestPostBody**](PacRequestPostBody.md)| Update an existing Artifact by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**PacResponsePost**](PacResponsePost.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



