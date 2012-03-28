#= require_tree ./src
#= require_self

class window.PageController
  constructor: ->
    positioner = new Positioner('#element', '#parent', 0)
    @visualHelper(positioner.accountant)

    setTimeout (
      ->
        $('#parent').height(1500) 
        positioner.refresh()
      ), 4000

  visualHelper: (accountant) ->
    $el = $('#element')

    @_insertPositionData($el, accountant)

    $(window).on 'scroll.visualHelper', () =>
      @_insertPositionData($el, accountant)

  _insertPositionData: ($el, accountant) ->
    $('#position-left').text( $el.position().left )
    $('#position-top').text( $el.position().left )
    $('#offset-left').text( $el.offset().left )
    $('#offset-top').text( $el.offset().top )

    $('#start-point').text( accountant.getStartPoint() )
    $('#end-point').text( accountant.getEndPoint() )