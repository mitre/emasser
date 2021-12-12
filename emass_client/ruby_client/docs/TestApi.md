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

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



