Updates a milestones in a system for one or many poa&m items

Endpoint request parameters/fields

Field                   Data Type  Details
-------------------------------------------------------------------------------------------------
systemId                Integer    [Required] Unique system identifier
milestoneId             Integer    [Required] Unique milestone identifier
poamId                  Integer    [Required] unique item identifier
description             String     [Required] Provide a description of the milestone. 2000 Characters 
scheduledCompletionDate Date       [Required] In Unix date format ü
isActive                Boolean    [Optional] Set to false only in the case where POA&M PUT would delete
                                              specified milestone. Not available for other requests


Set the field "isActive" to false only in the case where POA&M PUT would delete specified milestone. Not available  for other requests

If a field is misrepresented (wrong value)the following response may be provided by the server:
Response body: {"meta":{"code":500,"errorMessage":"Sorry! Something went wrong on our end. Please contact emass_support@bah.com for assistance."}}

Example:

bundle exec exe/emasser put milestones update --systemId [value] --poamId [value] --milestoneId [value] --description [value] --scheduledCompletionDate [value]
