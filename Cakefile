{exec, spawn} = require 'child_process'

handleError = (err) ->
  if err
    console.log "Error : #{err.stack}"

task 'build', 'Compile facebook Coffeescript source to Javascript', ->
  exec 'mkdir -p lib && coffee -c -o lib src', handleError

