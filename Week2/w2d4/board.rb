require_relative 'piece'

require 'colorize'


	#try to make a move, then raise an error if there is a problem
	#catch the error in the game class


class Board

	GRID_SIZE = 8
	
	def initialize(grid = nil)
	@grid = (grid.nil? ? new_board : grid)
	end
	
	def self.on_board?(col, row)
		col.between?(0, GRID_SIZE-1) && row.between?(0, GRID_SIZE-1)	
	end
	
		
	def [] (col, row)
		@grid[row][col]		
	end

	def draw
		@grid.each_with_index do |row, index|
		ri = GRID_SIZE - index - 1 #Turn grid upside down for viewing (places origin at lower lefthand corner of grid)
		row = @grid[ri]# '' ''
		print " #{ri + 1} "
			row.each_with_index do |pos, ci|
				color = (ri+ci) % 2 == 0 ? :white : :black
				if occupied?(ci, ri)
					draw_piece(self[ci, ri].team, color) 	
				else
					draw_square(color)
				end
			end
			puts 	
		end
		puts "    A  B  C  D  E  F  G  H  "
	end
	
	def occupied?(col, row)
		!self[col, row].nil?
	end
		
	def position(target)
		@grid.each_with_index do |row, ri|
			row.each_with_index do |piece, ci|
				return [ci, ri] if piece == target
			end
		end
		nil
	end
	
	
	def move(position, type, move_sequence)
		piece = self[position[0], position[1]]
		piece.do_move_sequence(type, move_sequence)
		#catch the error from do_move_sequence in the player or the game
	end
	# or what if the board deals with validation by a. taking a move, asking a piece if it is valid, then moving using a private move method . . . then nobody can mess up my board.  
	
	
	def move!(old_pos, new_pos) #more validation? #can I make it so only pieces can call this since they deal with validation of the move? . . . . 
		return false if !occupied?(old_pos[0], old_pos[1])	
		self[new_pos[0], new_pos[1]] = self[old_pos[0], old_pos[1]]
		self[old_pos[0], old_pos[1]] = nil
		true
	end
	
	def capture!(col, row ) #more validation?
		return false if !occupied?(col, row)
		self[col, row] = nil
		true
	end
	
	def deep_dup
		grid = Array.new(8) {nil_row}
		dup = Board.new(grid)
		pieces.each do |piece|  
			team = piece.team
			dup[piece.position[0], piece.position[1]] = Piece.new(team, dup) 
		end
		dup
	end
	
	def pieces(team = nil) #untested
		pieces = []
		@grid.each_with_index do |row, ri|
			row.each_with_index do |piece, ci|
				next if piece.nil?
				pieces << piece unless (!team.nil? && piece.team != team)
			end
		end
		pieces		
	end
	
	protected
	
	def []= (col, row, piece)
		@grid[row][col] = piece
	end
	
	private
	
	def checkers_row(color, parity)
	  row = [Piece, nil, Piece, nil, Piece, nil, Piece, nil] 
	  row << row.shift if parity == :even
	  row.map { |piece| piece.new(color, self) unless piece.nil?} 
	end
	
	def draw_piece(team, color)  #TODO: make pretty
		piece = (team == :red ? " o ".red  : " o ".white)

		print color == :white ? piece.on_white : piece.on_black
	end
	
	def draw_square(color)#TODO: make pretty
		print color == :white ? "   ".on_white : "   ".on_black 
	end
		
	def new_board
		grid = [checkers_row(:white, :even), checkers_row(:white, :odd),
		checkers_row(:white, :even), nil_row, nil_row, checkers_row(:red, :odd), 
		checkers_row(:red, :even ), checkers_row(:red, :odd)]
	end

	def nil_row
		Array.new(8){nil}
	end
	
	def position_of(target_piece) #untested
		@grid.each_with_index do |row, ri|
			row.each_with_index do |piece, ci|
				return [ci, ri] if piece == target_piece
			end
		end
		nil
	end
	
	
end