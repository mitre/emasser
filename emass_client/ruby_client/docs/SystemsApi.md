# SwaggerClient::SystemsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_systems**](SystemsApi.md#get_systems) | **GET** /api/systems | Get system information matching provided parameters

# **get_systems**
> InlineResponse200 get_systems(opts)

Get system information matching provided parameters

Returns the system(s) data matching parameters<br>   **Notes**<br>   <ul>     <li>If a system is dual-policy enabled, the returned system details default to the RMF policy information unless otherwise specified for an individual system.</li>     <li>Certain fields are instance specific and may not be returned in GET request.</li>   </ul>

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

api_instance = SwaggerClient::SystemsApi.new
opts = { 
  include_package: true, # BOOLEAN | **Include Package**:  Indicates if additional packages information is retrieved for queried system.
  registration_type: ['registration_type_example'], # Array<String> | **Registration Type**: Filter record by selected registration type, accepts multiple comma separated values
  ditpr_id: 'ditpr_id_example', # String | **DITPR ID**: Filter query by DoD Information Technology (IT) Portfolio Repository (DITPR).
  coams_id: 'coams_id_example', # String | **COAMS ID**: Filter query by Cyber Operational Attributes Management System (COAMS).
  policy: 'rmf', # String | **System Policy**: Filter query by system policy. If no value is specified and more than one policy is available, the default return is the RMF policy information.
  include_ditpr_metrics: false, # BOOLEAN | **Include DITPR**: Indicates if DITPR metrics are retrieved. This query string parameter can only be used in conjunction with the following parameters:<br>   <ul>     <li>registrationType</li>     <li>policy</li>   </ul>
  include_decommissioned: true # BOOLEAN | **Include Decommissioned Systems**: Indicates if decommissioned systems are retrieved. If no value is specified, the default returns true to include systems with a “Decommissioned” Authorization Status value.
}

begin
  #Get system information matching provided parameters
  result = api_instance.get_systems(opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling SystemsApi->get_systems: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **include_package** | **BOOLEAN**| **Include Package**:  Indicates if additional packages information is retrieved for queried system. | [optional] [default to true]
 **registration_type** | [**Array&lt;String&gt;**](String.md)| **Registration Type**: Filter record by selected registration type, accepts multiple comma separated values | [optional] 
 **ditpr_id** | **String**| **DITPR ID**: Filter query by DoD Information Technology (IT) Portfolio Repository (DITPR). | [optional] 
 **coams_id** | **String**| **COAMS ID**: Filter query by Cyber Operational Attributes Management System (COAMS). | [optional] 
 **policy** | **String**| **System Policy**: Filter query by system policy. If no value is specified and more than one policy is available, the default return is the RMF policy information. | [optional] [default to rmf]
 **include_ditpr_metrics** | **BOOLEAN**| **Include DITPR**: Indicates if DITPR metrics are retrieved. This query string parameter can only be used in conjunction with the following parameters:&lt;br&gt;   &lt;ul&gt;     &lt;li&gt;registrationType&lt;/li&gt;     &lt;li&gt;policy&lt;/li&gt;   &lt;/ul&gt; | [optional] [default to false]
 **include_decommissioned** | **BOOLEAN**| **Include Decommissioned Systems**: Indicates if decommissioned systems are retrieved. If no value is specified, the default returns true to include systems with a “Decommissioned” Authorization Status value. | [optional] [default to true]

### Return type

[**InlineResponse200**](InlineResponse200.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



