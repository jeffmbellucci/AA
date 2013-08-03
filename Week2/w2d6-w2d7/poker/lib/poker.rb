require './yes_or_no.rb'
require './player.rb'
require './hand.rb'
require './deck.rb'

class Poker
	def initialize(num_players = 2)
		@num_players = num_players
		@players = Hash.new()
		@deck = nil
		@pot = 0
	end
	
	include YesOrNo
	
	def play
	  start_game
	  until game_done?
	    start_round
	    get_bets
	    unless all_but_one_folds?
	      do_trades
	      get_bets
	    end
	    end_round    
	  end
	end
	
	private
	
	def end_round
	  announce_winner
	  pay_winner
	end
	
	def winner
	   #winner = in_players[0] #only needed if we are actually going to do something different
	   winner = in_players.each.sort{ |p1, p2| p1.hand.score <=> p2.hand.score }[0]
	end
	
	def announce_winner
	  puts "#{winner.name} wins"
	end
	
	def pay_winner
	  winner.take_pot(@pot)
	  @pot = 0
	end
	
	def ask_if_done
	    answer = ""
		until(yes_or_no?(answer))
		  puts "Would you like to play another round?"
		  answer = gets.chomp
		end
		yes?(answer)
	end
	
	def game_done?
		return false if @deck.nil?
		!ask_if_done
	end
	
	def start_round
	  @deck = Deck.new
	  @deck.shuffle
	  everyone_in
	  deal
	end
	
	def everyone_in
	 @players.each { |k, v| @players[k] = true }
	end
	
	def deal
	 players.each do |player|
	    player.hand = Hand.new(@deck.deal(5))
	  end
	end
	
	def start_game
	  @num_players.times do |num|
	  	@players[Player.new("Player_#{num}")] = true
	  end
	end
	
	def get_bets
		@bets = Hash.new(0)
		first_round = true

		while first_round || !betting_done?
		  in_players.each do |player|
		    if first_round
		      next if all_but_one_folds?
		    else
		      next if betting_done?
		    end
		  	get_bet(player)
		  end
		  first_round = false
		end
	end
	
	def betting_done?
	  @bets.values.uniq.count == 1 || all_but_one_folds?
	end
	
	def all_but_one_folds?
	  @players.values.count(false) == 1
	end

	def get_bet(player)
	  current = @bets[player]
	  highest_bet = @bets.count == 0 ? 0 : @bets.values.max
	  needed = highest_bet - current
	  
	  bet = player.bet(current, needed)
	  @bets[player] += bet 
	  @pot += bet
	  @players[player] = false if bet == 0
	end
	
	def in_players
	  @players.select{ |key, value| value }.keys
	end
	
	def players
	   @players.keys
	end
	
	def do_trades
	  in_players.each { |player| player.trade_cards(@deck) }
	end
	
end

game = Poker.new
game.play