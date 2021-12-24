# SwaggerClient::ArtifactsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_artifacts_by_system_id**](ArtifactsApi.md#add_artifacts_by_system_id) | **POST** /api/systems/{systemId}/artifacts | Add one or many artifacts in a system
[**delete_artifact**](ArtifactsApi.md#delete_artifact) | **DELETE** /api/systems/{systemId}/artifacts | Remove one or many artifacts in a system
[**get_system_artifacts**](ArtifactsApi.md#get_system_artifacts) | **GET** /api/systems/{systemId}/artifacts | Get one or many artifacts in a system
[**update_artifact_by_system_id**](ArtifactsApi.md#update_artifact_by_system_id) | **PUT** /api/systems/{systemId}/artifacts | Update one or many artifacts in a system

# **add_artifacts_by_system_id**
> ArtifactsResponsePutPost add_artifacts_by_system_id(is_templatetypecategoryzippersystem_id)

Add one or many artifacts in a system

<strong>Information</strong><br> The request body of a POST request through the Artifact Endpoint accepts a single binary file with file extension \".zip\" only. This accepted .zip file should contain one or more files corresponding to existing artifacts or new artifacts that will be created upon successful receipt. Filename uniqueness throughout eMASS will be enforced by the API.<br><br> Upon successful receipt of a file, if a file within the .zip is matched via filename to an artifact existing within the application, the file associated with the artifact will be updated. If no artifact is matched via filename to the application, a new artifact will be created with the following default values. Any values not specified below will be blank. <ul>   <li>isTemplate: false</li>   <li>type: other</li>   <li>category: evidence</li> </ul> To update values other than the file itself, please submit a PUT request.<br>  <strong>Zip file information</strong><br> Upload a zip file contain one or more files corresponding to existing artifacts or new artifacts that will be created upon successful receipt.<br><br> <strong>Business Rules</strong><br> Artifact cannot be saved if the file does not have the following file extensions:      .docx,.doc,.txt,.rtf,.xfdl,.xml,.mht,.mh,tml,.html,.htm,.pdf,.mdb,.accdb,.ppt,     .pptx,.xls,.xlsx,.csv,.log,.jpeg,.jpg,.tiff,.bmp,.tif,.png,.gif,.zip,.rar,.msg,     .vsd,.vsw,.vdx,.z{#},.ckl,.avi,.vsdx  Artifact version cannot be saved if an Artifact with the same file name already exist in the system.  Artifact cannot be saved if the file size exceeds 30MB.

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

api_instance = SwaggerClient::ArtifactsApi.new
is_template = true # BOOLEAN | 
type = 'type_example' # String | 
category = 'category_example' # String | 
zipper = 'zipper_example' # String | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Add one or many artifacts in a system
  result = api_instance.add_artifacts_by_system_id(is_templatetypecategoryzippersystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ArtifactsApi->add_artifacts_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **is_template** | **BOOLEAN**|  | 
 **type** | **String**|  | 
 **category** | **String**|  | 
 **zipper** | **String**|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ArtifactsResponsePutPost**](ArtifactsResponsePutPost.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json



# **delete_artifact**
> ArtifactsResponseDel delete_artifact(bodysystem_id)

Remove one or many artifacts in a system

Remove the Artifact(s) matching `systemId` path parameter and request body artifact(s) file name<br><br> <b>Note:</b> Multiple files can be deleted by providing multiple file names at the CL (comma delimited)  Example: --files file1.txt, file2.txt

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

api_instance = SwaggerClient::ArtifactsApi.new
body = [SwaggerClient::ArtifactsDeleteInner.new] # Array<ArtifactsDeleteInner> | See notes above for additional information
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Remove one or many artifacts in a system
  result = api_instance.delete_artifact(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ArtifactsApi->delete_artifact: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**Array&lt;ArtifactsDeleteInner&gt;**](ArtifactsDeleteInner.md)| See notes above for additional information | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ArtifactsResponseDel**](ArtifactsResponseDel.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_system_artifacts**
> ArtifactsResponseGet get_system_artifacts(system_id, opts)

Get one or many artifacts in a system

Returns selected artifacts matching parameters to include the file name containing the artifacts.

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

api_instance = SwaggerClient::ArtifactsApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  filename: 'filename_example', # String | **File Name**: The file name (to include file-extension).
  control_acronyms: 'control_acronyms_example', # String | **System Acronym**: Filter query by given system acronym (single or comma separated).
  ccis: 'ccis_example', # String | **CCI System**: Filter query by Control Correlation Identifiers (CCIs).
  system_only: true # BOOLEAN | **Systems Only**: Indicates that only system(s) information is retrieved.
}

begin
  #Get one or many artifacts in a system
  result = api_instance.get_system_artifacts(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ArtifactsApi->get_system_artifacts: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **filename** | **String**| **File Name**: The file name (to include file-extension). | [optional] 
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or comma separated). | [optional] 
 **ccis** | **String**| **CCI System**: Filter query by Control Correlation Identifiers (CCIs). | [optional] 
 **system_only** | **BOOLEAN**| **Systems Only**: Indicates that only system(s) information is retrieved. | [optional] [default to true]

### Return type

[**ArtifactsResponseGet**](ArtifactsResponseGet.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **update_artifact_by_system_id**
> ArtifactsResponsePutPost update_artifact_by_system_id(bodysystem_id)

Update one or many artifacts in a system

Updates an artifact for given `systemId` path parameter<br><br>  **Request Body Required Fields** - `filename` - `isTemplate` - `type` - `category`

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

api_instance = SwaggerClient::ArtifactsApi.new
body = SwaggerClient::ArtifactsRequestPutBody.new # ArtifactsRequestPutBody | See `information` above for additional instructions
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Update one or many artifacts in a system
  result = api_instance.update_artifact_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ArtifactsApi->update_artifact_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ArtifactsRequestPutBody**](ArtifactsRequestPutBody.md)| See &#x60;information&#x60; above for additional instructions | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ArtifactsResponsePutPost**](ArtifactsResponsePutPost.md)

### Authorization

[apikey](../README.md#apikey), [mockType](../README.md#mockType), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



