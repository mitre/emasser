# frozen_string_literal: true

module Emasser
  GET_SYSTEM_ID_QUERY_PARAMS = {
    include_package: false,
    include_ditpr_metrics: false,
    include_decommissioned: false,
    return_type: 'SystemResponse1' # This is used by swagger client only to format output
  }.freeze

  GET_SYSTEM_RETURN_TYPE = {
    return_type: 'SystemResponse1'
  }.freeze

  GET_ARTIFACTS_RETURN_TYPE = {
    return_type: 'String'
  }.freeze

  GET_APPROVAL_RETURN_TYPE = {
    return_type: 'ApprovalPacResponse1'
  }.freeze
end
