#= require_tree ./src
#= require_self

class window.PageController
  constructor: ->
    @positioner = new Positioner('#element', '#parent', 0)
    @visualHelper(@positioner.accountant)

  visualHelper: (accountant) ->
    $el = $('#element')

    $('#start-point').text( accountant.getStartPoint() )
    $('#end-point').text( accountant.getEndPoint() )
    @_insertPositionData($el)

    $(window).on 'scroll.visualHelper', () =>
      @_insertPositionData($el)

  _insertPositionData: ($el) ->
    $('#position-left').text( $el.position().left )
    $('#position-top').text( $el.position().left )
    $('#offset-left').text( $el.offset().left )
    $('#offset-top').text( $el.offset().top )