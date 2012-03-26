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
    html = "<div id='#{parentId}' style='padding: 10px; height: 1000px; width: 1000px; margin: 100px 20px; position: relative;'>
              <div id='#{boxId}' style='padding: 10px; height: 100px; width: 100px;'></div>
            </div>"
    @canvas().append(html)