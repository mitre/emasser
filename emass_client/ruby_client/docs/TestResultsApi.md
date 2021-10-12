# SwaggerClient::TestResultsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_test_results_by_system_id**](TestResultsApi.md#add_test_results_by_system_id) | **POST** /api/systems/{systemId}/test-results | Add one or many test results in a system
[**add_test_results_by_system_id**](TestResultsApi.md#add_test_results_by_system_id) | **POST** /api/systems/{systemId}/test-results | Add one or many test results in a system
[**get_test_results_by_system_id**](TestResultsApi.md#get_test_results_by_system_id) | **GET** /api/systems/{systemId}/test-results | Get one or many test results in a system

# **add_test_results_by_system_id**
> Model200 add_test_results_by_system_id(bodysystem_id)

Add one or many test results in a system

Adds test results for given `systemId`

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::TestResultsApi.new
body = SwaggerClient::TestResults.new # TestResults | Update an existing control by Id
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
 **body** | [**TestResults**](TestResults.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **add_test_results_by_system_id**
> Model200 add_test_results_by_system_id(controlccisis_inheritedtested_bytest_datedescriptiontypecompliance_statussystem_id)

Add one or many test results in a system

Adds test results for given `systemId`

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::TestResultsApi.new
control = 'control_example' # String | 
ccis = 'ccis_example' # String | 
is_inherited = true # BOOLEAN | 
tested_by = 'tested_by_example' # String | 
test_date = 789 # Integer | 
description = 'description_example' # String | 
type = 'type_example' # String | 
compliance_status = 'compliance_status_example' # String | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Add one or many test results in a system
  result = api_instance.add_test_results_by_system_id(controlccisis_inheritedtested_bytest_datedescriptiontypecompliance_statussystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling TestResultsApi->add_test_results_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **control** | **String**|  | 
 **ccis** | **String**|  | 
 **is_inherited** | **BOOLEAN**|  | 
 **tested_by** | **String**|  | 
 **test_date** | **Integer**|  | 
 **description** | **String**|  | 
 **type** | **String**|  | 
 **compliance_status** | **String**|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **get_test_results_by_system_id**
> TestResultslResponse get_test_results_by_system_id(system_id, opts)

Get one or many test results in a system

Returns system test results information for matching parameters.<br>

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::TestResultsApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  control_acronyms: 'control_acronyms_example', # String | **System Acronym**: Filter query by given system acronym (single or common separated).
  ccis: 'ccis_example', # String | **CCI System**: Filter query by Control Correlation Identifiers (CCIs).
  latest_only: true # BOOLEAN | **Latest Results Only**: Indicates that only the latest test resultes are retrieved (single or common separated).
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
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or common separated). | [optional] 
 **ccis** | **String**| **CCI System**: Filter query by Control Correlation Identifiers (CCIs). | [optional] 
 **latest_only** | **BOOLEAN**| **Latest Results Only**: Indicates that only the latest test resultes are retrieved (single or common separated). | [optional] [default to true]

### Return type

[**TestResultslResponse**](TestResultslResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



