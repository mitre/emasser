Updates a milestones in a system for one or many poa&m items

Set the field "isActive" to false only in the case where POA&M PUT would delete specified milestone. Not available  for other requests

Example:

bundle exec exe/emasser put poams update_milestones --systemId [value] --poamId [value] --milestoneId [value] --description [value] --scheduledCompletionDate [value]
