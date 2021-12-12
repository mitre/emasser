# SwaggerClient::ArtifactsExportApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_system_artifacts_export**](ArtifactsExportApi.md#get_system_artifacts_export) | **GET** /api/systems/{systemId}/artifacts-export | Get the file of an artifact in a system

# **get_system_artifacts_export**
> String get_system_artifacts_export(system_id, filename, opts)

Get the file of an artifact in a system

<strong>Sample Responce</strong><br>  Binary file associated with given filename.<br>  If `compress` parameter is specified, zip archive of binary file associated with given filename.

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

api_instance = SwaggerClient::ArtifactsExportApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
filename = 'filename_example' # String | **File Name**: The file name (to include file-extension).
opts = { 
  compress: true # BOOLEAN | **Compress File**: Determines if returned file is compressed.
}

begin
  #Get the file of an artifact in a system
  result = api_instance.get_system_artifacts_export(system_id, filename, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ArtifactsExportApi->get_system_artifacts_export: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **filename** | **String**| **File Name**: The file name (to include file-extension). | 
 **compress** | **BOOLEAN**| **Compress File**: Determines if returned file is compressed. | [optional] [default to true]

### Return type

**String**

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/octet-stream, application/json



