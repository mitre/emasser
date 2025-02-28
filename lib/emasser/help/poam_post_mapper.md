Endpoint request body parameters/fields

Field                          Data Type  Details
------------------------------------------------------------------------------------------------------
systemId                       Integer   [Required] Unique eMASS identifier. Will need to provide correct number.
status                         String    [Required] Values include the following: (Ongoing,Risk Accepted,Completed,Not Applicable).
vulnerabilityDescription       String    [Required] Provide a description of the POA&M Item. 2000 Characters.
sourceIdentifyingVulnerability String    [Required] Include Source Identifying Vulnerability text. 2000 Characters.
pocOrganization                String    [Required] Organization/Office represented. 100 Characters.
resources                      String    [Required] List of resources used. 250 Characters.

milestones               JSON      [Conditional] Please see Notes 1 for more details.
pocFirstName             String    [Conditional] First name of POC. 100 Characters.
pocLastName              String    [Conditional] Last name of POC. 100 Characters.
pocEmail                 String    [Conditional] Email address of POC. 100 Characters.
pocPhoneNumber           String    [Conditional] Phone number of POC (area code) ***-**** format. 100 Characters.
severity                 String    [Conditional] Values include the following: (Very Low, Low, Moderate, High, Very High)
scheduledCompletionDate  Date      [Conditional] Required for ongoing and completed POA&M items. Unix time format.
completionDate           Date      [Conditional] Field is required for completed POA&M items. Unix time format.
comments                 String    [Conditional] Field is required for completed and risk accepted POA&M items. 2000 Characters.

Required for VA. Optional for Army and USCG.
identifiedInCFOAuditOrOtherReview    Boolean [Required]    If not specified, this field will be set to false because it does not accept a null value.
personnelResourcesFundedBaseHours    Number  [Conditional] Displays numbers to the second decimal point
personnelResourcesCostCode           String  [Conditional] Required if Personnel Resources: Funded Base Hours or Personnel Resources: Unfunded Base Hours is populated.
personnelResourcesUnfundedBaseHours  Number  [Conditional] Displays numbers to the second decimal point (e.g., 100.00).
personnelResourcesNonfundingObstacle String  [Conditional] Required if Personnel Resources: Unfunded Base Hours is populated
personnelResourcesNonfundingObstacleOtherReason String [Conditional] Required if the value “Other” is populated for the field Personnel Resources: Non-Funding Obstacle.
nonPersonnelResourcesFundedAmount    Number  [Conditional] At least one of the following is required and must be completed for each POA&M Item:
                                                           Personnel Resources: Funded Base Hours, Personnel Resources: Unfunded Base Hours
                                                           Non-Personnel Resources: Funded Amount, Non-Personnel Resources: Unfunded Amount
nonPersonnelResourcesCostCode        String  [Conditional] Required if Non-Personnel Resources: Funded Amount or Non-Personnel Resources: Unfunded Amount is populated.
nonPersonnelResourcesUnfundedAmount  Number  [Conditional] At least one of the following is required and must be completed for each POA&M Item:
                                                           Personnel Resources: Funded Base Hours, Personnel Resources: Unfunded Base Hours
                                                           Non-Personnel Resources: Funded Amount, Non-Personnel Resources: Unfunded Amount
nonPersonnelResourcesNonfundingObstacle String [Conditional] Required if Non-Personnel Resources: Unfunded Amount is populated.
nonPersonnelResourcesNonfundingObstacleOtherReason String [Conditional] Required if the value “Other” is populated for the field
                                                                        Non-Personnel Resources: Non-Funding Obstacle.


externalUid              String    [Optional] Unique identifier external to the eMASS application for use with associating POA&M Items. 100 Characters.
controlAcronym           String    [Optional] Control acronym associated with the POA&M Item. NIST SP 800-53 Revision 4 defined.
assessmentProcedure      String    [Optional] The Security Control Assessment Procedures being associated with the POA&M Item.
securityChecks           String    [Optional] Security Checks that are associated with the POA&M.
rawSeverity              String    [Optional] Values include the following: (I, II, III)
relevanceOfThreat        String    [Optional] Values include the following: (Very Low, Low, Moderate, High, Very High)
likelihood               String    [Optional] Values include the following: (Very Low, Low, Moderate, High, Very High)
impact                   String    [Optional] Values include the following: (Very Low, Low, Moderate, High, Very High)
impactDescription        String    [Optional] Include description of Security Control’s impact.
residualRiskLevel        String    [Optional] Values include the following: (Very Low, Low, Moderate, High, Very High)
recommendations          String    [Optional] Include recommendations. Character Limit 2,000.
mitigation               String    [Optional] Include mitigation explanation. 2000 Characters.

