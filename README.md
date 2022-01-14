# emasser
![GitHub Release Date](https://img.shields.io/github/release-date/mitre/emasser?label=Release%20Date)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/mitre/emasser?label=Release%20Version)
[![Gem Version](https://badge.fury.io/rb/emasser.svg)](https://badge.fury.io/rb/emasser)
</br>
![emasser Testing](https://github.com/mitre/emasser/actions/workflows/test-cli.yml/badge.svg)
![CodeQL Vulnerabilities and Errors](https://github.com/mitre/emasser/actions/workflows/codeql-analysis.yml/badge.svg)
![Docs Generation](https://github.com/mitre/emasser/actions/workflows/generate_docs.yml/badge.svg)
![Code Linter](https://github.com/mitre/emasser/actions/workflows/rubocop.yml/badge.svg)
## About

`emasser` is a command line interface (CLI) that aims to automate routine business use-cases and provide utility surrounding the Enterprise Mission Assurance Support Service (eMASS) by leveraging its representational state transfer (REST) application programming interface (API) v3.2.

## Documentation
emasser provides users with the following documentation:

[**eMASS API Documentation**](https://mitre.github.io/emasser/docs/redoc/) | [**eMASS Swagger UI**](https://mitre.github.io/emasser/docs/swagger/)

## Current Features

The following eMASS API HTTP methods are implemented:
* `GET` view eMASS resources
* `POST` add eMASS resources
* `PUT` update eMASS resources
* `DELETE` remove eMASS resources


[**emasser CLI Features**](docs/features.md) | [**emasser Developers Instructions**](docs/developers.md)

## In Development

This project is actively looking for user stories, features to build, and interactions with eMASS. See Roadmap for more information.

* Support raw JSON upload

## Roadmap

Emasser is currently in MVP development and we are targeting all the features listed in Current and In Development for version 1.0.X. The Road Map are things that the team and community have talked about as possible great additions but feedback on which should come first, second, and third are what we would love feedback on from you.

* Update a system's record with met/not met NIST 800-53 Security and Privacy controls and/or common control indicators (CCI) based on scan results expressed in [Heimdall Data Format (HDF)](https://saf.mitre.org/#/normalize).
* Resolve a particular plan of action and milestone (POA&M) based on scan results or git-ops workflow.
* PKCS11 support to run in an attended mode.

## Installation

`emasser` is a Ruby CLI that is distributed via git only. You must request the source from saf@groups.mitre.org

Installation Dependencies:
  * git
  * Ruby version 2.7 or greater.

Runtime Dependencies:
  * Ruby version 2.7 or greater.
  * `rubyzip (latest version)`
  * `emass_client (latest version)`
  * On Windows the `cURL` binary is required (libcurl.dll). To install cURL:
    - Download cURL for windows from [curl x.x.x for Windows](https://curl.se/windows/)
      - Go into the archive and browse to the /bin directory
      - Locate libcurl_x64.dll (it may be named just libcurl.dll)
      - Extract the file into the Ruby installation /bin directory
      - Rename the file to `libcurl.dll` if it has the `_x64` suffix
    - Install [cURL for windows](https://community.chocolatey.org/packages/curl) and add the installation directory to the PATH.


To install (via github):
```bash
git clone <path to emasser git> emasser
cd emasser
```
- Build the emasser gem
```bash
  gem build *.gemspec
  gem install *.gem
```
- Build the emass_client gem
```bash
  cd emass_client/ruby_client
  gem build *.gemspec
  gem install *.gem
```

To install (via published RubyGems):
```bash
gem install emasser
```

**Note:** To run in development mode there isn't a need to build the gem, simply clone from the emasser repository and use:
```
bundle exec exe/emasser [command]
```

## Using Docker
### Run the emasser Docker Container (--rm remove the container when exit)
- To run the emasser container use:
  ```
  docker run --rm -v $PWD/path-to-secrets:/data mitre/emasser:latest
  ```
- To list all GET, POST, PUT, or DELETE commands use:
  ```
  docker run --rm -v $PWD/path-to-secrets:/data mitre/emasser:latest get help
  ```
  ```
  docker run --rm -v $PWD/path-to-secrets:/data mitre/emasser:latest post help
  ```
  ```
  docker run --rm -v $PWD/path-to-secrets:/data mitre/emasser:latest put help
  ```
  ```
  docker run --rm -v $PWD/path-to-secrets:/data mitre/emasser:latest delete help
  ```

### Delete (remove) the Docker Container
```
  docker rmi -f emasser
```

## Use

**Requirement 1 & 2: Authentication and Authorization:**
`emasser` requires authentication to eMASS as well as authorization to use the eMASS API. This authentication and authorization is **not** a function of `emasser` and needs to be handled directly with discussions with [eMASS](https://www.dcsa.mil/is/emass/). `emasser` will accept credentials that are created based on those discussions.

**Approve API Client for Actionable Requests**
Users are required to log-in to eMASS and grant permissions for a client to update data within eMASS on their behalf. This is only required for actionable requests (PUT, POST, DELETE). The Registration Endpoint and all GET requests can be accessed without completing this process with the correct permissions.

To establish an account with eMASS and/or acquire an api-key/user-uid, contact one of the listed POC:
* [eMASS Tier III support - Website](https://www.dcsa.mil/is/emass/)
* [Send email to eMASS Tier III support](disa.meade.id.mbx.emass-tier-iii-support@mail.mil)
* [eMASS New User Registration (CAC required)](https://nisp.emass.apps.mil/Content/Help/jobaids/eMASS_OT_NewUser_Job_Aid.pdf)


## Design

**Interactions with eMASS API:**
`emasser` leverages a MITRE dependency, `emass_client`, which provides a REST API client based on a MITRE-created [OpenAPI](https://www.openapis.org/) version 3 specification for the official eMASS version 3.2 API documentation. This design enables REST API clients to be generated in [any supported programming language](https://swagger.io/tools/swagger-codegen/). This design decision enables `emass_client` to generate a Ruby client for `emasser` and a TypeScript client that is included with [Heimdall Enterprise Server](https://github.com/mitre/heimdall2).

**Business Logic:**
Because interactions with the API are handled by a dependency, the bulk of `emasser` is business logic for accepting user input/output, reading data from eMASS or from input, transforming data, and routing data to the appropriate eMASS API endpoint. This business logic is organized into Ruby Classes and Modules based on the command or subcommand requested by the user.


### NOTICE

© 2020 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.
