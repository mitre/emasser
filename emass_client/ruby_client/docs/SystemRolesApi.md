# EmassClient::SystemRolesApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_system_roles**](SystemRolesApi.md#get_system_roles) | **GET** /api/system-roles | Get available roles
[**get_system_roles_by_category_id**](SystemRolesApi.md#get_system_roles_by_category_id) | **GET** /api/system-roles/{roleCategory} | Get system roles

# **get_system_roles**
> SystemRolesResponse get_system_roles

Get available roles

Returns all available roles

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

api_instance = EmassClient::SystemRolesApi.new

begin
  #Get available roles
  result = api_instance.get_system_roles
  p result
rescue EmassClient::ApiError => e
  puts "Exception when calling SystemRolesApi->get_system_roles: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SystemRolesResponse**](SystemRolesResponse.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_system_roles_by_category_id**
> SystemRolesCategoryResponse get_system_roles_by_category_id(role_category, role, opts)

Get system roles

Returns the role(s) data matching parameters.

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

api_instance = EmassClient::SystemRolesApi.new
role_category = 'role_category_example' # String | **Role Category**: The system role category been queried
role = 'IAO' # String | **Role**: Accepts single value from options available at base system-roles endpoint e.g., SCA.
opts = { 
  policy: 'rmf', # String | **System Policy**: Filter query by system policy. If no value is specified and more than one policy is available, the default return is the RMF policy information.
  include_decommissioned: true # BOOLEAN | **Include Decommissioned Systems**: Indicates if decommissioned systems are retrieved. If no value is specified, the default returns true to include decommissioned systems.
}

begin
  #Get system roles
  result = api_instance.get_system_roles_by_category_id(role_category, role, opts)
  p result
rescue EmassClient::ApiError => e
  puts "Exception when calling SystemRolesApi->get_system_roles_by_category_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role_category** | **String**| **Role Category**: The system role category been queried | 
 **role** | **String**| **Role**: Accepts single value from options available at base system-roles endpoint e.g., SCA. | [default to IAO]
 **policy** | **String**| **System Policy**: Filter query by system policy. If no value is specified and more than one policy is available, the default return is the RMF policy information. | [optional] [default to rmf]
 **include_decommissioned** | **BOOLEAN**| **Include Decommissioned Systems**: Indicates if decommissioned systems are retrieved. If no value is specified, the default returns true to include decommissioned systems. | [optional] [default to true]

### Return type

[**SystemRolesCategoryResponse**](SystemRolesCategoryResponse.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



