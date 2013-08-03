require 'rspec'
require 'deck.rb'

describe "Deck" do
  let (:deck) { Deck.new }
  let (:random_card) { Card.new }
  
  describe "#initialize" do
   it "builds itself with 52 unique cards" do
     deck.deck.size.should == 52
     deck.deck.uniq.size.should == 52
   end
   
   it "builds itself with one of every card" do
     deck_array = deck.deck.map { |card| [card.rank, card.suit ]}
     deck_array.should be_include([random_card.rank, random_card.suit])
    end
  end
  
  describe "#shuffle" do 
    it "shuffles itself" do
      deck_array = deck.deck.map { |card| [card.rank, card.suit ]}
      deck.shuffle
      shuffled_deck_array = deck.deck.map { |card| [card.rank, card.suit ]}
      (deck_array == shuffled_deck_array).should == false
    end
  end
  
  describe "#deal" do 
  	it "deals a hand of cards" do 
  	  hand = deck.deal(5)
  	  hand.length.should == 5
  	  hand[0].is_a?(Card).should == true
  	end
  	
  	it "takes the dealt cards out of the deck" do
  		card = deck.deal(1)
  		deck.deck.include?(card).should == false
  	end
  
  end


end