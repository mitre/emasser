Add milestones in a system for one or many poa&m items

Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique system identifier
poamId                  Integer    [Required] Unique item identifier
description             String     [Required] Provide a description of the milestone. 2000 Characters 
scheduledCompletionDate Date       [Required] Schedule completion date - Unix date format
isActive                Boolean    [Optional] Set to false only in the case where POA&M PUT would delete
                                              specified milestone. Not available for other requests

Example:

bundle exec exe/emasser put poams add_milestones --systemId [value] --poamId [value] --description [value] --scheduledCompletionDate [value]
