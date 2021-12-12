Remove milestones in a system for one or many poa&m items

To delete a milestone the record must be inactive by having the field isActive set to false (isActive=false).

The server returns an empty object upon successfully deleting a milestone.

The last milestone can not be deleted, at-least on must exist.

Example:

bundle exec exe/emasser delete milestones remove--systemId [value] --poamId [value] --milestoneId [value]
