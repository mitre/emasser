# SwaggerClient::RegistrationApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**register_user**](RegistrationApi.md#register_user) | **POST** /api/api-key | Register user certificate and obtain an API key
[**register_user**](RegistrationApi.md#register_user) | **POST** /api/api-key | Register user certificate and obtain an API key

# **register_user**
> Register register_user(body)

Register user certificate and obtain an API key

Returns the api-key - This API key must be provided in the request header for all endpoint calls (api-key).

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::RegistrationApi.new
body = SwaggerClient::RegisterUser.new # RegisterUser | User certificate previously provided by eMASS.


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
 **body** | [**RegisterUser**](RegisterUser.md)| User certificate previously provided by eMASS. | 

### Return type

[**Register**](Register.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **register_user**
> Register register_user(user_uid)

Register user certificate and obtain an API key

Returns the api-key - This API key must be provided in the request header for all endpoint calls (api-key).

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::RegistrationApi.new
user_uid = 'user_uid_example' # String | 


begin
  #Register user certificate and obtain an API key
  result = api_instance.register_user(user_uid)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling RegistrationApi->register_user: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **user_uid** | **String**|  | 

### Return type

[**Register**](Register.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



