Remove one or many artifacts in a system

Provide single file or a space/comma delimited list of file names to be removed from the system (systemId)

Example:
If running from source code:
  bundle exec [ruby]  exe/emasser delete artifacts remove --systemId [value] --files [value] 
  or
  bundle exec exe/emasser delete artifacts remove --systemId [value] --files [value ... value] 
If running from gem:
  emasser delete artifacts remove --systemId [value] --files [value] 
  or
  emasser delete artifacts remove --systemId [value] --files [value ... value] 
