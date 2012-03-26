#= require_tree ./src
#= require_self

class window.PageController
  constructor: () ->
    @positioner = new Positioner('#element', '#parent', 0)
