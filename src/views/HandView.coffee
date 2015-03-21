class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>) <span class="finalMsg"></span></h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'bust', => @renderBust()
    @collection.on 'playerLost', =>
      console.log('playerlost')
      @renderLoss()
    @collection.on 'playerWin', =>
      console.log('playerwin')
      @renderWin()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

  renderBust: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]
    @$('.finalMsg').text " - You busted!"

  renderWin: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]
    @$('.finalMsg').text " - You WIN!"

  renderLoss: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]
    @$('.finalMsg').text " - You Lost!"
