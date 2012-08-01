#= require_tree ./src
#= require_self

#
# jquery.positioner
# desc: keep element in fixed position during window scroll
# version: 1.1
# requires: jQuery 1.7+
# author: Krzysztof Urbas, @krzysu, myviews.pl
# license: available under the MIT license
# homepage: https://github.com/krzysu/jquery.positioner

# how to use?
# init:     $(selector).positionMe(options)
# refresh:  $(selector).positionMe('refresh')
# destroy:  $(selector).positionMe('destroy')

# options:
#   parent: null            // parent element that limit box position
#   margin: 0               // distance between positioned element and top of the window 
#   preserveSpace: false    // will add temporary element in exactly the same dimensions like positioned element to preserve page layout
#   pinnedCallback: ->      // called once when positioned element is pinned to screen
#   unpinnedCallback: ->    // called once when positioned element is unpinned from screen


$ = jQuery
positioner = null

$.fn.positionMe = (method) ->
  if methods[method]
    return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ))
  else if typeof method == 'object' || !method
    return methods.init.apply( this, arguments )
  else
    $.error('Method ' +  method + ' does not exist on jQuery.positionMe')    


methods = 
  init: (options) ->
    defaults =
      parent: null
      margin: 0
      preserveSpace: false
      debugMode: false
      pinnedCallback: ->
      unpinnedCallback: ->

    settings = $.extend({}, defaults, options)
    positioner = new PositionerNamespace.Positioner(@, settings)
    @

  refresh: () ->
    if positioner?
      positioner.refresh()
    @

  destroy: () ->
    if positioner?
      positioner.destroy()
    @

