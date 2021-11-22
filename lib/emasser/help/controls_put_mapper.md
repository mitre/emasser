  Business logic, the following fields are required:
  
  If Implementation Status `implementationStatus` field value is `Planned` or `Implemented`
      controlDesignation, estimatedCompletionDate, responsibleEntities, slcmCriticality, 
      slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments

  If Implementation Status `implementationStatus` field value is `Manually Inherited`
      commoncontrolprovider, securityControlDesignation, estimatedCompletionDate, responsibleEntities,
      slcmCriticality, slcmFrequency, slcmMethod, slcmReporting, slcmTracking, slcmComments

  If Implementation Status `implementationStatus` field value is `Not Applicable`
      naJustification, controlDesignation, responsibleEntities

  ------------------------------------------------------------------------------------------------
  If Implementation Status `implementationStatus` field value is `Inherited` only the following 
  fields can be updated:
    commonnControlProvider, controlDesignation

  ------------------------------------------------------------------------------------------------  
  Implementation Plan information cannot be saved if the fields below exceed 2000 character limits:
      naJustification, responsibleEntities, comments, slcmCriticality, slcmFrequency
      slcmMethod, slcmReporting, slcmTracking, slcmComments

Example:

bundle exec exe/emasser put controls update --systemId [value] --acronym [value] --responsibleEntities [value] --controlDesignation [value] --estimatedCompletionDate [value]

Note: The example is only showing the required fields. Refer to instructions listed above for conditional and optional fields requirements.
