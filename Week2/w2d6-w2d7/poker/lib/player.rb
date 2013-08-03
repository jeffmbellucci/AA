require './yes_or_no.rb'

class Player

    attr_accessor :hand, :name
    
	def initialize(name = get_name, wallet = 100)
		@name, @wallet = name, wallet
	end
	
	def bet(current, required)
	  look_at_hand
	  begin
	    if required == 0
	  	  puts "#{self.name}, how much would you like to bet? (enter '0' to fold)"
	    else 
	      puts "#{self.name}, how much would you like add to the pot? (you may enter '0' to fold).  You must add at least #{required} dollars stay in this round"
	    end
	  	  bet = gets.chomp.to_i #some additional validation might be nice
	  	if bet > @wallet
	  	  raise "you don't have enough money to bet $#{bet}" 
	  	elsif !bet == 0 && bet < required
	  	  raise "you must add at least #{required} dollars to stay in this round"
	  	end
	  rescue => e
	    puts e
	  	retry	  	  
	  end
	  bet
	end
	
	def take_pot(pot)
	  @wallet += pot
	end
	
	def look_at_hand
	  hand.show
	end
	
	def trade_cards(deck) #TODO: validation
	  look_at_hand
	  puts "Which cards would you like to trade (1 through 5; up to three cards)for example '4, 5' (enter 0 to not trade any)"
	  trades = gets.chomp.gsub(/\s/, '').split(",").map(&:to_i)
	  if !trades[0] == 0
	    trades.each do |num|
	      deck.recieve(hand[num - 1])
	      hand[num-1] = deck.deal(1)[0]
	    end
	  end
	end
	
	
	include YesOrNo
	
	private
	
	def get_name
		#TODO write this code
		"Tell Ruth to Write the get_name function for the player class"
	end
	

end