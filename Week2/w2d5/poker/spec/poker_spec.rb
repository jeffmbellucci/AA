require 'rspec'
require 'poker.rb'

# s c d h
#
# 11
# 12
# 13
# 14

let(:game){Poker.new}
let(:player){Player.new}
let(:deck){Deck.new}



let(:straight_flush) { Hand.new([[11 , :c], [10, :c], [9, :c], [8, :c], [7, :c]]) }
let(:four_of_a_kind) { Hand.new([[4, :c],[4, :d],[4, :h],[4, :s],[14, :c]]) }
let(:full_house?) { Hand.new([[5, :s], [5, :h], [5, :d], [8, :s], [8, :h]]) }
let(:flush)  Hand.flush?([[14, :s],[11, :s],[10, :s],[6, :s],[3, :s]]).should == true

it "calculates a straight flush" do
  Hand.straight_flush?(:straight_flush).should == true
  Hand.straight_flush?(:four_of_a_kind).should_not == true
end

it "calculates four of a kind" do
  Hand.four_of_a_kind?([[4, :c],[4, :d],[4, :h],[4, :s],[14, :c]]).should == true
  Hand.four_of_a_kind?([[5, :s], [5, :h], [5, :d], [8, :s], [8, :h]]).should_not == true

end

it "calculates a full house" do
  Hand.full_house?([[5, :s], [5, :h], [5, :d], [8, :s], [8, :h]]).should == true
    Hand.full_house?([[14, :s],[11, :s],[10, :s],[6, :s],[3, :s]]).should_not == true
end

it "calculates a flush" do
  Hand.flush?([[14, :s],[11, :s],[10, :s],[6, :s],[3, :s]]).should == true
  Hand.flush?([[9, :s],[8, :d],[7, :s],[6, :h],[5, :c]]).should_not == true
end

it "calculates a straight" do
  Hand.straight?([[9, :s],[8, :d],[7, :s],[6, :h],[5, :c]]).should == true
  Hand.straight?([[3, :c],[3, :d],[3, :h],[12, :s],[2, :s]]).should_not == true

end

it "calculates three of a kind" do
  Hand.three_of_a_kind?([[3, :c],[3, :d],[3, :h],[12, :s],[2, :s]]).should == true
  Hand.three_of_a_kind?([[13, :c],[13, :s],[9, :h],[9, :d],[11, :h]]).should_not == true
end

it "calculates two pair" do
  Hand.two_pair?([[13, :c],[13, :s],[9, :h],[9, :d],[11, :h]]).should == true
  Hand.two_pair?([[2, :d],[2, :h],[12, :h],[7, :h],[6, :c]]).should_not == true
end
it "calculates one pair" do
  Hand.one_pair?([[2, :d],[2, :h],[12, :h],[7, :h],[6, :c]]).should == true

end
it "calculates high card" do
  Hand.high_card([14, :h],[13, :h],[12, :c],[10, :h],[2, :c]).should == 14
end












#let(:hand){Hand.new}

describe "Game" do
  it "contains a deck"
  it "contains the correct number of players"
  it "ensures that each player has a hand"
  it "knows whose turn it is"
  it "keeps track of the dollar amount in the pot"
  it "rewards the pot to the winning player"
end

describe "Deck" do
  it "contains 52 cards at first"
  it "does not contain dealt cards"
  it "shuffles"
  it "trades cards"
end

describe "Hand" do
  it "contains 5 cards" do
  it "calculates a straight flush" do
    Hand.straight_flush?([[11 , :c], [10, :c], [9, :c], [8, :c], [7, :c]]).should == true
    Hand.straight_flush?([[4, :c],[4, :d],[4, :h],[4, :s],[14, :c]]).should_not == true
  end

  it "calculates four of a kind" do
    Hand.four_of_a_kind?([[4, :c],[4, :d],[4, :h],[4, :s],[14, :c]]).should == true
    Hand.four_of_a_kind?([[5, :s], [5, :h], [5, :d], [8, :s], [8, :h]]).should_not == true

  end

  it "calculates a full house" do
    Hand.full_house?([[5, :s], [5, :h], [5, :d], [8, :s], [8, :h]]).should == true
      Hand.full_house?([[14, :s],[11, :s],[10, :s],[6, :s],[3, :s]]).should_not == true
  end

  it "calculates a flush" do
    Hand.flush?([[14, :s],[11, :s],[10, :s],[6, :s],[3, :s]]).should == true
    Hand.flush?([[9, :s],[8, :d],[7, :s],[6, :h],[5, :c]]).should_not == true
  end

  it "calculates a straight" do
    Hand.straight?([[9, :s],[8, :d],[7, :s],[6, :h],[5, :c]]).should == true
    Hand.straight?([[3, :c],[3, :d],[3, :h],[12, :s],[2, :s]]).should_not == true

  end

  it "calculates three of a kind" do
    Hand.three_of_a_kind?([[3, :c],[3, :d],[3, :h],[12, :s],[2, :s]]).should == true
    Hand.three_of_a_kind?([[13, :c],[13, :s],[9, :h],[9, :d],[11, :h]]).should_not == true
  end

  it "calculates two pair" do
    Hand.two_pair?([[13, :c],[13, :s],[9, :h],[9, :d],[11, :h]]).should == true
    Hand.two_pair?([[2, :d],[2, :h],[12, :h],[7, :h],[6, :c]]).should_not == true
  end
  it "calculates one pair" do
    Hand.one_pair?([[2, :d],[2, :h],[12, :h],[7, :h],[6, :c]]).should == true

  end
  it "calculates high card" do
    Hand.high_card([14, :h],[13, :h],[12, :c],[10, :h],[2, :c]).should == 14
  end

  #hands are ranked first by category, then by individual cards
  so

  it "names hands" do
    Hand.to_words([[5, :s], [5, :h], [5, :d], [8, :s], [8, :h]]).should == "Full House"














  end

  it "knows if it beats another hand"
end

describe "Card" do
  it "knows its rank and file" do
    #
  end

end

describe "Player" do
  it "contains a hand at the outset of "
  it "keeps track of the dollar amount in their wallet"
  it "asks the user which cards they wish to discard"
  it "asks the user whether they wish to fold, see or raise"
  it "informs the user of invalid input"
  it "loses"

end
