class window.Window
  constructor: (@positioner) ->
    @$win = $(window)
    
  scrollInRange: ->
    positionInRange = @positioner.startPoint + 100
    @$win.scrollTop(positionInRange).trigger('scroll')

  scrollAboveRange: ->
    positionAboveRange = @positioner.startPoint - 100
    @$win.scrollTop(positionAboveRange).trigger('scroll')

  scrollUnderRange: ->
    positionUnderRange = @positioner.endPoint + 100
    @$win.scrollTop(positionUnderRange).trigger('scroll')

  scrollStartPoint: ->
    position = @positioner.startPoint
    @$win.scrollTop(position).trigger('scroll')

  scrollEndPoint: ->
    position = @positioner.endPoint
    @$win.scrollTop(position).trigger('scroll')

  resize: ->
    @$win.trigger('resize')