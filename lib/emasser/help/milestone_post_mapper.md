Add milestones in a system for one or many poa&m items

Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique system identifier
poamId                  Integer    [Required] Unique item identifier
description             String     [Required] Provide a description of the milestone. 2000 Characters 
scheduledCompletionDate Date       [Required] Schedule completion date - Unix date format

Note: Business rules associated with Milestones endpoints fields are provided within the POA&Ms Endpoint

Example:

bundle exec exe/emasser post milestones add [-s, --systemId] <value> [-p, --poamId] <value> [-d, --description] <value> [c, --scheduledCompletionDate] <value>
