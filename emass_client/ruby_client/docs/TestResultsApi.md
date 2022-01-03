# EmassClient::TestResultsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_test_results_by_system_id**](TestResultsApi.md#add_test_results_by_system_id) | **POST** /api/systems/{systemId}/test-results | Add one or many test results in a system
[**get_system_test_results**](TestResultsApi.md#get_system_test_results) | **GET** /api/systems/{systemId}/test-results | Get one or many test results in a system

# **add_test_results_by_system_id**
> TestResultsResponsePost add_test_results_by_system_id(bodysystem_id)

Add one or many test results in a system

Adds test results for given `systemId`  **Request Body Required Fields** - `cci` - `testedBy` - `testDate` - `description` - `complianceStatus`

### Example
```ruby
# load the gem
require 'emass_client'
# setup authorization
EmassClient.configure do |config|
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

api_instance = EmassClient::TestResultsApi.new
body = EmassClient::TestResultsRequestPostBody.new # TestResultsRequestPostBody | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Add one or many test results in a system
  result = api_instance.add_test_results_by_system_id(bodysystem_id)
  p result
rescue EmassClient::ApiError => e
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

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_system_test_results**
> TestResultsResponseGet get_system_test_results(system_id, opts)

Get one or many test results in a system

Returns system test results information for matching parameters.<br>

### Example
```ruby
# load the gem
require 'emass_client'
# setup authorization
EmassClient.configure do |config|
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

api_instance = EmassClient::TestResultsApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  control_acronyms: 'control_acronyms_example', # String | **System Acronym**: Filter query by given system acronym (single or comma separated).
  ccis: 'ccis_example', # String | **CCI System**: Filter query by Control Correlation Identifiers (CCIs).
  latest_only: true # BOOLEAN | **Latest Results Only**: Indicates that only the latest test resultes are retrieved (single or comma separated).
}

begin
  #Get one or many test results in a system
  result = api_instance.get_system_test_results(system_id, opts)
  p result
rescue EmassClient::ApiError => e
  puts "Exception when calling TestResultsApi->get_system_test_results: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or comma separated). | [optional] 
 **ccis** | **String**| **CCI System**: Filter query by Control Correlation Identifiers (CCIs). | [optional] 
 **latest_only** | **BOOLEAN**| **Latest Results Only**: Indicates that only the latest test resultes are retrieved (single or comma separated). | [optional] [default to true]

### Return type

[**TestResultsResponseGet**](TestResultsResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



