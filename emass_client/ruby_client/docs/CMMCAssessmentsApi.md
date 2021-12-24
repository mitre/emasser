# SwaggerClient::CMMCAssessmentsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_cmmc_assessments**](CMMCAssessmentsApi.md#get_cmmc_assessments) | **GET** /api/cmmc-assessments | Get CMMC assessment information

# **get_cmmc_assessments**
> CmmcResponseGet get_cmmc_assessments(since_date)

Get CMMC assessment information

Get all CMMC assessment after the given date `sinceDate` parameter. It is available to CMMC eMASS only.

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

  # Configure API key authorization: mockType
  config.api_key['Prefer'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Prefer'] = 'Bearer'

  # Configure API key authorization: userid
  config.api_key['user-uid'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['user-uid'] = 'Bearer'
end

api_instance = SwaggerClient::CMMCAssessmentsApi.new
since_date = 'since_date_example' # String | **Date** CMMC date (Unix date format)


begin
  #Get CMMC assessment information
  result = api_instance.get_cmmc_assessments(since_date)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling CMMCAssessmentsApi->get_cmmc_assessments: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **since_date** | **String**| **Date** CMMC date (Unix date format) | 

### Return type

[**CmmcResponseGet**](CmmcResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



