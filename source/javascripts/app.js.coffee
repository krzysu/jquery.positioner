#= require_tree ./src
#= require_self

class window.PageController
  constructor: ->
    @initSettings()
    
    # @initCoffeeVersion()
    @initJqueryVersion()

  initSettings: ->
    @settings =
      parent: '#parent'
      margin: 0
      preserveSpace: false
      debugMode: true
      pinnedCallback: ->
        console.log 'pinned callback test'
      unpinnedCallback: ->
        console.log 'unpinned callback test'

  initCoffeeVersion: ->
    positioner = new PositionerNamespace.Positioner('#element', @settings)
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

  initJqueryVersion: ->
    $('#element').positionMe( @settings )

    setTimeout (
      ->
        $('#parent').height(1500) 
        $('#element').positionMe 'refresh'
      ), 4000
