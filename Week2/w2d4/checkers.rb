require_relative 'board'
require_relative 'player'

class Checkers #english rules
		
	def play
		start_game
		active_player, active_team = @player1, :red
		board.draw
		until done?(active_team)
			active_player.make_move(@board, active_team)		
			board.draw
			
			active_player = @player1 == active_player ? @player2 : @player1
			active_team = active_team == :red ? :white : :red 
		end
		closing_remarks
	end
	
	private
	
	def board
		@board
	end
	
	def start_game
		@board = Board.new()
		@player1 = Player.new('Silly')
		@player2 = Player.new('Pilly')
	end
	
	def done?(active_team)
		return true if  all_dead?(:red) || all_dead?(:white)
		return true if stuck?(active_team)
		false
	end
	
	def all_dead?(team)
		board.pieces(team).empty?
	end
	
	def stuck?(team)
		board.pieces(team).each do |piece|
			return false if !piece.possible_moves.empty?
		end
		true
	end
	
	def closing_remarks
		puts "say something about who won and who lost or whatever" 
	end
end

def do_game
	a = Checkers.new
	a.play
end
do_game

def dotest
	a = Board.new
	a.draw

	# p a.occupied?(0,1)
	# p a[1, 2].team
	#p a[1, 2].possible_moves

	a[1, 2].do_move_sequence(:slide, [[2, 3]])
	a.draw

	a[2, 3].do_move_sequence(:slide, [[1, 4]])
	# 
	a.draw
	 a[0, 5].do_move_sequence(:jump, [[2, 3], [4,1]])
	 a.draw
	# a.draw

	# p a[0,5].team
	# p a[0,5].possible_moves



	#english rules
			#men can capture forward
			#men can only move one move at a time,
			#but can capture multiple moves (and can switch directions while doing so)
			#kings can move/capture forward and backwards
		
end
