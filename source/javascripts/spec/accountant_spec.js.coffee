describe "Accountant - count distances between box and parent", ->
  
  htmlFactory = new HtmlFactory()

  beforeEach () ->
    htmlFactory.boxWithParent('box', 'parent')

  afterEach () ->
    setTimeout (-> htmlFactory.clear() ), 50

  describe "Accountant without parent element", ->
    it "should set end point to height of document if no parent element provided or not found", ->
      accountant = new Accountant('#box', '')

      expect( accountant.getEndPoint() ).toEqual( $(document).height() )
      expect( (accountant.getEndPoint() - accountant.getStartPoint()) > 880 ).toBeTruthy()

  describe "Accountant with parent element", ->

    beforeEach () ->
      @accountant = new Accountant('#box', '#parent', @margin)

    it "should set start and end points, where box will have position fixed", ->
      expect( @accountant.getEndPoint() - @accountant.getStartPoint() ).toEqual(880)