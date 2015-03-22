# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', (->
     	@get('dealerHand').at(0).flip()
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
    @get('dealerHand').on('playerLost playerWin bust push', =>
      @trigger('changeButtons')
      )
    @get('playerHand').on('playerLost playerWin bust', =>
      @trigger('changeButtons')
      )

  dealerStand: ->
    dealerScore = @get('dealerHand').scores()[0]
    playerScore = @get('playerHand').scores()[0]

    @get('playerHand').checkScores(dealerScore, playerScore)

  checkForBlackjack: =>
    console.log("checkForBlackjack")
    if @get('dealerHand').scores()[0] == 21
      console.log("Dealer BJ!")
      @trigger('changeButtons')
      @get('dealerHand').blackJack()
    else if @get('playerHand').scores()[0] == 21
      console.log("Player BJ!")
      @trigger('changeButtons')
      @get('playerHand').blackJack()
    else 
      @get('dealerHand').at(0).flip()



