class window.HtmlFactory
  canvas: () ->
    if $('#test-canvas').length == 0
      @initCanvas()
    $('#test-canvas')

  initCanvas: () ->
    $('body').append("<div id='test-canvas'>")

  clear: () ->
    @canvas().html('')

  boxWithParent: (boxId, parentId) ->
    html = "<div id='#{parentId}'style='height: 1000px; width: 1000px; padding: 10px; margin: 10px; border: 1px solid; position: relative;'>
              <div id='#{boxId}' style='height: 100px; width: 100px; padding: 10px; margin: 10px; border: 1px solid;'></div>
            </div>"
    @canvas().append(html)