# SwaggerClient::RegistrationApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**register_user**](RegistrationApi.md#register_user) | **POST** /api/api-key | Register user certificate and obtain an API key

# **register_user**
> Register register_user(body)

Register user certificate and obtain an API key

Returns the api-key - This API key must be provided in the request header for all endpoint calls (api-key).

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

api_instance = SwaggerClient::RegistrationApi.new
body = SwaggerClient::RegisterUserRequestPostBody.new # RegisterUserRequestPostBody | User certificate previously provided by eMASS.


begin
  #Register user certificate and obtain an API key
  result = api_instance.register_user(body)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RegistrationApi->register_user: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**RegisterUserRequestPostBody**](RegisterUserRequestPostBody.md)| User certificate previously provided by eMASS. | 

### Return type

[**Register**](Register.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



