# SwaggerClient::TestResultsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_test_results_by_system_id**](TestResultsApi.md#add_test_results_by_system_id) | **POST** /api/systems/{systemId}/test-results | Add one or many test results in a system
[**get_test_results_by_system_id**](TestResultsApi.md#get_test_results_by_system_id) | **GET** /api/systems/{systemId}/test-results | Get one or many test results in a system

# **add_test_results_by_system_id**
> TestResultsResponsePost add_test_results_by_system_id(bodysystem_id)

Add one or many test results in a system

Adds test results for given `systemId`

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

api_instance = SwaggerClient::TestResultsApi.new
body = SwaggerClient::TestResultsRequestPostBody.new # TestResultsRequestPostBody | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Add one or many test results in a system
  result = api_instance.add_test_results_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling TestResultsApi->add_test_results_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**TestResultsRequestPostBody**](TestResultsRequestPostBody.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**TestResultsResponsePost**](TestResultsResponsePost.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/plain



# **get_test_results_by_system_id**
> TestResultsResponseGet get_test_results_by_system_id(system_id, opts)

Get one or many test results in a system

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

api_instance = SwaggerClient::TestResultsApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  control_acronyms: 'control_acronyms_example', # String | **System Acronym**: Filter query by given system acronym (single or comma separated).
  cci: 'cci_example', # String | **CCI System**: Filter query by Control Correlation Identifiers (CCIs).
  latest_only: true # BOOLEAN | **Latest Results Only**: Indicates that only the latest test resultes are retrieved (single or comma separated).
}

begin
  #Get one or many test results in a system
  result = api_instance.get_test_results_by_system_id(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling TestResultsApi->get_test_results_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or comma separated). | [optional] 
 **cci** | **String**| **CCI System**: Filter query by Control Correlation Identifiers (CCIs). | [optional] 
 **latest_only** | **BOOLEAN**| **Latest Results Only**: Indicates that only the latest test resultes are retrieved (single or comma separated). | [optional] [default to true]

### Return type

[**TestResultsResponseGet**](TestResultsResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



