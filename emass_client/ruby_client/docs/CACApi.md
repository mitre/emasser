# SwaggerClient::CACApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_system_cac**](CACApi.md#add_system_cac) | **POST** /api/systems/{systemId}/approval/cac | Submit control to second role of CAC
[**get_system_cac**](CACApi.md#get_system_cac) | **GET** /api/systems/{systemId}/approval/cac | Get location of one or many controls in CAC

# **add_system_cac**
> CacResponsePost add_system_cac(bodysystem_id)

Submit control to second role of CAC

Adds an Approval for given `systemId` path parameter<br><br> POST requests will only yield successful results if the control is currently sitting at the first role of the CAC. If the control is not currently sitting at the first role, then an error will be returned.

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

api_instance = SwaggerClient::CACApi.new
body = SwaggerClient::CacRequestPostBody.new # CacRequestPostBody | Update an existing Artifact by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Submit control to second role of CAC
  result = api_instance.add_system_cac(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling CACApi->add_system_cac: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CacRequestPostBody**](CacRequestPostBody.md)| Update an existing Artifact by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**CacResponsePost**](CacResponsePost.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_system_cac**
> CacResponseGet get_system_cac(system_id, opts)

Get location of one or many controls in CAC

Returns the location of a system's package in the Control Approval Chain (CAC) for matching `systemId` path parameter

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

api_instance = SwaggerClient::CACApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  control_acronyms: 'control_acronyms_example' # String | **System Acronym**: Filter query by given system acronym (single or comma separated).
}

begin
  #Get location of one or many controls in CAC
  result = api_instance.get_system_cac(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling CACApi->get_system_cac: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or comma separated). | [optional] 

### Return type

[**CacResponseGet**](CacResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



