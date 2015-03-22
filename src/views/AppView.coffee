class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="newGame">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .newGame': -> 
      $('body').children().remove()
      new AppView(model: new App()).$el.appendTo 'body'

  initialize: ->
    @model.on('changeButtons', ->
      console.log('button actions')
      $('.hit-button').animate({
        opacity: 0,
        left: "-50"
      }, 1000) #hide()
      $('.stand-button').animate({
        opacity: 0,
        left: "-50"
      }, 1000) #.hide()
      $('.newGame').animate({
        opacity: 1.0,
      }, 1000) #.show()
    )
    @render()
    @model.checkForBlackjack()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

