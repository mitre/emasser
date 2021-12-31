Add milestones in a system for one or many poa&m items

Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique system identifier
poamId                  Integer    [Required] Unique item identifier
description             String     [Required] Provide a description of the milestone. 2000 Characters 
scheduledCompletionDate Date       [Required] Schedule completion date - Unix date format

Example:
If running from source code:
  bundle exec [ruby] exe/emasser put milestones add --systemId [value] --poamId [value] --description [value] --scheduledCompletionDate [value]
If running from gem:
  emasser put milestones add --systemId [value] --poamId [value] --description [value] --scheduledCompletionDate [value]
