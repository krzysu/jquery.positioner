unless window.PositionerNamespace?
  window.PositionerNamespace = {}

class window.PositionerNamespace.Debugger
  constructor: (@positioner, @accountant) ->
    console.log @positioner, @accountant