Navy Only
resultingResidualRiskLevelAfterProposedMitigations String [Optional] Indicate the risk level expected after any proposed mitigations
                                                                     are implemented. Proposed mitigations should be appropriately
                                                                     documented as POA&M milestones.
predisposingConditions String [Optional] A predisposing condition is a condition existing within an organization,
                                         a mission or business process, enterprise architecture, information system/PIT,
                                         or environment of operation, which affects (i.e., increases or decreases) the likelihood
                                         that threat events, once initiated, result in adverse impacts.
threatDescription      String [Optional] Describe the identified threat(s) and relevance to the information system.
devicesAffected        String [Optional] List any affected devices by hostname. If all devices in the information system are affected, state 'system' or 'all'.

**If a milestone Id is provided the POA&M with the provided milestone Id is updated and the new POA&M milestones is set to null.**

The following fields are required based on the contents of the "status" field
  |status          |Required Fields
  |----------------|--------------------------------------------------------
  |Risk Accepted   |comments 
  |Ongoing         |scheduledCompletionDate, milestones (at least 1)
  |Completed       |scheduledCompletionDate, comments, completionDate, milestones (at least 1)
  |Not Applicable  |POAM can not be created

If a POC email is supplied, the application will attempt to locate a user already registered within the application and pre-populate any information not explicitly supplied in the request. If no such user is found, these fields are required within the request.
  - pocFirstName, pocLastName, pocPhoneNumber

Business logic, the following rules apply when adding POA&Ms

- POA&M Items cannot be saved if associated Security Control or AP is inherited.
- POA&M Items cannot be created manually if a Security Control or AP is Not Applicable.
- Completed POA&M Item cannot be saved if Completion Date is in the future.
- Completed POA&M Item cannot be saved if Completion Date (completionDate) is in the future.
- Risk Accepted POA&M Item cannot be saved with a Scheduled Completion Date or Milestones
- POA&M Items with a review status of "Not Approved" cannot be saved if Milestone Scheduled Completion Date exceeds POA&M Item  Scheduled Completion Date.
- POA&M Items with a review status of "Approved" can be saved if Milestone Scheduled Completion Date exceeds POA&M Item Scheduled Completion Date.
- POA&M Items that have a status of "Completed" and a status of "Ongoing" cannot be saved without Milestones.
- POA&M Items that have a status of "Risk Accepted" cannot have milestones.
- POA&M Items with a review status of "Approved" that have a status of "Completed" and "Ongoing" cannot update Scheduled Completion Date.
- POA&M Items that have a review status of "Approved" are required to have a Severity Value assigned.
- POA&M Items cannot be updated if they are included in an active package.
- Archived POA&M Items cannot be updated.
- POA&M Items with a status of "Not Applicable" will be updated through test result creation.
- If the Security Control or Assessment Procedure does not exist in the system we may have to just import POA&M Item at the System Level.


The following parameters/fields have the following character limitations:
- POA&M Item cannot be saved if the Point of Contact fields exceed 100 characters:
  - Office / Organization (pocOrganization)
  - First Name            (pocFirstName)
  - Last Name             (pocLastName)
  - Email                 (email)
  - Phone Number          (pocPhoneNumber)
- POA&M Items cannot be saved if Mitigation field (mitigation) exceeds 2000 characters.
- POA&M Items cannot be saved if Source Identifying Vulnerability field exceeds 2000 characters.
- POA&M Items cannot be saved if Comments (comments) field exceeds 2000 characters 
- POA&M Items cannot be saved if Resource (resource) field exceeds 250 characters.
- POA&M Items cannot be saved if Milestone Description exceeds 2000 characters.

Example:

bundle exec exe/emasser post poams add [-s, --systemId] <value> --status <value> --vulnerabilityDescription <value>
 --sourceIdentifyingVulnerability <value> --pocOrganization <value> --resources <value>

Notes:
1 - The format for milestones is:
    --milestone description:[value] scheduledCompletionDate:[value]
2 - Based on the value for the status (--status) parameter there are other required fields
3 - Refer to instructions listed above for conditional and optional fields requirements.
