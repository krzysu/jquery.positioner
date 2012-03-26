class window.Accountant
  constructor: (@element, @parent) ->
    unless @element? and $(@element).length > 0
      @element = document

    unless @parent? and $(@parent).length > 0
      @parent = document

  getElementBasicData: ->
    @_getBasicData(@element)
  
  getParentBasicData: ->
    @_getBasicData(@parent)

  _getBasicData: (@el) ->
    data =
      width: @el.width()
      height: @el.height()
      offsetLeft: @el.offset().left
      offsetTop: @el.offset().top

  getStartPoint: ->
    
  getEndPoint: ->