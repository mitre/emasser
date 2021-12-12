# SwaggerClient::ArtifactsRequestPutBody

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**filename** | **String** | [Required] File name should match exactly one file within the provided zip file. 1000 Characters. | 
**is_template** | **BOOLEAN** | [Required] Indicates it is an artifact template. | 
**type** | **String** | [Required] Artifact type options | 
**category** | **String** | [Required] Artifact category options | 
**description** | **String** | [Optional] Artifact description. 2000 Characters. | [optional] 
**ref_page_number** | **String** | [Optional] Artifact reference page number. 50 Characters. | [optional] 
**ccis** | **String** | [Required] CCI associated with test result. | [optional] 
**controls** | **String** | [Optional] Control acronym associated with the artifact. NIST SP 800-53 Revision 4 defined. | [optional] 
**artifact_expiration_date** | **Integer** | [Optional] Date Artifact expires and requires review. In Unix Date format. | [optional] 
**last_reviewed_date** | **Integer** | [Optional]] Date Artifact was last reviewed.. Unix time format. | [optional] 

