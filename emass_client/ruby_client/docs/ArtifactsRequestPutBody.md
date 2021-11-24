# SwaggerClient::ArtifactsRequestPutBody

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**filename** | **String** | [Required] File name should match exactly one file within the provided zip file. 1000 Characters. | [optional] 
**description** | **String** | [Optional] Artifact description. 2000 Characters. | [optional] 
**is_template** | **BOOLEAN** | [Read-only] Indicates it is an artifact template. | [optional] 
**type** | **String** | [Required] Values include the following options: (Procedure,Diagram,Policy,Labor,Document,Image,Other,Scan Result) | [optional] 
**category** | **String** | [Required] Values include the following options: (Implementation Guidance,Evidence). May also accept custom artifact category values set by system administrators. | [optional] 
**ref_page_number** | **String** | [Optional] Artifact reference page number. 50 Characters. | [optional] 
**controls** | **String** | [Optional] Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined. | [optional] 
**ccis** | **String** | [Required] CCI associated with test result. | [optional] 
**artifact_expiration_date** | **Integer** | [Optional] Date Artifact expires and requires review. In Unix Date format. | [optional] 
**last_reviewed_date** | **Integer** | [Conditional] Date Artifact was last reviewed.. Unix time format. | [optional] 

