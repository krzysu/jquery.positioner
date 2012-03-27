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

      borderLeft: @_numberize( box.css('border-left-width') )

      absolutePositionTop: parent.height + parent.paddingTop - box.outerHeight()

    data.fixedPositionLeft = data.offsetLeft - data.marginLeft
    data.absolutePositionLeft = data.offsetLeft - parent.offsetLeft - data.marginLeft + parent.borderLeft

    console.log('box', data)
    data

  getParentData: ->
    parent = @$parent

    data =
      width: parent.width()
      height: parent.height()

      offsetLeft: parent.offset().left
      offsetTop: parent.offset().top

      borderLeft: @_numberize( parent.css('border-left-width') )

      paddingLeft: @_numberize( parent.css('padding-left') )
      paddingTop: @_numberize( parent.css('padding-top') )

    console.log('parent', data)

    data

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