describe "Positioner - fix element position during scroll", ->
  
  htmlFactory = new HtmlFactory()

  beforeEach () ->
    htmlFactory.boxWithParent('box', 'parent')

  afterEach () ->
    setTimeout (-> htmlFactory.clear() ), 50

  describe "Positioner without parent element", ->
    it "should set end point to height of document if no parent element provided or not found", ->
      
      settings =
        margin: 0

      positioner = new PositionerNamespace.Positioner('#box', settings)
      expect(positioner.endPoint).toEqual( $(document).height() )
      expect( (positioner.endPoint - positioner.startPoint) > 869 ).toBeTruthy()

  describe "Positioner with parent element", ->

    beforeEach () ->
      @settings =
        parent: '#parent'
        margin: 10

      @positioner = new PositionerNamespace.Positioner('#box', @settings)
      @browserWindow = new Window(@positioner)

    afterEach () ->
      @positioner.destroy()

    it "should set start and end points, where box will have position fixed", ->
      expect( @positioner.endPoint - @positioner.startPoint ).toEqual(869) # see accountant test

    it "should pin box position when window top scroll value is in range of start/end points", ->
      @browserWindow.scrollInRange()
      distanceFromTopOfWindow = $('#box').offset().top - $(window).scrollTop()

      expect(distanceFromTopOfWindow).toEqual(@settings.margin + @positioner.boxData.marginTop)
      expect(@positioner.isBoxFixed).toEqual(true)

    it "should not pin box position when window top scroll value is on edge of start point", ->
      @browserWindow.scrollStartPoint()
      expect(@positioner.isBoxFixed).toEqual(false)

    it "should not pin box position when window top scroll value is on edge of end point", ->
      @browserWindow.scrollEndPoint()
      expect(@positioner.isBoxFixed).toEqual(false)

    it "should unpin box position when window top scroll value was in range but now is above the starting point", ->
      @browserWindow.scrollInRange()
      @browserWindow.scrollAboveRange()
      
      distanceFromTopOfWindow = $('#box').offset().top - $(window).scrollTop()

      expect(distanceFromTopOfWindow).not.toEqual(@settings.margin)
      expect(@positioner.isBoxFixed).toEqual(false)

    it "should leave box at the bottom of parent when window top scroll value was in range but now is under the end point", ->
      @browserWindow.scrollInRange()
      @browserWindow.scrollUnderRange()

      distanceFromTopOfWindow = $('#box').offset().top - $(window).scrollTop()
      distanceFromTopOfParent = $('#box').offset().top - $('#parent').offset().top

      expect(distanceFromTopOfWindow).not.toEqual(@settings.margin)
      expect(distanceFromTopOfParent).toEqual(889) # remember about the border
      expect(@positioner.isBoxAtTheBottom).toEqual(true)

    it "should be able to destroy itself", ->
      @browserWindow.scrollInRange()
      
      @positioner.destroy()

      distanceFromTopOfWindow = $('#box').offset().top - $(window).scrollTop()
      expect(distanceFromTopOfWindow).not.toEqual(@settings.margin)
      expect(@positioner.isBoxFixed).toEqual(false)

    it "should preserve the width of positioned box when pinned", ->
      $box = $('#box')
      boxWidthBefore = $box.width()
      @browserWindow.scrollInRange()
      boxWidthAfter = $box.width()

      expect(boxWidthBefore).toEqual(boxWidthAfter)

    it "should preserve the width of positioned box when left at the bottom", ->
      @browserWindow.scrollInRange()
      
      $box = $('#box')
      boxWidthBefore = $box.width()
      @browserWindow.scrollUnderRange()
      boxWidthAfter = $box.width()

      expect(boxWidthBefore).toEqual(boxWidthAfter)

    it "should recalculate all values after window resize", ->
      @browserWindow.scrollInRange()
      @browserWindow.resize()

      distanceFromTopOfWindow = $('#box').offset().top - $(window).scrollTop()

      expect(distanceFromTopOfWindow).toEqual(@settings.margin + @positioner.boxData.marginTop)
      expect(@positioner.isBoxFixed).toEqual(true)


