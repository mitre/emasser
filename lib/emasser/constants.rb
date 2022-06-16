# frozen_string_literal: true

module Emasser
  GET_SYSTEM_ID_QUERY_PARAMS = {
    include_package: false,
    include_ditpr_metrics: false,
    include_decommissioned: false,
    debug_return_type: 'SystemResponse' # This is used by swagger client only to format output
  }.freeze

  GET_SYSTEM_RETURN_TYPE = {
    debug_return_type: 'SystemResponse'
  }.freeze

  GET_ARTIFACTS_RETURN_TYPE = {
    debug_return_type: 'String'
  }.freeze

  GET_WORKFLOWINSTANCES_RETURN_TYPE = {
    debug_return_type: 'Object'
  }.freeze

  DEL_MILESTONES_RETURN_TYPE = {
    debug_return_type: 'Object'
  }.freeze
end
