# Developers Instructions

The documentation provided here is an OpenAPI (v3.0.3) Specification  compliant describing, producing, consuming, and visualizing the eMASS RESTful API web services (endpoints) as described in the eMASS REST API (v3.2) document, dated October 21, 2021.

The API is documented in YAML and can be viewed utilizing Swagger Editor or Visual Studio Code (VSC) with swagger and yaml extensions.

### Viewing the API via Swagger

There are online tool options for viewing and editing OpenAPI compliant RESTfull APIs like the eMASS API documentations. Some of these tools are Swagger Editor or SwaggerHub. <strong>We discourage the utilization of any online capability for editing a controlled unclassified API document</strong>.

To install the Swagger Editor offline from its repository follow these [instructions](https://github.com/swagger-api/swagger-editor).

### Generate the API documentation (to view in a web browser-html)
eMASS API documentation can be found [here](/docs/redoc/index.html)

To generate the API documentation that can be viewable in a totally dependency-free (and nice looking) HTML use the `redoc-cli` command line tool.


Install the tool via `npm`:
```bash
npm install -g redoc-cli
```
To generate the HTML document, use the following command:
```bash
redoc-cli bundle -o ./output/eMASS.html eMASSRestOpenApi.yaml
```

The command above assumes that the generated file is placed in a subfolder relative to the current folder called output, and that the eMASSRestApi.yaml is in the current working directory. The generated file is called eMASS.html and can be viewed in any web browser.

### Setting up Visual Studio Code
Install these Extensions (Ctrl+Shift+X):
* YAML ([link](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml))
* Swagger Viewer ([link](https://marketplace.visualstudio.com/items?itemName=Arjun.swagger-viewer))
* OpenAPI Swagger Editor ([link](https://marketplace.visualstudio.com/items?itemName=42Crunch.vscode-openapi))
* Swagger Snippets ([link](https://marketplace.visualstudio.com/items?itemName=adisreyaj.swagger-snippets), optional)

Open the eMASS Rest API file by selecting File -> Open Folder and select the folder containing the eMASSRestApi.yaml file. Open the file into the editor and select the "OpenApi: show preview using default render" (Ctrl+K V)

Once the mock server is running, we can utilize the "Try it Out" on each of the API endpoints to test the API documentation with mock data.

### Using PRISM HTTP mock Server
Install prism (if not installed) via npm:
``` npm
npm install -g @stoplight/prism-cli
```

Run the prism server on the localhost, use the -p parameter to set the port (using 4010)
``` node
prism mock -p 4010 eMASSRestOpenApi.yaml
```

To invoke the mock server interactive use the -d parameter (provides fake responses using x-faker)
``` node
prism mock -d -p 4010 eMASSRestOpenAPI.yaml
```
**Note:**
* The Prism starting commands above assumes that the current path contains the eMASSRestAPI.yaml file
* If using VSC, Prism restarts automatically when the yaml file is modified and saved
* Use `npx` instead of `npm` to install packages locally, but still be able to run them as if they were global

Now you can access the fake API endpoints utilizing either CURL or the Swagger Editor. The following curl command invokes the systems endpoint with a path parameter of policy=rmf:
``` node
curl -X GET "http://localhost:4010/api/systems?policy=rmf" -H  "accept: application/json" -H  "api-key: f32516cc-57d3-43f5-9e16-8f86780a4cce" -H  "user-uid: 1647389405"
```
Note: The API expects the api-key and user-uid headers.

## Swagger Codegen
### Clone the source code
Follow these instruction to generate the eMASS client API library (software development kit - SDK):
``` git
git clone https://github.com/swagger-api/swagger-codegen
cd swagger-codegen
git checkout 3.0.0
mvn clean package
```
Alternatively, you can follow instruction listed in [Swagger Codegen](https://github.com/swagger-api/swagger-codegen/tree/3.0.0#getting-started). The eMASS API utilized the OpenAPI version 3.0 standards, ensure that the proper `Swagger Codegen` is utilized to generate the client SDK.


### Build the Client SDK

NOTE: The current [handlebar templates](https://github.com/swagger-api/swagger-codegen/tree/3.0.0#modifying-the-client-library-format) do not provide a configuration variable where a keypassword can be defined  containing the client certificate passphrase used by libcurl wrapper Typhoeus. For this reason, we have provided [updated templates](./swagger-codegen/ruby_template) that can be utilized in the interim until the necessary fixes are integrated into the [main repository](https://github.com/swagger-api/swagger-codegen/tree/3.0.0)

After cloning the appropriate `Swagger Codegen` baseline (3.0.0) generate the SDK (make sure you are in the cloned directory, e.g; /path/to/codegen/swagger-codegen)

To generate the client SDK with provided templates use:
``` node
java -jar swagger-codegen-cli generate generate -i /path/to/yaml/eMASSRestOpenApi.yaml -l ruby -t emass_client/swagger-codegen/ruby_template -o /path/to/sdk/emass_api_client
```


To generate without specifying the templates use:
``` node
java -jar swagger-codegen-cli generate -i /path/to/yaml/eMASSRestOpenApi.yaml -l ruby -o /path/to/sdk/emass_api_client
```
Note: The command listed above is for generating a ruby client SDK. Other languages are available, see instructions [here](https://github.com/swagger-api/swagger-codegen/tree/3.0.0#to-generate-a-sample-client-library)

## Ruby Client
Information about the swagger generated ruby client SDK refer to the [ruby_client](./ruby_client) directory.


---

NOTICE

© 2020 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.
NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.
NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation. DISA STIGs are published by DISA, see: https://public.cyber.mil/privacy-security/
