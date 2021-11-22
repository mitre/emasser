To delete a milestone through the POA&M PUT you must include it as inactive by setting isActive=false.

If a milestone Id is not provided a new milestone is created. 

The following fields are required based on the contents of the status field
  |status          |Required Fields
  |----------------|--------------------------------------------------------
  |Risk Accepted   |comments, resources
  |Ongoing         |scheduledCompletionDate, resources, milestones (at least 1)
  |Completed       |scheduledCompletionDate, comments, resources,
  |                |completionDate, milestones (at least 1)
  |Not Applicable  |POAM can not be created

If a POC email is supplied, the application will attempt to locate a user
already registered within the application and pre-populate any information
not explicitly supplied in the request. If no such user is found, these
fields are required within the request.
  - pocOrganization, pocFirstName, pocLastName, pocEmail, pocPhoneNumber

Business logic, the following rules apply when adding POA&Ms

- POA&M Item cannot be saved if associated Security Control or AP is inherited.
- POA&M Item cannot be created manually if a Security Control or AP is Not Applicable.
- Completed POA&M Item cannot be saved if Completion Date is in the future.
- Completed POA&M Item cannot be saved if Completion Date (completionDate) is in the future.
- Risk Accepted POA&M Item cannot be saved with a Scheduled Completion Date or Milestones
- POA&M Item with a review status of “Not Approved” cannot be saved if Milestone Scheduled Completion Date exceeds POA&M Item  Scheduled Completion Date.
- POA&M Item with a review status of “Approved” can be saved if Milestone Scheduled Completion Date exceeds POA&M Item Scheduled Completion Date.
- POA&M Items that have a status of “Completed” and a status of “Ongoing” cannot be saved without Milestones.
- POA&M Items that have a status of “Risk Accepted” cannot have milestones.
- POA&M Items with a review status of “Approved” that have a status of “Completed” and “Ongoing” cannot update Scheduled Completion Date.
- POA&M Items that have a review status of “Approved” are required to have a Severity Value assigned.
- POA&M Items cannot be updated if they are included in an active package.
- Archived POA&M Items cannot be updated.
- POA&M Items with a status of “Not Applicable” will be updated through test result creation.
- If the Security Control or Assessment Procedure does not exist in the system we may have to just import POA&M Item at the System Level.


The following parameters/fields have the following character limitations:
- POA&M Item cannot be saved if the Point of Contact fields exceed 100 characters:
  - Office / Organization (pocOrganization)
  - First Name            (pocFirstName)
  - Last Name             (pocLastName)
  - Email                 (email)
  - Phone Number          (pocPhoneNumber)
- POA&M Item cannot be saved if Mitigation field (mitigation) exceeds 2000 characters.
- POA&M Item cannot be saved if Source Identifying Vulnerability field exceeds 2000 characters.
- POA&M Item cannot be saved if Comments (comments) field exceeds 2000 characters 
- POA&M Item cannot be saved if Resource (resource) field exceeds 250 characters.
- POA&M Items cannot be saved if Milestone Description exceeds 2000 characters.

Example:

bundle exec exe/emasser put poams update --systemId [value] --poamId [value] --status [value] --vulnerabilityDescription [value] --sourceIdentVuln [value] --reviewStatus [value]

Notes:
1 - The format for milestones is:
    --milestone milestoneId:[value] description:[value] scheduledCompletionDate:[value]

2 - The example is only showing the required fields. Refer to instructions listed above for conditional and optional fields requirements.
