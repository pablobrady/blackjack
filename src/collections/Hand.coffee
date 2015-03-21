class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @isDealer = @isDealer
    @on 'flip', => @trigger('flip2')

  hit: ->
    console.log(@isDealer, " HIT RECEIVED!")
    if @isDealer? and @scores()[0] >= 17 and @scores()[0] <=21
      console.log('Dealer stands on ' + @scores()[0])
      @trigger('gameOver')
    else 
      @add(@deck.pop())
      @trigger('hit')

    if @isDealer? and @scores()[0] >= 17 and @scores()[0] <=21
      console.log('Dealer stands on ' + @scores()[0])
      @trigger('gameOver')
    else if @isDealer? and @scores()[0] <= 21
      @hit()
    
  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]
    if @minScore() + 10 * @hasAce() > 21
      return [@minScore()]
    else 
      return [@minScore() + 10 * @hasAce()]


  checkBust: ->
    # If this score > 21  BUST!
    score = @get('scores')
    if @scores()[0] > 21
      @trigger("bust")

  stand: ->
    # 
    # If the player's score is >21 -- BUST!
    # Else Dealer's turn.  
    #   Flip 1st card
    #   Check dealer score... less than 17?  Hit!  else Stand!
    # Compare player and dealer score.
    # 
    # console.log(Math.max(@get("scores")))
    
    # dealer's turn
    @trigger('stand')


  checkScores: (dealerScore, playerScore) ->
    if dealerScore > playerScore
      console.log('playerl ost')
      @trigger('playerLost')
    else if playerScore > dealerScore
      console.log('player won')
      @trigger('playerWin')
    else
      @trigger('push')
