class InvalidMoveError < RuntimeError
end

class Hanoi

  attr_reader :board
  def initialize
    @board = [[0, 1, 2], [], []]
  end

  def play
    begin
      until won?
        p board
        puts "player, please enter your move"
        m = gets.chomp.gsub(/\s/, "").split(",")
        move(m[0], m[1])
      end
    rescue InvalidMoveError => e
      puts e
      retry
    end

  end

  def move(from, to)
    raise InvalidMoveError.new("There is no such tower") unless from.between?(0,2) && to.between?(0,2)
    raise InvalidMoveError.new("Tower #{from} is empty") if board[from] == []
    raise InvalidMoveError.new("That is an illegal move") unless board[to] == [] || board[from][0] < board[to][0]
    board[to].unshift(board[from].shift)
  end

  def won?
    board == [[], [], [0, 1, 2]]
  end

end