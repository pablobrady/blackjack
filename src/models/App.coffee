# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', (->
     	@get('dealerHand').hit()
    	).bind(@))
    @get('dealerHand').on('hit', (->
     	@get('dealerHand').checkBust()
    	).bind(@))
    @get('playerHand').on('hit', (->
     	@get('playerHand').checkBust()
    	).bind(@))
    @get('dealerHand').on('gameOver', (->
     	@dealerStand()
    	).bind(@))

  dealerStand: ->
    dealerScore = @get('dealerHand').scores()[0]
    playerScore = @get('playerHand').scores()[0]

    @get('playerHand').checkScores(dealerScore, playerScore)


