require './card'

class CardNotInDeckError < RuntimeError
end

class Deck
  attr_reader :deck
  
  def initialize(deck = build_deck)
    @deck = deck
  end

  def deal(num)
    deck.shift(num)
  end
  
#   def card_object(rank, suit)
#     card_object = nil
#     deck.each do |card|
#       card_object = card if card.rank = rank && card.suit = suit
#     end
#     card_object
#   end
  
  #is this even neccesary?
 #  def give_card(card) #can take a card object or a rank and suit
#     card = card_object(card[0], card[1]) unless card.is_a?('Card')
#     raise CardNotInDeckError.new('that card is not in the deck') if card.nil?
#     @deck.delete(card)
#     card #remove the card from the deck and return it
#   end
  
  
  def recieve(cards) #put the card on the bottom of the deck . . . should we shuffle this instead?
  	  if cards.is_a?(Array)
  	    @deck += cards
  	  else
  	    @deck << cards
  	  end
  end
      
  def shuffle
    self.deck.shuffle!
  end
  
  private
  
  def deck=(new_deck)
  	@deck = new_deck
  end

  def build_deck
    deck = []
    [:s, :d, :c, :h].each do |suit|
      (2..14).each do |rank|
        deck << Card.new([rank, suit])
      end
    end
    deck
  end

end