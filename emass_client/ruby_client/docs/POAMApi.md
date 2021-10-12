# SwaggerClient::POAMApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**add_milestone_by_system_id_and_poam_id**](POAMApi.md#add_milestone_by_system_id_and_poam_id) | **POST** /api/systems/{systemId}/poams/{poamId}/milestones | Add milestones to one or many poa&amp;m items in a system
[**add_milestone_by_system_id_and_poam_id**](POAMApi.md#add_milestone_by_system_id_and_poam_id) | **POST** /api/systems/{systemId}/poams/{poamId}/milestones | Add milestones to one or many poa&amp;m items in a system
[**add_poam_by_system_id**](POAMApi.md#add_poam_by_system_id) | **POST** /api/systems/{systemId}/poams | Add one or many poa&amp;m items in a system
[**add_poam_by_system_id**](POAMApi.md#add_poam_by_system_id) | **POST** /api/systems/{systemId}/poams | Add one or many poa&amp;m items in a system
[**api_systems_system_id_poams_get**](POAMApi.md#api_systems_system_id_poams_get) | **GET** /api/systems/{systemId}/poams | Get one or many poa&amp;m items in a system
[**delete_milestone**](POAMApi.md#delete_milestone) | **DELETE** /api/systems/{systemId}/poams/{poamId}/milestones | Remove milestones in a system for one or many poa&amp;m items
[**delete_poam**](POAMApi.md#delete_poam) | **DELETE** /api/systems/{systemId}/poams | Remove one or many poa&amp;m items in a system
[**get_milestones_by_system_id_and_poam_id**](POAMApi.md#get_milestones_by_system_id_and_poam_id) | **GET** /api/systems/{systemId}/poams/{poamId}/milestones | Get milestones in one or many poa&amp;m items in a system
[**get_milestones_by_system_id_and_poam_id_andf_milestone_id**](POAMApi.md#get_milestones_by_system_id_and_poam_id_andf_milestone_id) | **GET** /api/systems/{systemId}/poams/{poamId}/milestones/{milestoneId} | Get milestone by id in poa&amp;m item in a system
[**get_poam_by_system_id_and_poam_id**](POAMApi.md#get_poam_by_system_id_and_poam_id) | **GET** /api/systems/{systemId}/poams/{poamId} | Get poa&amp;m item by id in a system
[**update_milestone_by_system_id_and_poam_id**](POAMApi.md#update_milestone_by_system_id_and_poam_id) | **PUT** /api/systems/{systemId}/poams/{poamId}/milestones | Update one or many poa&amp;m items in a system
[**update_milestone_by_system_id_and_poam_id**](POAMApi.md#update_milestone_by_system_id_and_poam_id) | **PUT** /api/systems/{systemId}/poams/{poamId}/milestones | Update one or many poa&amp;m items in a system
[**update_poam_by_system_id**](POAMApi.md#update_poam_by_system_id) | **PUT** /api/systems/{systemId}/poams | Update one or many poa&amp;m items in a system
[**update_poam_by_system_id**](POAMApi.md#update_poam_by_system_id) | **PUT** /api/systems/{systemId}/poams | Update one or many poa&amp;m items in a system

# **add_milestone_by_system_id_and_poam_id**
> Model200 add_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)

Add milestones to one or many poa&m items in a system

Adds a milestone for given `systemId` and `poamId` path parameters

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
body = SwaggerClient::PostMilestones.new # PostMilestones | Update an existing milestone
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Add milestones to one or many poa&m items in a system
  result = api_instance.add_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->add_milestone_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**PostMilestones**](PostMilestones.md)| Update an existing milestone | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **add_milestone_by_system_id_and_poam_id**
> Model200 add_milestone_by_system_id_and_poam_id(poam_id2descriptionscheduled_completion_datesystem_idpoam_id)

Add milestones to one or many poa&m items in a system

Adds a milestone for given `systemId` and `poamId` path parameters

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
poam_id2 = 789 # Integer | 
description = 'description_example' # String | 
scheduled_completion_date = 789 # Integer | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Add milestones to one or many poa&m items in a system
  result = api_instance.add_milestone_by_system_id_and_poam_id(poam_id2descriptionscheduled_completion_datesystem_idpoam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->add_milestone_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **poam_id2** | **Integer**|  | 
 **description** | **String**|  | 
 **scheduled_completion_date** | **Integer**|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **add_poam_by_system_id**
> Model200 add_poam_by_system_id(bodysystem_id)

Add one or many poa&m items in a system

Adds POA&M for given `systemId`<br> **Note**<br> If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request.<br> `pocOrganization`, `pocFirstName`, `pocLastName`, `pocEmail`, `pocPhoneNumber`

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
body = SwaggerClient::POAM.new # POAM | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Add one or many poa&m items in a system
  result = api_instance.add_poam_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->add_poam_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**POAM**](POAM.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **add_poam_by_system_id**
> Model200 add_poam_by_system_id(poam_idis_inheritedexternal_uidcontrol_acronymsccissystem_onlyseverityraw_severitystatusreview_statusscheduled_completion_datecompletion_dateextension_datescheduled_completion_date_startscheduled_completion_date_endpoc_organizationpoc_first_namepoc_last_namepoc_emailpoc_phone_numbervulnerability_descriptionmitigationcommentsresourcessource_ident_vulnsecurity_checksrecommendationsrelevance_of_threatlikelihoodimpactimpact_descriptionresidual_risk_levelmilestonessystem_id)

Add one or many poa&m items in a system

Adds POA&M for given `systemId`<br> **Note**<br> If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request.<br> `pocOrganization`, `pocFirstName`, `pocLastName`, `pocEmail`, `pocPhoneNumber`

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
poam_id = 789 # Integer | 
is_inherited = true # BOOLEAN | 
external_uid = 'external_uid_example' # String | 
control_acronyms = 'control_acronyms_example' # String | 
ccis = 'ccis_example' # String | 
system_only = true # BOOLEAN | 
severity = 'severity_example' # String | 
raw_severity = 'raw_severity_example' # String | 
status = 'status_example' # String | 
review_status = 'review_status_example' # String | 
scheduled_completion_date = 789 # Integer | 
completion_date = 789 # Integer | 
extension_date = 789 # Integer | 
scheduled_completion_date_start = 789 # Integer | 
scheduled_completion_date_end = 789 # Integer | 
poc_organization = 'poc_organization_example' # String | 
poc_first_name = 'poc_first_name_example' # String | 
poc_last_name = 'poc_last_name_example' # String | 
poc_email = 'poc_email_example' # String | 
poc_phone_number = 'poc_phone_number_example' # String | 
vulnerability_description = 'vulnerability_description_example' # String | 
mitigation = 'mitigation_example' # String | 
comments = 'comments_example' # String | 
resources = 'resources_example' # String | 
source_ident_vuln = 'source_ident_vuln_example' # String | 
security_checks = 'security_checks_example' # String | 
recommendations = 'recommendations_example' # String | 
relevance_of_threat = 'relevance_of_threat_example' # String | 
likelihood = 'likelihood_example' # String | 
impact = 'impact_example' # String | 
impact_description = 'impact_description_example' # String | 
residual_risk_level = 'residual_risk_level_example' # String | 
milestones = [SwaggerClient::Milestones.new] # Array<Milestones> | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Add one or many poa&m items in a system
  result = api_instance.add_poam_by_system_id(poam_idis_inheritedexternal_uidcontrol_acronymsccissystem_onlyseverityraw_severitystatusreview_statusscheduled_completion_datecompletion_dateextension_datescheduled_completion_date_startscheduled_completion_date_endpoc_organizationpoc_first_namepoc_last_namepoc_emailpoc_phone_numbervulnerability_descriptionmitigationcommentsresourcessource_ident_vulnsecurity_checksrecommendationsrelevance_of_threatlikelihoodimpactimpact_descriptionresidual_risk_levelmilestonessystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->add_poam_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **poam_id** | **Integer**|  | 
 **is_inherited** | **BOOLEAN**|  | 
 **external_uid** | **String**|  | 
 **control_acronyms** | **String**|  | 
 **ccis** | **String**|  | 
 **system_only** | **BOOLEAN**|  | 
 **severity** | **String**|  | 
 **raw_severity** | **String**|  | 
 **status** | **String**|  | 
 **review_status** | **String**|  | 
 **scheduled_completion_date** | **Integer**|  | 
 **completion_date** | **Integer**|  | 
 **extension_date** | **Integer**|  | 
 **scheduled_completion_date_start** | **Integer**|  | 
 **scheduled_completion_date_end** | **Integer**|  | 
 **poc_organization** | **String**|  | 
 **poc_first_name** | **String**|  | 
 **poc_last_name** | **String**|  | 
 **poc_email** | **String**|  | 
 **poc_phone_number** | **String**|  | 
 **vulnerability_description** | **String**|  | 
 **mitigation** | **String**|  | 
 **comments** | **String**|  | 
 **resources** | **String**|  | 
 **source_ident_vuln** | **String**|  | 
 **security_checks** | **String**|  | 
 **recommendations** | **String**|  | 
 **relevance_of_threat** | **String**|  | 
 **likelihood** | **String**|  | 
 **impact** | **String**|  | 
 **impact_description** | **String**|  | 
 **residual_risk_level** | **String**|  | 
 **milestones** | [**Array&lt;Milestones&gt;**](Milestones.md)|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **api_systems_system_id_poams_get**
> PoamResponse api_systems_system_id_poams_get(system_id, opts)

Get one or many poa&m items in a system

Returns system containing POA&M items for matching parameters. 

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  scheduled_completion_date_start: 'scheduled_completion_date_start_example', # String | **Date Started**: Filter query by the scheduled competion start date.
  scheduled_completion_date_end: 'scheduled_completion_date_end_example', # String | **Date Ended**: Filter query by the scheduled competion start date.
  control_acronyms: 'control_acronyms_example', # String | **System Acronym**: Filter query by given system acronym (single or common separated).
  ccis: 'ccis_example', # String | **CCI System**: Filter query by Control Correlation Identifiers (CCIs).
  system_only: true # BOOLEAN | **Systems Only**: Indicates that only system(s) information is retrieved.
}

begin
  #Get one or many poa&m items in a system
  result = api_instance.api_systems_system_id_poams_get(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->api_systems_system_id_poams_get: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **scheduled_completion_date_start** | **String**| **Date Started**: Filter query by the scheduled competion start date. | [optional] 
 **scheduled_completion_date_end** | **String**| **Date Ended**: Filter query by the scheduled competion start date. | [optional] 
 **control_acronyms** | **String**| **System Acronym**: Filter query by given system acronym (single or common separated). | [optional] 
 **ccis** | **String**| **CCI System**: Filter query by Control Correlation Identifiers (CCIs). | [optional] 
 **system_only** | **BOOLEAN**| **Systems Only**: Indicates that only system(s) information is retrieved. | [optional] [default to true]

### Return type

[**PoamResponse**](PoamResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **delete_milestone**
> Model200 delete_milestone(system_id, poam_id, milestone_id)

Remove milestones in a system for one or many poa&m items

Remove the POA&M matching `systemId` path parameter<br> **Notes**<br> To delete a milestone the record must be inactive by having the field isActive set to false (`isActive=false`).

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.
milestone_id = 56 # Integer | **Milestone Id**: The unique milestone record identifier.


begin
  #Remove milestones in a system for one or many poa&m items
  result = api_instance.delete_milestone(system_id, poam_id, milestone_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->delete_milestone: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 
 **milestone_id** | **Integer**| **Milestone Id**: The unique milestone record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **delete_poam**
> Model200 delete_poam(system_id, poam_id)

Remove one or many poa&m items in a system

Remove the POA&M matching `systemId` path parameter and `poamId` query parameter<br>

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Remove one or many poa&m items in a system
  result = api_instance.delete_poam(system_id, poam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->delete_poam: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **get_milestones_by_system_id_and_poam_id**
> MilestoneResponse get_milestones_by_system_id_and_poam_id(system_id, poam_id, opts)

Get milestones in one or many poa&m items in a system

Returns system containing milestones for matching parameters. 

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.
opts = { 
  scheduled_completion_date_start: 'scheduled_completion_date_start_example', # String | **Date Started**: Filter query by the scheduled competion start date.
  scheduled_completion_date_end: 'scheduled_completion_date_end_example' # String | **Date Ended**: Filter query by the scheduled competion start date.
}

begin
  #Get milestones in one or many poa&m items in a system
  result = api_instance.get_milestones_by_system_id_and_poam_id(system_id, poam_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->get_milestones_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 
 **scheduled_completion_date_start** | **String**| **Date Started**: Filter query by the scheduled competion start date. | [optional] 
 **scheduled_completion_date_end** | **String**| **Date Ended**: Filter query by the scheduled competion start date. | [optional] 

### Return type

[**MilestoneResponse**](MilestoneResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **get_milestones_by_system_id_and_poam_id_andf_milestone_id**
> MilestoneResponse get_milestones_by_system_id_and_poam_id_andf_milestone_id(system_id, poam_id, milestone_id)

Get milestone by id in poa&m item in a system

Returns systems containing milestones for matching parameters. 

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.
milestone_id = 56 # Integer | **Milestone Id**: The unique milestone record identifier.


begin
  #Get milestone by id in poa&m item in a system
  result = api_instance.get_milestones_by_system_id_and_poam_id_andf_milestone_id(system_id, poam_id, milestone_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->get_milestones_by_system_id_and_poam_id_andf_milestone_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 
 **milestone_id** | **Integer**| **Milestone Id**: The unique milestone record identifier. | 

### Return type

[**MilestoneResponse**](MilestoneResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **get_poam_by_system_id_and_poam_id**
> PoamResponse get_poam_by_system_id_and_poam_id(system_id, poam_id)

Get poa&m item by id in a system

Returns system test results information for matching parameters.<br>

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Get poa&m item by id in a system
  result = api_instance.get_poam_by_system_id_and_poam_id(system_id, poam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->get_poam_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**PoamResponse**](PoamResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **update_milestone_by_system_id_and_poam_id**
> Model200 update_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)

Update one or many poa&m items in a system

Updates a milestone for given `systemId` and `poamId` path parameters

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
body = SwaggerClient::PutMilestones.new # PutMilestones | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Update one or many poa&m items in a system
  result = api_instance.update_milestone_by_system_id_and_poam_id(bodysystem_idpoam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->update_milestone_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**PutMilestones**](PutMilestones.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **update_milestone_by_system_id_and_poam_id**
> Model200 update_milestone_by_system_id_and_poam_id(poam_id2descriptionscheduled_completion_datesystem_idpoam_id)

Update one or many poa&m items in a system

Updates a milestone for given `systemId` and `poamId` path parameters

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
poam_id2 = 789 # Integer | 
description = 'description_example' # String | 
scheduled_completion_date = 789 # Integer | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.
poam_id = 56 # Integer | **POA&M Id**: The unique POA&M record identifier.


begin
  #Update one or many poa&m items in a system
  result = api_instance.update_milestone_by_system_id_and_poam_id(poam_id2descriptionscheduled_completion_datesystem_idpoam_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->update_milestone_by_system_id_and_poam_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **poam_id2** | **Integer**|  | 
 **description** | **String**|  | 
 **scheduled_completion_date** | **Integer**|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **poam_id** | **Integer**| **POA&amp;M Id**: The unique POA&amp;M record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **update_poam_by_system_id**
> Model200 update_poam_by_system_id(bodysystem_id)

Update one or many poa&m items in a system

Update Adds POA&M for given `systemId`<br> **Note**<br> If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request.<br> `pocOrganization`, `pocFirstName`, `pocLastName`, `pocEmail`, `pocPhoneNumber`

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
body = SwaggerClient::POAM.new # POAM | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Update one or many poa&m items in a system
  result = api_instance.update_poam_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->update_poam_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**POAM**](POAM.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **update_poam_by_system_id**
> Model200 update_poam_by_system_id(poam_idis_inheritedexternal_uidcontrol_acronymsccissystem_onlyseverityraw_severitystatusreview_statusscheduled_completion_datecompletion_dateextension_datescheduled_completion_date_startscheduled_completion_date_endpoc_organizationpoc_first_namepoc_last_namepoc_emailpoc_phone_numbervulnerability_descriptionmitigationcommentsresourcessource_ident_vulnsecurity_checksrecommendationsrelevance_of_threatlikelihoodimpactimpact_descriptionresidual_risk_levelmilestonessystem_id)

Update one or many poa&m items in a system

Update Adds POA&M for given `systemId`<br> **Note**<br> If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request.<br> `pocOrganization`, `pocFirstName`, `pocLastName`, `pocEmail`, `pocPhoneNumber`

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::POAMApi.new
poam_id = 789 # Integer | 
is_inherited = true # BOOLEAN | 
external_uid = 'external_uid_example' # String | 
control_acronyms = 'control_acronyms_example' # String | 
ccis = 'ccis_example' # String | 
system_only = true # BOOLEAN | 
severity = 'severity_example' # String | 
raw_severity = 'raw_severity_example' # String | 
status = 'status_example' # String | 
review_status = 'review_status_example' # String | 
scheduled_completion_date = 789 # Integer | 
completion_date = 789 # Integer | 
extension_date = 789 # Integer | 
scheduled_completion_date_start = 789 # Integer | 
scheduled_completion_date_end = 789 # Integer | 
poc_organization = 'poc_organization_example' # String | 
poc_first_name = 'poc_first_name_example' # String | 
poc_last_name = 'poc_last_name_example' # String | 
poc_email = 'poc_email_example' # String | 
poc_phone_number = 'poc_phone_number_example' # String | 
vulnerability_description = 'vulnerability_description_example' # String | 
mitigation = 'mitigation_example' # String | 
comments = 'comments_example' # String | 
resources = 'resources_example' # String | 
source_ident_vuln = 'source_ident_vuln_example' # String | 
security_checks = 'security_checks_example' # String | 
recommendations = 'recommendations_example' # String | 
relevance_of_threat = 'relevance_of_threat_example' # String | 
likelihood = 'likelihood_example' # String | 
impact = 'impact_example' # String | 
impact_description = 'impact_description_example' # String | 
residual_risk_level = 'residual_risk_level_example' # String | 
milestones = [SwaggerClient::Milestones.new] # Array<Milestones> | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Update one or many poa&m items in a system
  result = api_instance.update_poam_by_system_id(poam_idis_inheritedexternal_uidcontrol_acronymsccissystem_onlyseverityraw_severitystatusreview_statusscheduled_completion_datecompletion_dateextension_datescheduled_completion_date_startscheduled_completion_date_endpoc_organizationpoc_first_namepoc_last_namepoc_emailpoc_phone_numbervulnerability_descriptionmitigationcommentsresourcessource_ident_vulnsecurity_checksrecommendationsrelevance_of_threatlikelihoodimpactimpact_descriptionresidual_risk_levelmilestonessystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling POAMApi->update_poam_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **poam_id** | **Integer**|  | 
 **is_inherited** | **BOOLEAN**|  | 
 **external_uid** | **String**|  | 
 **control_acronyms** | **String**|  | 
 **ccis** | **String**|  | 
 **system_only** | **BOOLEAN**|  | 
 **severity** | **String**|  | 
 **raw_severity** | **String**|  | 
 **status** | **String**|  | 
 **review_status** | **String**|  | 
 **scheduled_completion_date** | **Integer**|  | 
 **completion_date** | **Integer**|  | 
 **extension_date** | **Integer**|  | 
 **scheduled_completion_date_start** | **Integer**|  | 
 **scheduled_completion_date_end** | **Integer**|  | 
 **poc_organization** | **String**|  | 
 **poc_first_name** | **String**|  | 
 **poc_last_name** | **String**|  | 
 **poc_email** | **String**|  | 
 **poc_phone_number** | **String**|  | 
 **vulnerability_description** | **String**|  | 
 **mitigation** | **String**|  | 
 **comments** | **String**|  | 
 **resources** | **String**|  | 
 **source_ident_vuln** | **String**|  | 
 **security_checks** | **String**|  | 
 **recommendations** | **String**|  | 
 **relevance_of_threat** | **String**|  | 
 **likelihood** | **String**|  | 
 **impact** | **String**|  | 
 **impact_description** | **String**|  | 
 **residual_risk_level** | **String**|  | 
 **milestones** | [**Array&lt;Milestones&gt;**](Milestones.md)|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



