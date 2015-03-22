assert = chai.assert

describe "black jack test", ->

  it "should end the game on Blackjack", ->
    collection = new Deck()

    playerCard1 = new Card
        rank: 1
        suit: 2
    playerCard2 = new Card
        rank: 10
        suit: 2

    playerHand = new Hand [playerCard1, playerCard2], @

    dealerCard1 = new Card
        rank: 1
        suit: 2
    dealerCard2 = new Card
        rank: 9
        suit: 2
    dealerHand = new Hand [dealerCard1, dealerCard2], @, true

    # Expect Blackjack for Player, and a Win.

    spy = sinon.spy();
    
    # assert.strictEqual collection.length, 52
