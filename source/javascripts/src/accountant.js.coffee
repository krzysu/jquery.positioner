class window.Accountant
  constructor: (@box, @parent) ->
    unless @box? and $(@box).length > 0
      @box = 'body'

    unless @parent? and $(@parent).length > 0
      @parent = 'body'
      @isParentDefined = false

    @$box = $(@box)
    @$parent = $(@parent)

  _numberize: (value) ->
    parseInt(value, 10) || 0

  getBoxData: ->
    box = @$box
    parent = @getParentData()

    data =
      width: box.width()

      offsetLeft: box.offset().left
      offsetTop: box.offset().top
      
      marginLeft: @_numberize( box.css('margin-left') )
      marginTop: @_numberize( box.css('margin-top') )

      absolutePositionLeft: box.offsetLeft - parent.offsetLeft
      absolutePositionTop: parent.height - box.outerHeight() + parent.paddingTop

    data.fixedPositionLeft = data.offsetLeft - data.marginLeft

    return data

  getParentData: ->
    parent = @$parent

    data =
      width: parent.width()
      height: parent.height()

      offsetLeft: parent.offset().left
      offsetTop: parent.offset().top

      paddingLeft: @_numberize( parent.css('padding-left') )
      paddingTop: @_numberize( parent.css('padding-top') )

  getStartPoint: ->
    box = @getBoxData()

    startPoint = box.offsetTop - box.marginTop
    
  getEndPoint: ->
    unless @isParentDefined? and @isParentDefined == false
      box = @getBoxData()
      parent = @getParentData()
      endPoint = parent.offsetTop + @$parent.outerHeight() - @$box.outerHeight(true)
    else
      endPoint = $(document).height()