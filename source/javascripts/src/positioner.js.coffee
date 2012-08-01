unless window.PositionerNamespace?
  window.PositionerNamespace = {}

class window.PositionerNamespace.Positioner
  @instanceId: ( ->
    id = 0
    ->
      id++
  )()

  constructor: (@box, settings) ->
    @id = PositionerNamespace.Positioner.instanceId()

    if @box? && $(@box).length > 0
      @_readSettings(settings)
      @accountant = new PositionerNamespace.Accountant(@box, @parent)

      @$box = $(@box)
      @_setData()
      @_initEvents()
      @_controlBoxPosition() # check initial position of box

      if @debugMode
        new PositionerNamespace.Debugger(@, @accountant)

  _readSettings: (settings) ->
    @parent = if settings.parent? then settings.parent
    @margin = if settings.margin? then settings.margin else 0
    @preserveSpace = if settings.preserveSpace? then settings.preserveSpace else false
    @debugMode = if settings.debugMode? then settings.debugMode else false
    
    @callbacks = {}
    @callbacks.pinnedCallback = settings.pinnedCallback
    @callbacks.unpinnedCallback = settings.unpinnedCallback

  _setData: () ->
    @isBoxFixed = false # for test purposes
    @isBoxAtTheBottom = false # for test purposes

    unless @isPreserved?
      @isPreserved = false

    @_unpinBox() # we must get box data from unpinned state

    @boxData = @accountant.getBoxData()
    @startPoint = @accountant.getStartPoint() - @margin
    @endPoint = @accountant.getEndPoint() - @margin

  _initEvents: () ->
    $(window).on 'scroll.positioner', () =>
      @_controlBoxPosition()

    $(window).on 'resize.positioner', () =>
      @_setData()
      @_controlBoxPosition()

  _controlBoxPosition: () ->
    windowTopScroll = $(window).scrollTop()

    if windowTopScroll > @startPoint && windowTopScroll < @endPoint
      @_preserveSpace()
      @_pinBox()
    else if windowTopScroll >= @endPoint
      @_unpinBoxAtTheEnd()
    else 
      @_unpinBox()
      @_returnSpace()

  _pinBox: () ->
    unless @isBoxFixed
      @$box
        .addClass('pinned')
        .css
          position: 'fixed'
          width: @boxData.width
          left: @boxData.fixedPositionLeft
          top: @margin
          bottom: ''

      if typeof @callbacks.pinnedCallback == 'function'
        @callbacks.pinnedCallback()

    @isBoxFixed = true
    @isBoxAtTheBottom = false

  _unpinBox: () ->
    @$box
      .removeClass('pinned')
      .css
        position: ''
        width: ''
        left: ''
        top: ''
        bottom: ''

    if @isBoxFixed
      if typeof @callbacks.unpinnedCallback == 'function'
        @callbacks.unpinnedCallback()

    @isBoxFixed = false
    @isBoxAtTheBottom = false

  _unpinBoxAtTheEnd: () ->
    @$box
      .removeClass('pinned')
      .css
        position: 'absolute'
        width: @boxData.width
        left: @boxData.absolutePositionLeft
        top: ''
        bottom: 0

    @isBoxFixed = false
    @isBoxAtTheBottom = true

  _preserveSpace: () ->
    if @preserveSpace
      $spacer = $('<div>').addClass('positioner-spacer-' + @id)
      unless @isPreserved
        height = @$box.outerHeight(true)
        $spacer.css('height', height).insertAfter(@box)
        @isPreserved = true

  _returnSpace: () ->
    if @isPreserved
      $('.positioner-spacer-' + @id).remove()
      @isPreserved = false


  refresh: () ->
    @_setData()

  destroy: () ->
    @_unpinBox()
    $('.positioner-spacer-' + @id).remove()
    $(window).off '.positioner'


