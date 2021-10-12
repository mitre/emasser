# SwaggerClient::ControlsApi

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**get_system_by_system_id**](ControlsApi.md#get_system_by_system_id) | **GET** /api/systems/{systemId}/controls | Get control information in a system for one or many controls
[**update_control_by_system_id**](ControlsApi.md#update_control_by_system_id) | **PUT** /api/systems/{systemId}/controls | Update control information in a system for one or many controls
[**update_control_by_system_id**](ControlsApi.md#update_control_by_system_id) | **PUT** /api/systems/{systemId}/controls | Update control information in a system for one or many controls

# **get_system_by_system_id**
> ControlResponse get_system_by_system_id(system_id, opts)

Get control information in a system for one or many controls

Returns system control information for matching `systemId` path parameter

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::ControlsApi.new
system_id = 56 # Integer | **System Id**: The unique system record identifier.
opts = { 
  acronyms: 'PM-6' # String | **Acronym**: The system acronym(s) been queried (single value or common delimited values).
}

begin
  #Get control information in a system for one or many controls
  result = api_instance.get_system_by_system_id(system_id, opts)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ControlsApi->get_system_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 
 **acronyms** | **String**| **Acronym**: The system acronym(s) been queried (single value or common delimited values). | [optional] [default to PM-6]

### Return type

[**ControlResponse**](ControlResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/plain



# **update_control_by_system_id**
> Model200 update_control_by_system_id(bodysystem_id)

Update control information in a system for one or many controls

Update an existing control by System Id

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::ControlsApi.new
body = SwaggerClient::Controls.new # Controls | Update an existing control by Id
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Update control information in a system for one or many controls
  result = api_instance.update_control_by_system_id(bodysystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ControlsApi->update_control_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**Controls**](Controls.md)| Update an existing control by Id | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



# **update_control_by_system_id**
> Model200 update_control_by_system_id(system_id2nameacronymccisis_inheritedmodified_by_overlaysincluded_statuscompliance_statusresponsible_entitiesimplementation_statuscommon_control_providerna_justificationcontrol_designationestimated_completion_datecommentsslcm_criticalityslcm_frequencyslcm_methodslcm_reportingslcm_trackingslcm_commentsseverityvulnerabilty_summaryrecommendationsrelevance_of_threatlikelihoodimpactimpact_descriptionresidual_risk_levelsystem_id)

Update control information in a system for one or many controls

Update an existing control by System Id

### Example
```ruby
# load the gem
require 'swagger_client'

api_instance = SwaggerClient::ControlsApi.new
system_id2 = 789 # Integer | 
name = 'name_example' # String | 
acronym = 'acronym_example' # String | 
ccis = 'ccis_example' # String | 
is_inherited = true # BOOLEAN | 
modified_by_overlays = 'modified_by_overlays_example' # String | 
included_status = 'included_status_example' # String | 
compliance_status = 'compliance_status_example' # String | 
responsible_entities = 'responsible_entities_example' # String | 
implementation_status = 'implementation_status_example' # String | 
common_control_provider = 'common_control_provider_example' # String | 
na_justification = 'na_justification_example' # String | 
control_designation = 'control_designation_example' # String | 
estimated_completion_date = 56 # Integer | 
comments = 'comments_example' # String | 
slcm_criticality = 'slcm_criticality_example' # String | 
slcm_frequency = 'slcm_frequency_example' # String | 
slcm_method = 'slcm_method_example' # String | 
slcm_reporting = 'slcm_reporting_example' # String | 
slcm_tracking = 'slcm_tracking_example' # String | 
slcm_comments = 'slcm_comments_example' # String | 
severity = 'severity_example' # String | 
vulnerabilty_summary = 'vulnerabilty_summary_example' # String | 
recommendations = 'recommendations_example' # String | 
relevance_of_threat = 'relevance_of_threat_example' # String | 
likelihood = 'likelihood_example' # String | 
impact = 'impact_example' # String | 
impact_description = 'impact_description_example' # String | 
residual_risk_level = 'residual_risk_level_example' # String | 
system_id = 56 # Integer | **System Id**: The unique system record identifier.


begin
  #Update control information in a system for one or many controls
  result = api_instance.update_control_by_system_id(system_id2nameacronymccisis_inheritedmodified_by_overlaysincluded_statuscompliance_statusresponsible_entitiesimplementation_statuscommon_control_providerna_justificationcontrol_designationestimated_completion_datecommentsslcm_criticalityslcm_frequencyslcm_methodslcm_reportingslcm_trackingslcm_commentsseverityvulnerabilty_summaryrecommendationsrelevance_of_threatlikelihoodimpactimpact_descriptionresidual_risk_levelsystem_id)
  p result
rescue SwaggerClient::ApiError => e
  puts "Exception when calling ControlsApi->update_control_by_system_id: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **system_id2** | **Integer**|  | 
 **name** | **String**|  | 
 **acronym** | **String**|  | 
 **ccis** | **String**|  | 
 **is_inherited** | **BOOLEAN**|  | 
 **modified_by_overlays** | **String**|  | 
 **included_status** | **String**|  | 
 **compliance_status** | **String**|  | 
 **responsible_entities** | **String**|  | 
 **implementation_status** | **String**|  | 
 **common_control_provider** | **String**|  | 
 **na_justification** | **String**|  | 
 **control_designation** | **String**|  | 
 **estimated_completion_date** | **Integer**|  | 
 **comments** | **String**|  | 
 **slcm_criticality** | **String**|  | 
 **slcm_frequency** | **String**|  | 
 **slcm_method** | **String**|  | 
 **slcm_reporting** | **String**|  | 
 **slcm_tracking** | **String**|  | 
 **slcm_comments** | **String**|  | 
 **severity** | **String**|  | 
 **vulnerabilty_summary** | **String**|  | 
 **recommendations** | **String**|  | 
 **relevance_of_threat** | **String**|  | 
 **likelihood** | **String**|  | 
 **impact** | **String**|  | 
 **impact_description** | **String**|  | 
 **residual_risk_level** | **String**|  | 
 **system_id** | **Integer**| **System Id**: The unique system record identifier. | 

### Return type

[**Model200**](Model200.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json, application/x-www-form-urlencoded
 - **Accept**: application/json, text/plain



