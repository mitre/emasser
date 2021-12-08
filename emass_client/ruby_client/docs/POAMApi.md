# SwaggerClient::POAMApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_poam_by_system_id**](POAMApi.md#add_poam_by_system_id) | **POST** /api/systems/{systemId}/poams | Add one or many POA&amp;M items in a system
[**delete_poam**](POAMApi.md#delete_poam) | **DELETE** /api/systems/{systemId}/poams | Remove one or many POA&amp;M items in a system
[**get_system_poams**](POAMApi.md#get_system_poams) | **GET** /api/systems/{systemId}/poams | Get one or many POA&amp;M items in a system
[**get_system_poams_by_poam_id**](POAMApi.md#get_system_poams_by_poam_id) | **GET** /api/systems/{systemId}/poams/{poamId} | Get POA&amp;M item by ID in a system
[**update_poam_by_system_id**](POAMApi.md#update_poam_by_system_id) | **PUT** /api/systems/{systemId}/poams | Update one or many POA&amp;M items in a system

# **add_poam_by_system_id**
> PoamResponsePost add_poam_by_system_id(bodysystem_id)

Add one or many POA&M items in a system

Add a POA&M for given `systemId`<br>  **Request Body Required Fields** - `status` - `vulnerabilityDescription` - `sourceIdentVuln` - `reviewStatus`  **Note**<br /> If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are **required** within the request.<br> `pocOrganization`, `pocFirstName`, `pocLastName`, `pocEmail`, `pocPhoneNumber`<br />

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

api_instance = SwaggerClient::POAMApi.new
body = SwaggerClient::PoamRequiredPost.new # PoamRequiredPost | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Add one or many POA&M items in a system
  result = api_instance.add_poam_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->add_poam_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**PoamRequiredPost**](PoamRequiredPost.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**PoamResponsePost**](PoamResponsePost.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **delete_poam**
> PoamResponseDelete delete_poam(bodysystem_id)

Remove one or many POA&M items in a system

Remove the POA&M matching `systemId` path parameter and `poamId` query parameter<br>

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

api_instance = SwaggerClient::POAMApi.new
body = SwaggerClient::DeletePoam.new # DeletePoam | Delete the given POA&M Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Remove one or many POA&M items in a system
  result = api_instance.delete_poam(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->delete_poam: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**DeletePoam**](DeletePoam.md)| Delete the given POA&amp;M Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**PoamResponseDelete**](PoamResponseDelete.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_system_poams**
> PoamResponseGet get_system_poams(system_id, opts)

Get one or many POA&M items in a system

Returns system(s) containing POA&M items for matching parameters.

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

api_instance = SwaggerClient::POAMApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  scheduled_completion_date_start: 'scheduled_completion_date_start_example', # String | **Date Started**: Filter query by the scheduled completion start date (Unix date format).
  scheduled_completion_date_end: 'scheduled_completion_date_end_example', # String | **Date Ended**: Filter query by the scheduled completion start date (Unix date format).
  control_acronyms: 'control_acronyms_example', # String | **System Acronym**: Filter query by given system acronym (single or comma separated).
  ccis: 'ccis_example', # String | **CCI System**: Filter query by Control Correlation Identifiers (CCIs).
  system_only: true # BOOLEAN | **Systems Only**: Indicates that only system(s) information is retrieved.
}

begin
  #Get one or many POA&M items in a system
  result = api_instance.get_system_poams(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->get_system_poams: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **scheduled_completion_date_start** | **String**| **Date Started**: Filter query by the scheduled completion start date (Unix date format). | [optional] 
 **scheduled_completion_date_end** | **String**| **Date Ended**: Filter query by the scheduled completion start date (Unix date format). | [optional] 
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or comma separated). | [optional] 
 **ccis** | **String**| **CCI System**: Filter query by Control Correlation Identifiers (CCIs). | [optional] 
 **system_only** | **BOOLEAN**| **Systems Only**: Indicates that only system(s) information is retrieved. | [optional] [default to true]

### Return type

[**PoamResponseGet**](PoamResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_system_poams_by_poam_id**
> PoamResponseGet get_system_poams_by_poam_id(system_id, poam_id)

Get POA&M item by ID in a system

Returns system(s) containing POA&M items for matching parameters.

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

api_instance = SwaggerClient::POAMApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Get POA&M item by ID in a system
  result = api_instance.get_system_poams_by_poam_id(system_id, poam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->get_system_poams_by_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**PoamResponseGet**](PoamResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **update_poam_by_system_id**
> PoamResponsePut update_poam_by_system_id(bodysystem_id)

Update one or many POA&M items in a system

Update a POA&M for given `systemId`<br>  **Request Body Required Fields** - `poamId` - `status` - `vulnerabilityDescription` - `sourceIdentVuln` - `reviewStatus`  **Notes** - If a POC email is supplied, the application will attempt to locate a user already   registered within the application and pre-populate any information not explicitly supplied   in the request. If no such user is found, these fields are **required** within the request.<br>   `pocOrganization`, `pocFirstName`, `pocLastName`, `pocEmail`, `pocPhoneNumber`<br />  - To delete a milestone through the POA&M PUT the field `isActive` must be set to `false`: `isActive=false`.

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

api_instance = SwaggerClient::POAMApi.new
body = SwaggerClient::PoamRequiredPut.new # PoamRequiredPut | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Update one or many POA&M items in a system
  result = api_instance.update_poam_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->update_poam_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**PoamRequiredPut**](PoamRequiredPut.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**PoamResponsePut**](PoamResponsePut.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



