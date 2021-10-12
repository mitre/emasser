# SwaggerClient::Artifacts

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**system_id** | **Integer** | [Required] Unique eMASS system identifier. | [optional] 
**filename** | **String** | [Required] File name should match exactly one file within the provided zip file. 1000 Characters. | [optional] 
**is_inherited** | **BOOLEAN** | [Read-only] Indicates whether an artifact is inherited. | [optional] 
**description** | **String** | [Optional] Artifact description. 2000 Characters. | [optional] 
**is_artifact_template** | **BOOLEAN** | [Read-only] Indicates whether an artifact template. | [optional] 
**type** | **String** | [Required] Values include the following options: (Procedure,Diagram,Policy,Labor,Document,Image,Other,Scan Result) | [optional] 
**category** | **String** | [Required] Values include the following options: (Implementation Guidance,Evidence). May also accept custom artifact category values set by system administrators. | [optional] 
**ref_page_number** | **String** | [Optional] Artifact reference page number. 50 Characters. | [optional] 
**controls** | **String** | [Optional] Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined. | [optional] 
**ccis** | **String** | [Required] CCI associated with test result. | [optional] 
**mime_content_type** | **String** | [Read-Only] Standard MIME content type derived from file extension. | [optional] 
**file_size** | **String** | [Read-Only] File size of attached artifact. | [optional] 
**artifact_expiration_date** | **Integer** | [Optional] Date Artifact expires and requires review. In Unix Date format. | [optional] 
**last_review_date** | **Integer** | [Conditional] Date Artifact was last reviewed.. Unix time format. | [optional] 

