Updates a milestones in a system for one or many poa&m items

Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique system identifier
milestoneId             Integer    [Required] Unique milestone identifier
poamId                  Integer    [Required] unique item identifier
description             String     [Required] Provide a description of the milestone. 2000 Characters 
scheduledCompletionDate Date       [Required] In Unix date format ü


Example:

bundle exec exe/emasser post milestones update [-s, --systemId] <value> [-p, --poamId] <value> [-m, --milestoneId] <value> [-d, --description] <value> [c, --scheduledCompletionDate] <value>
