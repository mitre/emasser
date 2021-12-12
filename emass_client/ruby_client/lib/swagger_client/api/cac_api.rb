=begin
#Enterprise Mission Assurance Support Service (eMASS)

#The Enterprise Mission Assurance Support Service (eMASS) Representational State Transfer (REST) Application Programming Interface (API) enables users to perform assessments and complete actions associated with system records. This command-line interface (CLI) tool implements all of the eMASS endpoints defined in the eMASS  REST API v3.2, dated October 21, 2021.</br><br>  <strong>Register CLI</strong></br> New users will need to register an API key with the eMASS development team prior to accessing the site for the first time. The eMASS REST API requires a client certificate (SSL/TLS, DoD PKI only) where {url}/api/register (POST) is used to register the client certificate.</br></br>  Every call to the eMASS REST API will require the use of the agreed upon public key certificate and API key. The API key must be provided in the request header for all endpoint calls (api-key). If the service receives an untrusted certificate or API key, a 401 error response code will be returned along with an error message.</br></br>  <strong>Available Request Headers:</strong></br> <table>   <tr>     <th align=left>key</th>     <th align=left>Example Value</th>     <th align=left>Description</th>   </tr>   <tr>     <td>`api-key`</td>     <td>api-key-provided-by-emass</td>     <td>This API key must be provided in the request header for all endpoint calls</td>   </tr>   <tr>     <td>`user-uid`</td>     <td>USER.UID.KEY</td>     <td>This User unique identifier key must be provided in the request header for all PUT, POST, and DELETE endpoint calls</td>   </tr>   <tr>     <td></td><td></td>     <td>       Note: For DoD users this is the DoD ID Number (EIDIPI) on their DoD CAC     </td>   </tr> </table>  </br><strong>Approve API Client for Actionable Requests</strong></br> Users are required to log-in to eMASS and grant permissions for a client to update data within eMASS on their behalf. This is only required for actionable requests (PUT, POST, DELETE). The Registration Endpoint and all GET requests can be accessed without completing this process with the correct permissions. Please note that leaving a field parameter blank (for PUT/POST requests) has the potential to clear information in the active eMASS records.  To establish an account with eMASS and/or acquire an api-key/user-uid, contact one of the listed POC: 

OpenAPI spec version: v3.2
Contact: disa.meade.id.mbx.emass-tier-iii-support@mail.mil
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 3.0.26
=end

module SwaggerClient
  class CACApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Submit control to second role of CAC
    # Adds a Control Approval Chain (CAC) for given `systemId` path parameter<br><br> POST requests will only yield successful results if the control is currently sitting at the first role of the CAC. If the control is not currently sitting at the first role, then an error will be returned.
    # @param body Update an existing Artifact by Id
    # @param system_id **System Id**: The unique system record identifier.
    # @param [Hash] opts the optional parameters
    # @return [CacResponsePost]
    def add_system_cac(body, system_id, opts = {})
      data, _status_code, _headers = add_system_cac_with_http_info(body, system_id, opts)
      data
    end

    # Submit control to second role of CAC
    # Adds a Control Approval Chain (CAC) for given &#x60;systemId&#x60; path parameter&lt;br&gt;&lt;br&gt; POST requests will only yield successful results if the control is currently sitting at the first role of the CAC. If the control is not currently sitting at the first role, then an error will be returned.
    # @param body Update an existing Artifact by Id
    # @param system_id **System Id**: The unique system record identifier.
    # @param [Hash] opts the optional parameters
    # @return [Array<(CacResponsePost, Integer, Hash)>] CacResponsePost data, response status code and response headers
    def add_system_cac_with_http_info(body, system_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CACApi.add_system_cac ...'
      end
      # verify the required parameter 'body' is set
      if @api_client.config.client_side_validation && body.nil?
        fail ArgumentError, "Missing the required parameter 'body' when calling CACApi.add_system_cac"
      end
      # verify the required parameter 'system_id' is set
      if @api_client.config.client_side_validation && system_id.nil?
        fail ArgumentError, "Missing the required parameter 'system_id' when calling CACApi.add_system_cac"
      end
      # resource path
      local_var_path = '/api/systems/{systemId}/approval/cac'.sub('{' + 'systemId' + '}', system_id.to_s)

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] || @api_client.object_to_http_body(body) 

      return_type = opts[:return_type] || 'CacResponsePost' 

      auth_names = opts[:auth_names] || ['apikey', 'userid']
      data, status_code, headers = @api_client.call_api(:POST, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CACApi#add_system_cac\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
    # Get location of one or many controls in CAC
    # Returns the location of a system's package in the Control Approval Chain (CAC) for matching `systemId` path parameter
    # @param system_id **System Id**: The unique system record identifier.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :control_acronyms **System Acronym**: Filter query by given system acronym (single or comma separated).
    # @return [CacResponseGet]
    def get_system_cac(system_id, opts = {})
      data, _status_code, _headers = get_system_cac_with_http_info(system_id, opts)
      data
    end

    # Get location of one or many controls in CAC
    # Returns the location of a system&#x27;s package in the Control Approval Chain (CAC) for matching &#x60;systemId&#x60; path parameter
    # @param system_id **System Id**: The unique system record identifier.
    # @param [Hash] opts the optional parameters
    # @option opts [String] :control_acronyms **System Acronym**: Filter query by given system acronym (single or comma separated).
    # @return [Array<(CacResponseGet, Integer, Hash)>] CacResponseGet data, response status code and response headers
    def get_system_cac_with_http_info(system_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CACApi.get_system_cac ...'
      end
      # verify the required parameter 'system_id' is set
      if @api_client.config.client_side_validation && system_id.nil?
        fail ArgumentError, "Missing the required parameter 'system_id' when calling CACApi.get_system_cac"
      end
      # resource path
      local_var_path = '/api/systems/{systemId}/approval/cac'.sub('{' + 'systemId' + '}', system_id.to_s)

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'controlAcronyms'] = opts[:'control_acronyms'] if !opts[:'control_acronyms'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      return_type = opts[:return_type] || 'CacResponseGet' 

      auth_names = opts[:auth_names] || ['apikey', 'userid']
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type)

      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CACApi#get_system_cac\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
