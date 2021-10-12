# SwaggerClient::ApprovalChainApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_c_ac_approval_chain_by_system_id**](ApprovalChainApi.md#add_c_ac_approval_chain_by_system_id) | **POST** /api/systems/{systemId}/approval/cac | Submit control to second role of CAC
[**add_c_ac_approval_chain_by_system_id**](ApprovalChainApi.md#add_c_ac_approval_chain_by_system_id) | **POST** /api/systems/{systemId}/approval/cac | Submit control to second role of CAC
[**add_pac_approval_chain_by_system_id**](ApprovalChainApi.md#add_pac_approval_chain_by_system_id) | **POST** /api/systems/{systemId}/approval/pac | Submit system package for review
[**add_pac_approval_chain_by_system_id**](ApprovalChainApi.md#add_pac_approval_chain_by_system_id) | **POST** /api/systems/{systemId}/approval/pac | Submit system package for review
[**get_cac_approval_by_system_id**](ApprovalChainApi.md#get_cac_approval_by_system_id) | **GET** /api/systems/{systemId}/approval/cac | Get location of one or many controls in CAC
[**get_pac_approval_by_system_id**](ApprovalChainApi.md#get_pac_approval_by_system_id) | **GET** /api/systems/{systemId}/approval/pac | Get location of system package in PAC

# **add_c_ac_approval_chain_by_system_id**
> Model200 add_c_ac_approval_chain_by_system_id(bodysystem_id)

Submit control to second role of CAC

Adds an Approval for given `systemId` path parameter<br><br> POST requests will only yield successful results if the control is currently sitting at the first role of the CAC. If the control is not currently sitting at the first role, then an error will be returned.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::ApprovalChainApi.new
body = SwaggerClient::PostApprovalCac.new # PostApprovalCac | Update an existing Artifact by Id
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
 **body** | [**PostApprovalCac**](PostApprovalCac.md)| Update an existing Artifact by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **add_c_ac_approval_chain_by_system_id**
> Model200 add_c_ac_approval_chain_by_system_id(control_acronymscommentssystem_id)

Submit control to second role of CAC

Adds an Approval for given `systemId` path parameter<br><br> POST requests will only yield successful results if the control is currently sitting at the first role of the CAC. If the control is not currently sitting at the first role, then an error will be returned.

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::ApprovalChainApi.new
control_acronyms = 'control_acronyms_example' # String | 
comments = 'comments_example' # String | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Submit control to second role of CAC
  result = api_instance.add_c_ac_approval_chain_by_system_id(control_acronymscommentssystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ApprovalChainApi->add_c_ac_approval_chain_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **control_acronyms** | **String**|  | 
 **comments** | **String**|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **add_pac_approval_chain_by_system_id**
> Model200 add_pac_approval_chain_by_system_id(bodysystem_id)

Submit system package for review

Adds a Package Approval Chain (PAC) for given `systemId` path parameter

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::ApprovalChainApi.new
body = SwaggerClient::PostApprovalPac.new # PostApprovalPac | Update an existing Artifact by Id
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
 **body** | [**PostApprovalPac**](PostApprovalPac.md)| Update an existing Artifact by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **add_pac_approval_chain_by_system_id**
> Model200 add_pac_approval_chain_by_system_id(typenamecommentssystem_id)

Submit system package for review

Adds a Package Approval Chain (PAC) for given `systemId` path parameter

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::ApprovalChainApi.new
type = 'type_example' # String | 
name = 'name_example' # String | 
comments = 'comments_example' # String | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Submit system package for review
  result = api_instance.add_pac_approval_chain_by_system_id(typenamecommentssystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ApprovalChainApi->add_pac_approval_chain_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | **String**|  | 
 **name** | **String**|  | 
 **comments** | **String**|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **get_cac_approval_by_system_id**
> ApprovalCacResponse get_cac_approval_by_system_id(system_id, opts)

Get location of one or many controls in CAC

Returns the location of a system's package in the Control Approval Chain (CAC) for matching `systemId` path parameter

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::ApprovalChainApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  control_acronyms: 'control_acronyms_example' # String | **System Acronym**: Filter query by given system acronym (single or common separated).
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
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or common separated). | [optional] 

### Return type

[**ApprovalCacResponse**](ApprovalCacResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **get_pac_approval_by_system_id**
> InlineResponse2001 get_pac_approval_by_system_id(system_id)

Get location of system package in PAC

Returns the location of a system's package in the Package Approval Chain (PAC) for matching `systemId` path parameter<br><br> If the indicated system has an active package, the response will include the package type and the current role the package is sitting at. If there is no active package, then a null data member will be returned.

### Example
```ruby
# load the gem
require 'swagger_client'

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

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



