# SwaggerClient::POAMApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_milestone_by_system_id_and_poam_id**](POAMApi.md#add_milestone_by_system_id_and_poam_id) | **POST** /api/systems/{systemId}/poams/{poamId}/milestones | Add milestones to one or many POA&amp;M items in a system
[**add_poam_by_system_id**](POAMApi.md#add_poam_by_system_id) | **POST** /api/systems/{systemId}/poams | Add one or many POA&amp;M items in a system
[**api_systems_system_id_poams_get**](POAMApi.md#api_systems_system_id_poams_get) | **GET** /api/systems/{systemId}/poams | Get one or many POA&amp;M items in a system
[**delete_milestone**](POAMApi.md#delete_milestone) | **DELETE** /api/systems/{systemId}/poams/{poamId}/milestones | Remove milestones in a system for one or many POA&amp;M items
[**delete_poam**](POAMApi.md#delete_poam) | **DELETE** /api/systems/{systemId}/poams | Remove one or many POA&amp;M items in a system
[**get_milestones_by_system_id_and_poam_id**](POAMApi.md#get_milestones_by_system_id_and_poam_id) | **GET** /api/systems/{systemId}/poams/{poamId}/milestones | Get milestones in one or many POA&amp;M items in a system
[**get_milestones_by_system_id_and_poam_id_andf_milestone_id**](POAMApi.md#get_milestones_by_system_id_and_poam_id_andf_milestone_id) | **GET** /api/systems/{systemId}/poams/{poamId}/milestones/{milestoneId} | Get milestone by id in POA&amp;M item in a system
[**get_poam_by_system_id_and_poam_id**](POAMApi.md#get_poam_by_system_id_and_poam_id) | **GET** /api/systems/{systemId}/poams/{poamId} | Get POA&amp;M item by id in a system
[**update_milestone_by_system_id_and_poam_id**](POAMApi.md#update_milestone_by_system_id_and_poam_id) | **PUT** /api/systems/{systemId}/poams/{poamId}/milestones | Update one or many POA&amp;M items in a system
[**update_poam_by_system_id**](POAMApi.md#update_poam_by_system_id) | **PUT** /api/systems/{systemId}/poams | Update one or many POA&amp;M items in a system

# **add_milestone_by_system_id_and_poam_id**
> MilestoneResponsePost add_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)

Add milestones to one or many POA&M items in a system

Adds a milestone for given `systemId` and `poamId` path parameters

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
body = SwaggerClient::MilestonesRequestPostBody.new # MilestonesRequestPostBody | Update an existing milestone
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Add milestones to one or many POA&M items in a system
  result = api_instance.add_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->add_milestone_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**MilestonesRequestPostBody**](MilestonesRequestPostBody.md)| Update an existing milestone | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**MilestoneResponsePost**](MilestoneResponsePost.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/plain



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
 - **Accept**: application/json, text/plain



# **api_systems_system_id_poams_get**
> PoamResponseGet api_systems_system_id_poams_get(system_id, opts)

Get one or many POA&M items in a system

Returns system containing POA&M items for matching parameters.

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
  scheduled_completion_date_start: 'scheduled_completion_date_start_example', # String | **Date Started**: Filter query by the scheduled competion start date.
  scheduled_completion_date_end: 'scheduled_completion_date_end_example', # String | **Date Ended**: Filter query by the scheduled competion start date.
  control_acronyms: 'control_acronyms_example', # String | **System Acronym**: Filter query by given system acronym (single or comma separated).
  cci: 'cci_example', # String | **CCI System**: Filter query by Control Correlation Identifiers (CCIs).
  system_only: true # BOOLEAN | **Systems Only**: Indicates that only system(s) information is retrieved.
}

begin
  #Get one or many POA&M items in a system
  result = api_instance.api_systems_system_id_poams_get(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->api_systems_system_id_poams_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **scheduled_completion_date_start** | **String**| **Date Started**: Filter query by the scheduled competion start date. | [optional] 
 **scheduled_completion_date_end** | **String**| **Date Ended**: Filter query by the scheduled competion start date. | [optional] 
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or comma separated). | [optional] 
 **cci** | **String**| **CCI System**: Filter query by Control Correlation Identifiers (CCIs). | [optional] 
 **system_only** | **BOOLEAN**| **Systems Only**: Indicates that only system(s) information is retrieved. | [optional] [default to true]

### Return type

[**PoamResponseGet**](PoamResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **delete_milestone**
> MilestonesDelete delete_milestone(system_id, poam_id, milestone_id)

Remove milestones in a system for one or many POA&M items

Remove the POA&M matching `systemId` path parameter<br> **Notes**<br> To delete a milestone the record must be inactive by having the field isActive set to false (`isActive=false`).

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
milestone_id = 56 # Integer | **Milestone Id**: The unique milestone record identifier.


begin
  #Remove milestones in a system for one or many POA&M items
  result = api_instance.delete_milestone(system_id, poam_id, milestone_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->delete_milestone: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 
 **milestone_id** | **Integer**| **Milestone Id**: The unique milestone record identifier. | 

### Return type

[**MilestonesDelete**](MilestonesDelete.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **delete_poam**
> PoamResponseDelete delete_poam(system_id, poam_id)

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
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Remove one or many POA&M items in a system
  result = api_instance.delete_poam(system_id, poam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->delete_poam: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**PoamResponseDelete**](PoamResponseDelete.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **get_milestones_by_system_id_and_poam_id**
> MilestoneResponseGet get_milestones_by_system_id_and_poam_id(system_id, poam_id, opts)

Get milestones in one or many POA&M items in a system

Returns system containing milestones for matching parameters.

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
opts = { 
  scheduled_completion_date_start: 'scheduled_completion_date_start_example', # String | **Date Started**: Filter query by the scheduled competion start date.
  scheduled_completion_date_end: 'scheduled_completion_date_end_example' # String | **Date Ended**: Filter query by the scheduled competion start date.
}

begin
  #Get milestones in one or many POA&M items in a system
  result = api_instance.get_milestones_by_system_id_and_poam_id(system_id, poam_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->get_milestones_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 
 **scheduled_completion_date_start** | **String**| **Date Started**: Filter query by the scheduled competion start date. | [optional] 
 **scheduled_completion_date_end** | **String**| **Date Ended**: Filter query by the scheduled competion start date. | [optional] 

### Return type

[**MilestoneResponseGet**](MilestoneResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **get_milestones_by_system_id_and_poam_id_andf_milestone_id**
> MilestoneResponseGet get_milestones_by_system_id_and_poam_id_andf_milestone_id(system_id, poam_id, milestone_id)

Get milestone by id in POA&M item in a system

Returns systems containing milestones for matching parameters.

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
milestone_id = 56 # Integer | **Milestone Id**: The unique milestone record identifier.


begin
  #Get milestone by id in POA&M item in a system
  result = api_instance.get_milestones_by_system_id_and_poam_id_andf_milestone_id(system_id, poam_id, milestone_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->get_milestones_by_system_id_and_poam_id_andf_milestone_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 
 **milestone_id** | **Integer**| **Milestone Id**: The unique milestone record identifier. | 

### Return type

[**MilestoneResponseGet**](MilestoneResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **get_poam_by_system_id_and_poam_id**
> PoamResponseGet get_poam_by_system_id_and_poam_id(system_id, poam_id)

Get POA&M item by id in a system

Returns system test results information for matching parameters.<br>

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
  #Get POA&M item by id in a system
  result = api_instance.get_poam_by_system_id_and_poam_id(system_id, poam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->get_poam_by_system_id_and_poam_id: #{e}"
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
 - **Accept**: application/json, text/plain



# **update_milestone_by_system_id_and_poam_id**
> MilestoneResponsePost update_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)

Update one or many POA&M items in a system

Updates a milestone for given `systemId` and `poamId` path parameters

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
body = SwaggerClient::MilestonesRequestPutBody.new # MilestonesRequestPutBody | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Update one or many POA&M items in a system
  result = api_instance.update_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->update_milestone_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**MilestonesRequestPutBody**](MilestonesRequestPutBody.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**MilestoneResponsePost**](MilestoneResponsePost.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/plain



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
 - **Accept**: application/json, text/plain



