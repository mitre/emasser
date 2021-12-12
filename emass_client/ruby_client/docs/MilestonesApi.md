# SwaggerClient::MilestonesApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_milestone_by_system_id_and_poam_id**](MilestonesApi.md#add_milestone_by_system_id_and_poam_id) | **POST** /api/systems/{systemId}/poams/{poamId}/milestones | Add milestones to one or many POA&amp;M items in a system
[**delete_milestone**](MilestonesApi.md#delete_milestone) | **DELETE** /api/systems/{systemId}/poams/{poamId}/milestones | Remove milestones in a system for one or many POA&amp;M items
[**get_system_milestones_by_poam_id**](MilestonesApi.md#get_system_milestones_by_poam_id) | **GET** /api/systems/{systemId}/poams/{poamId}/milestones | Get milestones in one or many POA&amp;M items in a system
[**get_system_milestones_by_poam_id_and_milestone_id**](MilestonesApi.md#get_system_milestones_by_poam_id_and_milestone_id) | **GET** /api/systems/{systemId}/poams/{poamId}/milestones/{milestoneId} | Get milestone by ID in POA&amp;M item in a system
[**update_milestone_by_system_id_and_poam_id**](MilestonesApi.md#update_milestone_by_system_id_and_poam_id) | **PUT** /api/systems/{systemId}/poams/{poamId}/milestones | Update one or many POA&amp;M items in a system

# **add_milestone_by_system_id_and_poam_id**
> MilestoneResponsePost add_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)

Add milestones to one or many POA&M items in a system

Adds a milestone for given `systemId` and `poamId` path parameters  **Request Body Required Fields** - `description` - `scheduledCompletionDate`

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

api_instance = SwaggerClient::MilestonesApi.new
body = SwaggerClient::MilestonesRequestPostBody.new # MilestonesRequestPostBody | Update an existing milestone
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Add milestones to one or many POA&M items in a system
  result = api_instance.add_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling MilestonesApi->add_milestone_by_system_id_and_poam_id: #{e}"
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
 - **Accept**: application/json



# **delete_milestone**
> Empty200Response delete_milestone(bodysystem_idpoam_id)

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

api_instance = SwaggerClient::MilestonesApi.new
body = SwaggerClient::DeleteMilestone.new # DeleteMilestone | Delete the given Milestone Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Remove milestones in a system for one or many POA&M items
  result = api_instance.delete_milestone(bodysystem_idpoam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling MilestonesApi->delete_milestone: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**DeleteMilestone**](DeleteMilestone.md)| Delete the given Milestone Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**Empty200Response**](Empty200Response.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_system_milestones_by_poam_id**
> MilestoneResponseGet get_system_milestones_by_poam_id(system_id, poam_id, opts)

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

api_instance = SwaggerClient::MilestonesApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.
opts = { 
  scheduled_completion_date_start: 'scheduled_completion_date_start_example', # String | **Date Started**: Filter query by the scheduled completion start date (Unix date format).
  scheduled_completion_date_end: 'scheduled_completion_date_end_example' # String | **Date Ended**: Filter query by the scheduled completion start date (Unix date format).
}

begin
  #Get milestones in one or many POA&M items in a system
  result = api_instance.get_system_milestones_by_poam_id(system_id, poam_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling MilestonesApi->get_system_milestones_by_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 
 **scheduled_completion_date_start** | **String**| **Date Started**: Filter query by the scheduled completion start date (Unix date format). | [optional] 
 **scheduled_completion_date_end** | **String**| **Date Ended**: Filter query by the scheduled completion start date (Unix date format). | [optional] 

### Return type

[**MilestoneResponseGet**](MilestoneResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_system_milestones_by_poam_id_and_milestone_id**
> MilestoneResponseGet get_system_milestones_by_poam_id_and_milestone_id(system_id, poam_id, milestone_id)

Get milestone by ID in POA&M item in a system

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

api_instance = SwaggerClient::MilestonesApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.
milestone_id = 56 # Integer | **Milestone Id**: The unique milestone record identifier.


begin
  #Get milestone by ID in POA&M item in a system
  result = api_instance.get_system_milestones_by_poam_id_and_milestone_id(system_id, poam_id, milestone_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling MilestonesApi->get_system_milestones_by_poam_id_and_milestone_id: #{e}"
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
 - **Accept**: application/json



# **update_milestone_by_system_id_and_poam_id**
> MilestoneResponsePut update_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)

Update one or many POA&M items in a system

Updates a milestone for given `systemId` and `poamId` path parameters  **Request Body Required Fields** - `milestoneId` - `description` - `scheduledCompletionDate`

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

api_instance = SwaggerClient::MilestonesApi.new
body = SwaggerClient::MilestonesRequestPutBody.new # MilestonesRequestPutBody | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Update one or many POA&M items in a system
  result = api_instance.update_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling MilestonesApi->update_milestone_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**MilestonesRequestPutBody**](MilestonesRequestPutBody.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**MilestoneResponsePut**](MilestoneResponsePut.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



