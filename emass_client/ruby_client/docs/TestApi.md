# SwaggerClient::TestApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**test_connection**](TestApi.md#test_connection) | **GET** /api | Test connection to the API

# **test_connection**
> Test test_connection

Test connection to the API

Returns endpoint call status

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::TestApi.new

begin
  #Test connection to the API
  result = api_instance.test_connection
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling TestApi->test_connection: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Test**](Test.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



