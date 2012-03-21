#= require ./positioner
#= require_self

class window.PageController
  constructor: () ->
    console.log('test')
    @positioner = new Positioner('#element', '#parent', 0)
