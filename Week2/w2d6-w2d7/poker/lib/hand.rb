class Hand

  attr_reader :cards
  def initialize(cards)
  	@size = 5
  	unless cards.is_a?(Array) && cards.count == 5 && cards.all? { |card| card.is_a?(Card) }
  	  raise ArgumentError.new('A hand must be initialized with #{size} cards') 
  	end
  	@cards = cards
  end
  
  def self.same_suit?(cards)
  	return true if cards.empty? 
    suit = cards[0].suit
    cards.all? { |card| card.suit == suit }
  end
  
  def self.in_a_row?(cards)
    return true if cards.empty?
    in_order_ace_high, in_order_ace_low = true, true
    
   	sorted = sort_ace_high(cards)
    sorted.each_with_index do |card, index|
      next if index == 0
      in_order_ace_high = false unless card.rank == sorted[index-1].rank + 1
    end
    
    sorted = sort_ace_low(cards)
    sort_ace_low(cards).each_with_index do |card, index|
      next if index == 0
      unless  (card.rank % 14) == ((sorted[index-1].rank + 1) % 14)
      	in_order_ace_low = false 
      end
    end
    
	(in_order_ace_high || in_order_ace_low)   
  end
    
  def self.sort_ace_high(cards) 
  	cards.dup.sort{|a, b| a.rank <=> b.rank }
  end
  
  def self.sort_ace_low(cards)
    cards.dup.sort{ |a, b| (a.rank % 14) <=> (b.rank % 14) }
  end
  
  def self.count_ranks(cards)
  	ranks = Hash.new(0)

  	cards.each do |card|
  		ranks[card.rank] += 1
  	end
  	ranks
  end
  
  def self.same_rank?(cards)
    number = cards[0].rank
    cards.all?{ card.rank == number }
  end
  
  def self.straight_flush?(hand)  
    Hand.in_a_row?(hand.cards) && Hand.same_suit?(hand.cards)
  end
  
  def self.four_of_a_kind?(hand)
 	Hand.count_ranks(hand.cards).keys.include?(4)
  end
  
  def self.full_house?(hand)
    counts = Hand.count_ranks(hand.cards)
    counts.values.include?(2) && counts.values.include?(3)
  end
  
  def self.flush?(hand)
    Hand.same_suit?(hand.cards)
  end
  
  def self.straight?(hand)
    Hand.in_a_row?(hand.cards)
  end
  
  def self.three_of_a_kind?(hand)
    Hand.count_ranks(hand.cards).values.include?(3)
  end
  
  def self.two_pair?(hand)
    Hand.count_ranks(hand.cards).values.count(2) == 2
  end
  
  def self.one_pair?(hand)
  	Hand.count_ranks(hand.cards).values.include?(2)
  end
  
  def self.high_card(hand)
    Hand.sort_ace_high(hand.cards)[-1].rank
  end
  
  def self.name_hand(hand)
  	return "Straight Flush" if Hand.straight_flush?(hand)  
    return "Four of A Kind" if Hand.four_of_a_kind?(hand)
 	return "Full House" if Hand.full_house?(hand)
    return "Flush" if Hand.flush?(hand)
    return "Straight" if Hand.straight?(hand)
    return "Three of a Kind" if Hand.three_of_a_kind?(hand)
    return "Two Pair" if Hand.two_pair?(hand)
    return "One Pair" if Hand.one_pair?(hand)
  	"High Card"    
  end
  
  def self.score(hand)
  	score = 0
  	if Hand.straight_flush?(hand)
  		score = 120
  	elsif Hand.four_of_a_kind?(hand)
  	  score = 105
  	elsif Hand.full_house?(hand)
      score = 90
    elsif Hand.flush?(hand)
      score = 75 
    elsif Hand.straight?(hand)
      score = 60
    elsif Hand.three_of_a_kind?(hand)
      score = 45
    elsif Hand.two_pair?(hand)
      score = 30
    elsif Hand.one_pair?(hand)
      score = 15
  	end
  	(score + (Hand.high_card(hand)))   
  end
  
  def <=>(other_hand)
  	Hand.score(self) <=> Hand.score(other_hand)
  end
  
  def score
   Hand.score(self)
  end
  
  def [](key)
  	self.cards[key]
  end
  
  def []=(key, value)
    self.cards[key] = value
  end
  
  def to_a
  	a = []
  	self.cards.each do |card|
  	  a << [card.rank, card.suit]	
  	end
  	a
  end
  
  def show
    puts
    
    puts
    puts " ____   ____   ____   ____   ____ "
    puts "|    | |    | |    | |    | |    |"
    self.cards.each do |card|
     print "|#{card.to_s} | " 
    end
    puts
    puts "|    | |    | |    | |    | |    |"
    puts " ----   ----   ----   ----   ---- "
  end
  
  protected
   
  private
  
  attr_reader :size
  
 
  
end