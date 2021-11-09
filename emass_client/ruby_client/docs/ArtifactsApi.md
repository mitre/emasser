# SwaggerClient::ArtifactsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_artifacts_by_system_id**](ArtifactsApi.md#add_artifacts_by_system_id) | **POST** /api/systems/{systemId}/artifacts | Add one or many artifacts in a system
[**api_systems_system_id_artifacts_export_get**](ArtifactsApi.md#api_systems_system_id_artifacts_export_get) | **GET** /api/systems/{systemId}/artifacts-export | Get the file of an artifact in a system
[**api_systems_system_id_artifacts_get**](ArtifactsApi.md#api_systems_system_id_artifacts_get) | **GET** /api/systems/{systemId}/artifacts | Get one or many artifacts in a system
[**delete_artifact**](ArtifactsApi.md#delete_artifact) | **DELETE** /api/systems/{systemId}/artifacts | Remove one or many artifacts in a system
[**update_artifact_by_system_id**](ArtifactsApi.md#update_artifact_by_system_id) | **PUT** /api/systems/{systemId}/artifacts | Update one or many artifacts in a system
[**update_artifact_by_system_id**](ArtifactsApi.md#update_artifact_by_system_id) | **PUT** /api/systems/{systemId}/artifacts | Update one or many artifacts in a system

# **add_artifacts_by_system_id**
> ArtifactsPutPostResponse add_artifacts_by_system_id(zippersystem_id)

Add one or many artifacts in a system

<strong>Information</strong><br> The request body of a POST request through the Artifact Endpoint accepts a single binary file with file extension \".zip\" only. This accepted .zip file should contain one or more files corresponding to existing artifacts or new artifacts that will be created upon successful receipt. Filename uniqueness throughout eMASS will be enforced by the API.<br><br> Upon successful receipt of a file, if a file within the .zip is matched via filename to an artifact existing within the application, the file associated with the artifact will be updated. If no artifact is matched via filename to the application, a new artifact will be created with the following default values. Any values not specified below will be blank. <ul>   <li>isTemplate: false</li>   <li>type: other</li>   <li>category: evidence</li> </ul> To update values other than the file itself, please submit a PUT request.<br> -----------------------------------------------------------------------------------------------<br> <strong>Zip file information</strong><br> Upload a zip file contain one or more files corresponding to existing artifacts or new artifacts that will be created upon successful receipt.<br><br> <strong>Business Rules</strong><br> Artifact cannot be saved if the file does not have the following file extensions:      .docx,.doc,.txt,.rtf,.xfdl,.xml,.mht,.mh,tml,.html,.htm,.pdf,.mdb,.accdb,.ppt,     .pptx,.xls,.xlsx,.csv,.log,.jpeg,.jpg,.tiff,.bmp,.tif,.png,.gif,.zip,.rar,.msg,     .vsd,.vsw,.vdx,.z{#},.ckl,.avi,.vsdx  Artifact version cannot be saved if an Artifact with the same file name already exist in the system.  Artifact cannot be saved if the file size exceeds 30MB.          

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

api_instance = SwaggerClient::ArtifactsApi.new
zipper = 'zipper_example' # String | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Add one or many artifacts in a system
  result = api_instance.add_artifacts_by_system_id(zippersystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ArtifactsApi->add_artifacts_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **zipper** | **String**|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ArtifactsPutPostResponse**](ArtifactsPutPostResponse.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json, text/plain



# **api_systems_system_id_artifacts_export_get**
> ArtifactGetExportResponse api_systems_system_id_artifacts_export_get(system_id, filename, compress)

Get the file of an artifact in a system

<strong>Sample Responce</strong><br>  Binary file associated with given filename.<br>  If `compress` parameter is specified and set to `true`, the zip archive of binary file associated with given filename is returned.<br>  If `compress` parameter is specified and set to `false`, the zip archive contents associated with given filename is returned.<br>

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

api_instance = SwaggerClient::ArtifactsApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
filename = 'filename_example' # String | **File Name**: The file name (to include file-extension).
compress = true # BOOLEAN | **Compress File**: Determines if returned file is compressed.


begin
  #Get the file of an artifact in a system
  result = api_instance.api_systems_system_id_artifacts_export_get(system_id, filename, compress)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ArtifactsApi->api_systems_system_id_artifacts_export_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **filename** | **String**| **File Name**: The file name (to include file-extension). | 
 **compress** | **BOOLEAN**| **Compress File**: Determines if returned file is compressed. | [default to true]

### Return type

[**ArtifactGetExportResponse**](ArtifactGetExportResponse.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/octet-stream



# **api_systems_system_id_artifacts_get**
> ArtifactsGetResponse api_systems_system_id_artifacts_get(system_id, opts)

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
  cci: 'cci_example', # String | **CCI System**: Filter query by Control Correlation Identifiers (CCIs).
  system_only: true # BOOLEAN | **Systems Only**: Indicates that only system(s) information is retrieved.
}

begin
  #Get one or many artifacts in a system
  result = api_instance.api_systems_system_id_artifacts_get(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ArtifactsApi->api_systems_system_id_artifacts_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **filename** | **String**| **File Name**: The file name (to include file-extension). | [optional] 
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or comma separated). | [optional] 
 **cci** | **String**| **CCI System**: Filter query by Control Correlation Identifiers (CCIs). | [optional] 
 **system_only** | **BOOLEAN**| **Systems Only**: Indicates that only system(s) information is retrieved. | [optional] [default to true]

### Return type

[**ArtifactsGetResponse**](ArtifactsGetResponse.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **delete_artifact**
> ArtifactsDelResponse delete_artifact(bodysystem_id)

Remove one or many artifacts in a system

Remove the Artifact(s) matching `systemId` path parameter and request body artifact(s) file name<br><br> <b>Note:</b> The endpoint expects an array of objects containing `filename: file_to_delete`.  Multiple files can be deleted by providing multiple file objects (comma delimited)

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

api_instance = SwaggerClient::ArtifactsApi.new
body = [SwaggerClient::DeleteArtifactsInner.new] # Array<DeleteArtifactsInner> | See notes above for additional information
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
 **body** | [**Array&lt;DeleteArtifactsInner&gt;**](DeleteArtifactsInner.md)| See notes above for additional information | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ArtifactsDelResponse**](ArtifactsDelResponse.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/plain



# **update_artifact_by_system_id**
> ArtifactsPutPostResponse update_artifact_by_system_id(bodysystem_id)

Update one or many artifacts in a system

\"Updates an artifact for given `systemId` path parameter\"<br><br> <b>Business Rules</b></br> Artifact <b>cannot be saved</b> if the fields below exceed the following character limits:<br> `filename` 1000 characters, `description` 2000 characters, `refPageNumber` 50 characters  Artifact <b>cannot be saved</b> if the following fields are missing data:<br> `fileName`, `isTemplate`, `type`, and `category`

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

api_instance = SwaggerClient::ArtifactsApi.new
body = SwaggerClient::PutArtifacts.new # PutArtifacts | See notes above for additional information
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
 **body** | [**PutArtifacts**](PutArtifacts.md)| See notes above for additional information | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ArtifactsPutPostResponse**](ArtifactsPutPostResponse.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **update_artifact_by_system_id**
> ArtifactsPutPostResponse update_artifact_by_system_id(filenamedescriptionis_templatetypecategoryref_page_numbercontrolsccisartifact_expiration_datelast_review_datesystem_id)

Update one or many artifacts in a system

\"Updates an artifact for given `systemId` path parameter\"<br><br> <b>Business Rules</b></br> Artifact <b>cannot be saved</b> if the fields below exceed the following character limits:<br> `filename` 1000 characters, `description` 2000 characters, `refPageNumber` 50 characters  Artifact <b>cannot be saved</b> if the following fields are missing data:<br> `fileName`, `isTemplate`, `type`, and `category`

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

api_instance = SwaggerClient::ArtifactsApi.new
filename = 'filename_example' # String | 
description = 'description_example' # String | 
is_template = true # BOOLEAN | 
type = 'type_example' # String | 
category = 'category_example' # String | 
ref_page_number = 'ref_page_number_example' # String | 
controls = 'controls_example' # String | 
ccis = 'ccis_example' # String | 
artifact_expiration_date = 789 # Integer | 
last_review_date = 789 # Integer | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Update one or many artifacts in a system
  result = api_instance.update_artifact_by_system_id(filenamedescriptionis_templatetypecategoryref_page_numbercontrolsccisartifact_expiration_datelast_review_datesystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ArtifactsApi->update_artifact_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **filename** | **String**|  | 
 **description** | **String**|  | 
 **is_template** | **BOOLEAN**|  | 
 **type** | **String**|  | 
 **category** | **String**|  | 
 **ref_page_number** | **String**|  | 
 **controls** | **String**|  | 
 **ccis** | **String**|  | 
 **artifact_expiration_date** | **Integer**|  | 
 **last_review_date** | **Integer**|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**ArtifactsPutPostResponse**](ArtifactsPutPostResponse.md)

### Authorization

[apikey](../README.md#apikey), [userid](../README.md#userid)

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



