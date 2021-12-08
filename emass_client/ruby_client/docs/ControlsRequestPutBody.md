# SwaggerClient::ControlsRequestPutBody

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**acronym** | **String** | [Required] Acronym of the system record. | 
**responsible_entities** | **String** | [Required] Include written description of Responsible Entities that are responsible for the Security Control. Character Limit &#x3D; 2,000. | 
**implementation_status** | **String** | [Optional] Implementation Status of the Security Control for the information system. | [optional] 
**common_control_provider** | **String** | [Conditional] Indicate the type of Common Control Provider for an “Inherited” Security Control. | [optional] 
**na_justification** | **String** | [Conditional] Provide justification for Security Controls deemed Not Applicable to the system. | [optional] 
**control_designation** | **String** | [Required] Control designations | 
**test_method** | **String** | [Optional] Identifies the assessment method / combination that will determine if the security requirements are implemented correctly. | [optional] 
**estimated_completion_date** | **Integer** | [Required] Field is required for Implementation Plan. | 
**implementation_narrative** | **String** | [Required] Includes security control comments. Character Limit &#x3D; 2,000. | 
**slcm_criticality** | **String** | [Conditional] Criticality of Security Control regarding SLCM. Character Limit &#x3D; 2,000. | [optional] 
**slcm_frequency** | **String** | [Conditional] SLCM frequency | [optional] 
**slcm_method** | **String** | [Conditional] SLCM method utilized | [optional] 
**slcm_reporting** | **String** | [Conditional] Method for reporting Security Control for SLCM. Character Limit &#x3D; 2,000. | [optional] 
**slcm_tracking** | **String** | [Conditional] How Non-Compliant Security Controls will be tracked for SLCM. Character Limit &#x3D; 2,000. | [optional] 
**slcm_comments** | **String** | [Conditional] Additional comments for Security Control regarding SLCM. Character Limit &#x3D; 4,000. | [optional] 
**severity** | **String** | [Optional] Values include the following options (Very Low, Low, Moderate,High,Very High) | [optional] 
**vulnerabilty_summary** | **String** | [Optional] Include vulnerability summary. Character Limit &#x3D; 2,000. | [optional] 
**recommendations** | **String** | [Optional] Include recommendations. Character Limit &#x3D; 2,000. | [optional] 
**relevance_of_threat** | **String** | [Optional] Values include the following options (Very Low, Low, Moderate,High,Very High) | [optional] 
**likelihood** | **String** | [Optional] Values include the following options (Very Low, Low, Moderate,High,Very High) | [optional] 
**impact** | **String** | [Optional] Values include the following options (Very Low, Low, Moderate,High,Very High) | [optional] 
**impact_description** | **String** | [Optional] Include description of Security Control’s impact. | [optional] 
**residual_risk_level** | **String** | [Optional] Values include the following options (Very Low, Low, Moderate,High,Very High) | [optional] 

