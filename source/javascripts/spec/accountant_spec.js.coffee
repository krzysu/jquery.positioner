describe "Accountant - count distances between box and parent", ->
  
  htmlFactory = new HtmlFactory()

  beforeEach () ->
    htmlFactory.boxWithParent('box', 'parent')

  afterEach () ->
    setTimeout (-> htmlFactory.clear() ), 50

  describe "Accountant without parent element", ->
    it "should set end point to height of document if no parent element provided or not found", ->
      accountant = new PositionerNamespace.Accountant('#box', '')

      expect( accountant.getEndPoint() ).toEqual( $(document).height() )
      expect( (accountant.getEndPoint() - accountant.getStartPoint()) > 869 ).toBeTruthy()

  describe "Accountant with parent element", ->

    beforeEach () ->
      @accountant = new PositionerNamespace.Accountant('#box', '#parent', @margin)

    it "should set start and end points, where box will have position fixed", ->
      
      # x = $('#box').offset().top
      # y = $('#parent').offset().top
      # x - y = 21
      # startPoint = box.offsetTop - box.marginTop = x - 10
      # endPoint = parent.offsetTop + @$parent.outerHeight() - @$box.outerHeight(true) = y + 1022 - 142
      # endPoint - startPoint = y - x + 890 = 869
      
      expect( @accountant.getEndPoint() - @accountant.getStartPoint() ).toEqual(869)