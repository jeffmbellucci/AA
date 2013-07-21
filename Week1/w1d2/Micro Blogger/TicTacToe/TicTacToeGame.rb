class TicTacToe

end

class Board

	def initialize
		@board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
	end
	
	def to_s
		@board.each_with_index do |row, row_index|
			puts "\n-----"  if row_index > 0
			row.each_with_index do |elt, column_index| 
				print "|" if column_index > 0
				case elt
				when :x
					print "X"
				when :o
					print "O"
				else
					print " "				
				end
			end
		end
	end
	
	def rows
		@board
	end
	
	def columns
		columns = [[][][]]
		@board.each_with_index do |row, i|
			row.each_with_index do |elt, j|
				columns[j][i] = elt
			end
		end
	end
	
	def diags
	
	end
	
	def won?
		!self.winner.nil?
	end
	
	def winner
		( self.rows + self.columns + self.diags ).each do |arr|
			return "X" if arr.uniq = [:x] 
			return "Y" if arr.uniq = [:y]
		end
		nil
	end
	
	def tie?
		if !self.won? 
			@board.each do |row|
				row.each do |elt|
					return false if elt.nil?
				end
			end
		else
			return false
		end
		true
	end
	
end

class Player
end

a = Board.new
a.show_board