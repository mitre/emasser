# SwaggerClient::ApprovalChainApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_c_ac_approval_chain_by_system_id**](ApprovalChainApi.md#add_c_ac_approval_chain_by_system_id) | **POST** /api/systems/{systemId}/approval/cac | Submit control to second role of CAC
[**add_pac_approval_chain_by_system_id**](ApprovalChainApi.md#add_pac_approval_chain_by_system_id) | **POST** /api/systems/{systemId}/approval/pac | Submit system package for review
[**get_cac_approval_by_system_id**](ApprovalChainApi.md#get_cac_approval_by_system_id) | **GET** /api/systems/{systemId}/approval/cac | Get location of one or many controls in CAC
[**get_pac_approval_by_system_id**](ApprovalChainApi.md#get_pac_approval_by_system_id) | **GET** /api/systems/{systemId}/approval/pac | Get location of system package in PAC

# **add_c_ac_approval_chain_by_system_id**
> ApprovalCacResponsePost add_c_ac_approval_chain_by_system_id(bodysystem_id)

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

api_instance = SwaggerClient::ApprovalChainApi.new
body = SwaggerClient::ApprovalCacRequestPostBody.new # ApprovalCacRequestPostBody | Update an existing Artifact by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Submit control to second role of CAC
  result = api_instance.add_c_ac_approval_chain_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ApprovalChainApi->add_c_ac_approval_chain_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ApprovalCacRequestPostBody**](ApprovalCacRequestPostBody.md)| Update an existing Artifact by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ApprovalCacResponsePost**](ApprovalCacResponsePost.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/plain



# **add_pac_approval_chain_by_system_id**
> ApprovalPacResponsePost add_pac_approval_chain_by_system_id(bodysystem_id)

Submit system package for review

Adds a Package Approval Chain (PAC) for given `systemId` path parameter

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

api_instance = SwaggerClient::ApprovalChainApi.new
body = SwaggerClient::ApprovalPacRequestBodyPost.new # ApprovalPacRequestBodyPost | Update an existing Artifact by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Submit system package for review
  result = api_instance.add_pac_approval_chain_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ApprovalChainApi->add_pac_approval_chain_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ApprovalPacRequestBodyPost**](ApprovalPacRequestBodyPost.md)| Update an existing Artifact by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ApprovalPacResponsePost**](ApprovalPacResponsePost.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/plain



# **get_cac_approval_by_system_id**
> ApprovalCacResponseGet get_cac_approval_by_system_id(system_id, opts)

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

api_instance = SwaggerClient::ApprovalChainApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  control_acronyms: 'control_acronyms_example' # String | **System Acronym**: Filter query by given system acronym (single or comma separated).
}

begin
  #Get location of one or many controls in CAC
  result = api_instance.get_cac_approval_by_system_id(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ApprovalChainApi->get_cac_approval_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or comma separated). | [optional] 

### Return type

[**ApprovalCacResponseGet**](ApprovalCacResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **get_pac_approval_by_system_id**
> ApprovalPacResponseGet get_pac_approval_by_system_id(system_id)

Get location of system package in PAC

Returns the location of a system's package in the Package Approval Chain (PAC) for matching `systemId` path parameter<br><br> If the indicated system has an active package, the response will include the package type and the current role the package is sitting at. If there is no active package, then a null data member will be returned.

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

api_instance = SwaggerClient::ApprovalChainApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Get location of system package in PAC
  result = api_instance.get_pac_approval_by_system_id(system_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ApprovalChainApi->get_pac_approval_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ApprovalPacResponseGet**](ApprovalPacResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



