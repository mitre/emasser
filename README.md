# emasser

## About

`emasser` is a command line interface (CLI) that aims to automate routinue business use-cases and provide utlity surrounding the Enterprise Mission Assurance Support Service (eMASS) by leveraging its relational state transfer (REST) application programming interface (API).


## Current Features

* `GET` all eMASS resources
* Upload artifacts to a system

```
Emasser commands:
  emasser get [RESOURCE]                    # Gets a resource
  emasser help [COMMAND]                    # Describe available commands or one specific command
  emasser upload SYSTEM_ID FILE [FILE ...]  # Uploads [FILES] to the given [SYSTEM_ID] as artifacts
```
CLI [features examples](FEATURES.md)

## In Development

This project is actively looking for user stories, features to build, and interactions with eMASS. See Roadmap for more information.

* Support raw JSON upload

## Roadmap

Emasser is currently in MVP development and we are targeting all the features listed in Current and In Development for version 1.0. The Road Map are things that the team and community have talked about as possible great additions but feedback on which should come first, second, and third are what we would love feedback on from you.

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
  * `swagger_client (latest version)` (Also referred to as `emass_client` and distributed via git only)

To install:
```bash
git clone <path to emasser git> emasser
cd emasser
gem build *.gemspec
gem install *.gem
```

## Use

**Requirement 1 & 2: Authentication and Authorization:**
`emasser` requires authentication to eMASS as well as authorization to use the eMASS API. This authentication and authorization is **not** a function of `emasser` and needs to be handled directly with discussions with eMASS. `emasser` will accept credentials that are created based on those discussions.

## Design

**Interactions with eMASS API:**
`emasser` leverages a MITRE dependency, `emass_client`, which provides a REST API client based on a MITRE-created [OpenAPI](https://www.openapis.org/) version 3 specification based on the official eMASS version 2.3 API documentation. This design enables REST API clients to be genereated in [any supported programming language](https://swagger.io/tools/swagger-codegen/). This design decision enables `emass_client` to generate a Ruby client for `emasser` and a TypeScript client that is included with [Heimdall Enterprise Server](https://github.com/mitre/heimdall2).

**Business Logic:**
Because interactions with the API are handled by a dependency, the bulk of `emasser` is business logic for accepting user input/output, reading data from eMASS or from input, transforming data, and routing data to the appropriate eMASS API endpoint. This business logic is organized into Ruby Classes and Modules based on the command or subcommand requested by the user.


### NOTICE

© 2018 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE  

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.
