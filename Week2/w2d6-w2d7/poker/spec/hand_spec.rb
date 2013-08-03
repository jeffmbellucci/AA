require 'rspec'
require 'hand.rb'
require 'card.rb'




describe 'Hand' do 

  let (:sf) do
  	Hand.new(
  	  [[11 , :c], [10, :c], [9, :c], [8, :c], [7, :c]].map { |c| Card.new(c) }
  	)
  end
  
  let (:sf2) do
    Hand.new(
  	  [[11 , :d], [10, :d], [9, :d], [8, :d], [7, :d]].map { |c| Card.new(c) }
  	)
  end
  
  let (:foak) do
    Hand.new(
      [[4, :c], [4, :d], [4, :h], [4, :s], [14, :c]].map { |c| Card.new(c) }
    )
   end
 
  let (:fh) do 
    Hand.new(
      [[5, :s], [5, :h], [5, :d], [8, :s], [8, :h]].map { |c| Card.new(c) }
    )  
  end
    
  let (:f) do
    Hand.new(
      [[14, :s], [11, :s], [10, :s], [6, :s], [3, :s]].map { |c| Card.new(c) }
    )
  end
  
  let (:almost_f) do
    Hand.new(
      [[14, :s], [11, :s], [10, :s], [6, :s], [3, :c]].map { |c| Card.new(c) }
    )
  end

  let (:s) do 
    Hand.new(
     [[9, :s], [8, :d], [7, :s], [6, :h], [5, :c]].map { |c| Card.new(c) }
    )
  end

  let (:almost_s) do 
    Hand.new(
     [[9, :s], [5, :s], [7, :s], [6, :h], [5, :c]].map { |c| Card.new(c) }
    )
  end
  let (:toak) { Hand.new([[3, :c],[3, :d],[3, :h],[12, :s],[2, :s]].map { |card| Card.new(card) })}

  let (:tp) { Hand.new([[13, :c],[13, :s],[9, :h],[9, :d],[11, :h]].map { |card| Card.new(card) })}

  let (:op) { Hand.new([[2, :d],[2, :h],[12, :h],[7, :h],[6, :c]].map { |card| Card.new(card) })}

  let (:nothing) { Hand.new([[14, :h],[13, :h],[12, :c],[10, :h],[2, :c]].map { |card| Card.new(card) })}


#TODO tidy the above up

	describe '::same_suit' do 
	  it "returns true vacously" do 
	  	Hand.same_suit?([]).should == true
	  end
	  
	  it "returns true if all the cards are in the same suit" do
	  	Hand.same_suit?(f.cards).should == true
	  end
	  
	  it "returns false if one of the cards in a distinct suit" do 
	  	Hand.same_suit?(almost_f.cards).should == false
	  end
	  it "returns false if more than one of the cards is in a distinct suit" do
	    Hand.same_suit?(nothing.cards).should == false
	  end
	end
	
	describe '::in_a_row?' do
	  it "returns true vacuosly" do 
	  	Hand.in_a_row?([]).should == true
	  end
	  it "returns true if the cards are in sequence by rank" do 
	  	Hand.in_a_row?(s.cards).should == true
	  end
	  it "returns false if one of the cards are not in sqeuence" do
	    Hand.in_a_row?(almost_s.cards).should == false
	  end
	  it "returns false if more than one of the cards are not in sequence" do
	  	Hand.in_a_row?(nothing.cards).should == false
	  end
	end
	
	describe '::sort_ace_high' do 
	
	end
	
	describe '::count_ranks' do 
	
	end
	
	describe '::same_rank' do 
	
	end
	
	describe '::straight_flush?' do
	  it "returns true when passed a straight flush" do
	  	Hand.straight_flush?(sf).should == true
	  end
	  
	  it "returns false when passed a non straight flush"  do 
	    Hand.straight_flush?(f).should == false
	    Hand.straight_flush?(s).should == false
	    Hand.straight_flush?(nothing).should == false
	  end
	
	end
	
	describe '::four_of_a_kind?' do 
		
	  it "returns true when passed a four of a kind" do
	    Hand.four_of_a_kind?(foak).should == true
	  end
	
	  it "returns false when passed a non four of a kind" do
	    Hand.four_of_a_kind?(tp).should == false
	    Hand.four_of_a_kind?(nothing).should == false
	  end

	end
	
	describe '::full_house?' do
	  it "returns true when passed a full house" do 
	    Hand.full_house?(fh).should == true
	  end
	  
	  it "returns false when passed non full house" do 
	    Hand.full_house?(f).should == false
	    Hand.full_house?(nothing).should == false
	  end
	end
	
	describe '::flush?' do
	 it "returns true when passed a flush" do 
	 	Hand.flush?(f).should == true
	 end
	 
	 it "returns false when passed a non flush" do
	 	Hand.flush?(s).should == false
	 	Hand.flush?(nothing).should == false
	 end
	
	end
	
	describe '::straight?' do
	  it "returns true when passed a straight" do 
	    Hand.straight?(s).should == true
	  end
	  
	  it "returns false when passed a non straight" do 
	    Hand.straight?(tp).should == false
	    Hand.straight?(nothing).should == false
	  end
	
	end
	
	describe '::three_of_a_kind?' do
	  it "returns true when passed a three of a kind" do 
        Hand.three_of_a_kind?(toak).should == true
	  end
		
	  it "returns false when passed a non three of a kind" do 
	    Hand.three_of_a_kind?(op).should == false
		Hand.three_of_a_kind?(nothing).should == false
	  end
	end
	
	describe '::two_pair?' do
	  it "returns true when passed a two pair" do 
	    Hand.two_pair?(tp).should == true
	  end
	  
	  it "returns false when passed a non two pair" do 
	    Hand.two_pair?(op).should == false
	    Hand.two_pair?(nothing).should == false
	  end
	end
	
	describe '::one_pair?' do 
	  it "returns true when passed a one pair" do
	    Hand.one_pair?(op).should == true
	  end
	  
	  it "returns false when passed a non one pair" do 
	    Hand.one_pair?(nothing).should == false
	  end
	end
	
	describe '::high_card?' do
	  it "returns the high card's rank when pased a hand" do 
	   Hand.high_card(nothing).should == 14
	   Hand.high_card(op).should == 12
	  end
	end
	
	describe '#<=>' do
	  it "returns 0 if the hands are a tie" do
	    (sf <=> sf2 ).should == 0
	  end
	  
	  it "returns -1 if the first hand loses" do 
	    (op <=> tp).should == -1
	  end
	  
	  it "returns 1 if the first hand wins" do 
	    (f <=> op).should == 1
	  end
	end
	
	describe '#to_a' do
	  it "returns an array representation of the hand" do 
	   nothing.to_a.should == [[14, :h],[13, :h],[12, :c],[10, :h],[2, :c]]
	  end	
	end
	
end