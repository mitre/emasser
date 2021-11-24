Updates a milestones in a system for one or many poa&m items

Set the field "isActive" to false only in the case where POA&M PUT would delete specified milestone. Not available  for other requests

If a field is misrepresented (wrong value)the following response may be provided by the server:
Response body: {"meta":{"code":500,"errorMessage":"Sorry! Something went wrong on our end. Please contact emass_support@bah.com for assistance."}}

Example:

bundle exec exe/emasser put poams update_milestones --systemId [value] --poamId [value] --milestoneId [value] --description [value] --scheduledCompletionDate [value]
