class Board
  attr_reader :rows
  def initialize
    @rows = []
    3.times { @rows << [nil,nil,nil] }


  end

  def cols
    cols = []
    3.times { cols << [nil, nil, nil] }
    @rows.each_with_index do |row, i|
      row.each_with_index do |el, j|
        cols[j][i] = el
      end
    end
  end

  def diagonals
    [[@rows[0][0], @rows[1][1], @rows[2][2]], [@rows[0][2], @rows[1][1], @rows[2][0]]]
  end

  def display
    self.rows.each_with_index do |row, i|
      row.each_with_index do |ele, j|
        if ele.nil?
          print " "
        else
          print ele
        end
        if j < 2
          print "|"
        else
          puts
        end
      end
      puts "------" if i < 2
    end
  end

  def possible_moves
    possible_moves = []
    @rows.each_with_index do |row, i|
      row.each_with_index do |el, j|
        possible_moves << [i, j] if el.nil?
      end
    end
    possible_moves
  end


  def won?
    !self.winner.nil?
  end


  def winner
    (self.rows + self.cols + self.diagonals).each do |triple|
      return :o if triple == [:o, :o, :o]
      return :x if triple == [:x, :x, :x]
    end
    nil
  end

  def place_move(pos, mark)
    x, y = pos
    rows[x][y] = mark
  end

  def game_over?
    self.won? || self.tie?
  end

  def tie?
    @rows.each do |row|
      row.each do |el|
        return false if el.nil?
      end
    end
    true
  end

end


class TicTacToe
  def initialize
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
    @board = Board.new
    @current_player = @computer
  end

  def play
    until @board.game_over?
      @board.place_move(@current_player.decide_move(@board), @current_player.mark)
      self.switch_players


    end

    @board.display
    if @board.won?
      puts @board.winner.to_s.upcase + " Won!"
    else
      puts "Tie!"
    end

  end

  def switch_players
    if @current_player == @computer
      @current_player = @human
    else
      @current_player = @computer
    end
  end

end

class ComputerPlayer
  attr_accessor :mark
  def initialize
    @mark = :o
  end

  def decide_move(board)
    board.possible_moves.sample
  end
end

class HumanPlayer
  attr_accessor :mark
  def initialize
    @mark = :x
  end
  def decide_move(board)
    board.display
    need_move = true
    move = nil
    while need_move
      puts "make a move (x, y)"
      move = gets.chomp.split(", ").map(&:to_i)
      need_move = false if board.possible_moves.include?(move)
    end
    move
  end
end


game = TicTacToe.new
game.play