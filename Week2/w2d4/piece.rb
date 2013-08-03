def add_vectors(a1, a2) #only works on 2 X 2
	[ a1[0] + a2[0], a1[1] + a2[1] ]
end

class InvalidMoveError < ArgumentError
	def initialize(msg = "That move is invalid (the move was not made)")
		super
	end
end


class Piece
	attr_reader :team
	
	def initialize(team, board)
		@team , @board, @king = team, board, false
	end
	
	def position
		@board.position(self)
	end
		
	def promote
		@king = true
	end
    
    def possible_moves
		possible_slides + possible_jumps
	end

	def do_move_sequence(type, seq)
		test_move_sequence(type, seq) 
		recklessly_do_move_sequence(type, seq)
	end
	
	protected
	
	def recklessly_do_move_sequence(type, seq)
		if type == :slide
			perform_single_slide(seq[0][0], seq[0][1]) if type == :slide
		else
			seq.each { |move| perform_single_jump(move[0], move[1])}
		end
	end
	

	private

		
	def correct_direction(deltas)
		deltas.map { |x, y| [x, y*team_multiplier]  }
	end
	
	def deltas 
		correct_direction([[-1, 1],[1, 1]])
	end
	
	def perform_single_slide(col, row)
		validate_slide(col, row)
		@board.move!(self.position, [col, row])
	end
	
	def perform_single_jump(col, row)
		validate_jump(col, row)
		position = self.position
		captured_col = position[0] + (col - position[0])/2
		captured_row = position[1] + (row - position[1])/2
		@board.capture!(captured_col, captured_row)
		@board.move!(position, [col, row])
	end	
	
	def possible_jumps
		possible_jumps = []
		candidate_victims = deltas.map{ |d| add_vectors(self.position, d) }
		candidates = []
		deltas.each_with_index do |d, i| 
			candidates << add_vectors(candidate_victims[i], d)
		end
		candidates.each_with_index do |candidate, i|
			victim = candidate_victims[i]
			next unless Board.on_board?(candidate[0], candidate[1])
			next unless @board.occupied?(victim[0], victim[1])
			next unless @board[victim[0], victim[1]].team != self.team
			possible_jumps << candidate
		end
		possible_jumps
	end
	
	def possible_slides
		candidates = deltas.map{ |d| add_vectors(self.position, d) }
		candidates.select do |candidate| 
			Board.on_board?(candidate[0], candidate[1]) && 			
			!@board.occupied?(candidate[0], candidate[1])
		end
	end
	

	
	def team_multiplier
		return -1 if self.team == :red
		1
	end
	
	def test_move_sequence(type, seq)
		imaginary_board = @board.deep_dup
		imaginary_me = imaginary_board[self.position[0], self.position[1]]
		imaginary_me.recklessly_do_move_sequence(type, seq)
	end
	
	def validate_jump(col, row)
		unless possible_jumps.include?([col, row])
			raise InvalidMoveError.new("Invalid Move")
		end
	end
	
	def validate_slide(col, row)
		unless possible_slides.include?([col, row])
			raise InvalidMoveError.new("Invalid Move")
		end
	end
	

end