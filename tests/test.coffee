SpecHelper = require("./support/spec_helper.js")
assert = require("assert")
ReactMini = SpecHelper.ReactMini
MockBrowser = require('mock-browser').mocks.MockBrowser
mock = new MockBrowser()
global.document = mock.getDocument()


global.Awesome = ReactMini.createClass(
  render: ->
      ReactMini.createElement("div")
)
global.Car = ReactMini.createClass(
  getDefaultProps: ->
    {isLocked: 'blue'}
  setInitialState: ->
    {bondo: 'Is Amazing Stuff'}

  render: ->
    _ref = undefined
    ReactMini.createElement('div', {
      'doors': 4
      'locked': @props.isLocked
      'data-colour': 'red'
      'on': true
    }, 
    ReactMini.createElement(Awesome, null), 
      'here it is', 
      ReactMini.createElement('p', { 'className': 'seat', 'bondo': @state.bondo },
        'Which seat can I take? ', 
        (if (_ref = @props) != null then _ref.seat else undefined) or 'none'
      )
    )
)

describe('Array', ->
  describe('#indexOf()', ->
    it('should return -1 when the value is not present', ->
      div = document.createElement("div")
      car = ReactMini.render(Car, div) 

      assert.equal(div.innerHTML, '<div doors="4" locked="blue" data-colour="red" on="true">here it is<p className="seat" bondo="Is Amazing Stuff">Which seat can I take? none</p></div>')
    )
  )
)
