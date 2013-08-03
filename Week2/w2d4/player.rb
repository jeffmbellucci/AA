class CoordinateParseError < RuntimeError
	
end

class Player

	def initialize(name = nil)
		@name = name.nil? ?get_name : name
	end
	
	def make_move(board, team)
		begin
		piece, slide, moves = get_move
		unless board[piece[0], piece[1]].team == team
			raise InvalidMoveError.new("You can only move #{team.to_s} pieces")
		end
		board.move(piece, slide, moves)
		rescue InvalidMoveError => e
			puts e.message
			retry
		end
	end
	
	private
	
	def get_move
		begin
		puts "#{@name}, Make your move.  "
		move = parse_move(gets.chomp)

		rescue CoordinateParseError => e
			puts e.message
			retry
		end
		move
	end
	
	def parse_move(string)
		begin #improve validation, #account for all possible mistakes in user input with CoordinateParseError
			piece, moves = string.downcase.split("to")
		
			piece = piece.gsub(/\s/, "").split("")
			moves = moves.gsub(/\s/, "").split(",")
			piece = uglify(piece)
			moves = moves.map{|move| uglify(move)}
		rescue => e
			raise CoordinateParseError.new("Please write your moves in the form 'b3 to c4' or 'c2 to e4, g6, e8'")
			retry
		end
		# if piece.nil? || moves.count < 1
# 			raise CoordinateParseError.new("please put your move in the format 'startpoint to nextpoint, nextpoint, nextpoint'")
# 		end
		
		[piece, type(piece, moves), moves] #TODO, parse :slide or :jump
	end
	
	def type(piece, moves)
		(moves[0][1] - piece[1]).abs > 1 ? :jump : :slide
	end

	def uglify(pos)
		conversion = {"a" => 0, "b" => 1, "c" => 2, "d" => 3,  "e" => 4, "f" =>
		5, "g" =>6, "h" => 7}
   		[conversion[pos[0].downcase], (pos[1].to_i - 1)]
	end
	
	def get_name
		"Write get_name function in Player"
	end
end