class window.Positioner
  constructor: (@box, @parent, @margin = 0, @preserveSpace = false) ->
    if @box? && $(@box).length > 0
      @accountant = new Accountant(@box, @parent)

      @$box = $(@box)
      @_setData()
      @_initEvents()
      @_controlBoxPosition() # check initial position of box

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
      @_pinBox()
      @_preserveSpace()
    else if windowTopScroll >= @endPoint
      @_unpinBoxAtTheEnd()
    else 
      @_unpinBox()
      @_returnSpace()

  _pinBox: () ->
    @$box
      .addClass('pinned')
      .css
        position: 'fixed'
        width: @boxData.width
        left: @boxData.fixedPositionLeft
        top: @margin
        bottom: ''

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
      $spacer = $('<div class="positioner-spacer">')
      unless @isPreserved
        height = @$box.outerHeight(true)
        $spacer.css('height', height).insertAfter(@box)
        @isPreserved = true

  _returnSpace: () ->
    if @isPreserved
      $('.positioner-spacer').remove()
      @isPreserved = false


  refresh: () ->
    @_setData()

  destroy: () ->
    @_unpinBox()
    $('.positioner-spacer').remove()
    $(window).off '.positioner'


