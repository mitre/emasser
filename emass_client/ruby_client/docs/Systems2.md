# SwaggerClient::Systems2

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**system_id** | **Integer** | [Read-only] Unique system record identifier. | [optional] 
**policy** | **String** | [Read-only] RMF/DIACAP Policy identifier for the system record. | [optional] 
**registration_type** | **String** | Registration types parameters (assessAndAuthorize, assessOnly, guest, regular, functional, cloudServiceProvider.) | [optional] 
**name** | **String** | [Read-only] Name of the system record. | [optional] 
**acronym** | **String** | [Read-only] Acronym of the system record. | [optional] 
**system_owner** | **String** | [Read-only] Owning organization of the system record. | [optional] 
**organization_name** | **String** | [Read-only] Name of the top-level component that owns the system (e.g. Navy, Air Force, Army, etc..). | [optional] 
**version_release_no** | **String** | [Read-only] Version/Release Number of system record. | [optional] 
**system_type** | **String** | [Read-only] Type of the system record. RMF values include the following options (IS Major Application, IS Enclave, Platform IT System). DIACAP values include the following options (Platform IT, Interconnection, AIS Application) | [optional] 
**authorization_status** | **String** | [Read-only] Authorization Status of the system record.&lt;/br&gt;   RMF Values   &lt;ul&gt;     &lt;li&gt;Authority to Operate (ATO)&lt;/li&gt;     &lt;li&gt;Authority to Operate with Conditions (ATO) w/Conditions)&lt;/li&gt;     &lt;li&gt;Denied Authority to Operate (DATO)&lt;/li&gt;     &lt;li&gt;Not Yet Authorized&lt;/li&gt;     &lt;li&gt;Decommissioned&lt;/li&gt;   &lt;/ul&gt;   DIACAP Values   &lt;ul&gt;     &lt;li&gt;Authority to Operate (ATO)&lt;/li&gt;     &lt;li&gt;Interim Authority to Operate (IATO)&lt;/li&gt;     &lt;li&gt;Interim Authority to Test (IATT)&lt;/li&gt;     &lt;li&gt;Denied Authority to Operate (DATO)&lt;/li&gt;     &lt;li&gt;Unaccredited&lt;/li&gt;     &lt;li&gt;Decommissioned&lt;/li&gt;   &lt;/ul&gt;    | [optional] 
**authorization_date** | **Integer** | [Read-only] Authorization Date of the system record. | [optional] 
**authorization_termination_date** | **Integer** | [Read-only] Authorization Termination Date of the system record. | [optional] 
**confidentiality** | **String** | [Read-only] Confidentiality of the system record. RMF values include the following options (High, Moderate, Low) | [optional] 
**integrity** | **String** | [Read-only] Integrity of the system record. RMF values include the following options (High, Moderate, Low) | [optional] 
**availability** | **String** | [Read-only] Availability of the system record. RMF values include the following options (High, Moderate, Low) | [optional] 
**ditpr_id** | **String** | [Read-only] DITPR ID of the system record. | [optional] 
**ditpr_don_id** | **String** | [Read-only] DITPR-DON identifier of the system record (Navy only). | [optional] 
**mac** | **String** | [Read-only] MAC level of the system record. DIACAP values include the following options (I, II, III) | [optional] 
**dod_confidentiality** | **String** | [Read-only] DoD Confidentiality of the system record. DIACAP values include the following options (Public, Sensitive, Classified) | [optional] 
**contingency_plan_tested** | **BOOLEAN** | [Read-only] Has the system record’s Contingency Plan been tested? | [optional] 
**contingency_plan_test_date** | **Integer** | [Read-only] Date the system record’s Contingency Plan was tested. | [optional] 
**security_review_date** | **Integer** | [Read-only] Date the system record’s Annual Security Review was conducted. | [optional] 
**has_open_poam_item** | **BOOLEAN** | [Read-only] Does the system record have an Ongoing or Risk Accepted POA&amp;M Item? | [optional] 
**has_open_poam_item90to120_past_scheduled_completion_date** | **BOOLEAN** | [Read-only] Does the system record have an Ongoing or Risk Accepted POA&amp;M Item 90 to 120 days past it’s Scheduled Completion Date? | [optional] 
**has_open_poam_item120_plus_past_scheudled_completion_date** | **BOOLEAN** | [Read-only] Does the system record have an Ongoing or Risk Accepted POA&amp;M Item 120 days past it’s Scheduled Completion Date? | [optional] 

