# SwaggerClient::PoamRequiredPost

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**status** | **String** | [Required] Values include the following: (Ongoing,Risk Accepted,Completed,Not Applicable | [optional] 
**vulnerability_description** | **String** | [Required] Provide a description of the POA&amp;M Item. 2000 Characters. | [optional] 
**source_ident_vuln** | **String** | [Required] Include Source Identifying Vulnerability text. 2000 Characters. | [optional] 
**poc_organization** | **String** | [Required] Organization/Office represented. 100 Characters. | [optional] 
**resources** | **String** | [Required] List of resources used. 250 Characters. | [optional] 
**poc_first_name** | **String** | [Required] First name of POC. 100 Characters. | [optional] 
**poc_last_name** | **String** | [Required] Last name of POC. 100 Characters. | [optional] 
**poc_email** | **String** | [Required] Email address of POC. 100 Characters. | [optional] 
**poc_phone_number** | **String** | [Required] Phone number of POC (area code) ***-**** format. 100 Characters. | [optional] 
**external_uid** | **String** | [Optional] Unique identifier external to the eMASS application for use with associating POA&amp;Ms. 100 Characters. | [optional] 
**control_acronym** | **String** | [Optional] Control acronym associated with the POA&amp;M Item. NIST SP 800-53 Revision 4 defined. | [optional] 
**cci** | **String** | [Optional] CCI associated with POA&amp;M. | [optional] 
**security_checks** | **String** | [Optional] Security Checks that are associated with the POA&amp;M. | [optional] 
**raw_severity** | **String** | [Optional] Values include the following options (I,II,III) | [optional] 
**relevance_of_threat** | **String** | [Optional] Values include the following options (Very Low, Low, Moderate,High,Very High) | [optional] 
**likelihood** | **String** | [Optional] Values include the following options (Very Low, Low, Moderate,High,Very High) | [optional] 
**impact** | **String** | [Optional] Values include the following options (Very Low, Low, Moderate,High,Very High) | [optional] 
**impact_description** | **String** | [Optional] Include description of Security Control’s impact. | [optional] 
**residual_risk_level** | **String** | [Optional] Values include the following options (Very Low, Low, Moderate,High,Very High) | [optional] 
**recommendations** | **String** | [Optional] Include recommendations. Character Limit &#x3D; 2,000. | [optional] 
**mitigation** | **String** | [Optional] Include mitigation explanation. 2000 Characters. | [optional] 
**severity** | **String** | [Conditional] Required for approved items. Values include the following options: (Very Low, Low, Moderate,High,Very High) | [optional] 
**scheduled_completion_date** | **Integer** | [Conditional] Required for ongoing and completed POA&amp;M items. Unix time format. | [optional] 
**comments** | **String** | [Conditional] Field is required for completed and risk accepted POA&amp;M items. 2000 Characters | [optional] 
**completion_date** | **Integer** | [Conditional] Field is required for completed POA&amp;M items. Unix time format. | [optional] 
**milestones** | [**Array&lt;MilestonesRequiredPost&gt;**](MilestonesRequiredPost.md) |  | [optional] 

