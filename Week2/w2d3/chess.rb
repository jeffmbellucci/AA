require './board'
require './player'
require 'debugger'
class Chess
  def initialize

  end

  def play
    start_game
    @board.draw
    active_player = @player1
    until done?
      active_player.move
      active_player = other_player(active_player)
    end
    closing_remarks
  end

  private

  attr_accessor :board, :player1, :player2

  def start_game
    @board = Board.new
    @player1 = Player.new("P1", @board)
    @player2 = Player.new("P2", @board)
  end

  def done?
    board.checkmate?(@player1) || board.checkmate?(@player2)
  end

  def other_player(player)
    player == @player1 ? @player2 : @player1
  end

  def closing_remarks
    #say winner or whatever
    #ask about wanting to play another game
  end
end




a = Chess.new

a.play




def run_checkmate
c = Chess.new
b = Board.new()
b.draw
puts b[[5, 1]].team == 1 ? "team blue": "team red"
b.recklessly_make_move([5, 1],[5, 2])
puts b[[4, 6]].team == 1 ? "team blue": "team red"
b.recklessly_make_move([4, 6],[4, 4])
puts b[[6, 1]].team == 1 ? "team blue": "team red"
b.recklessly_make_move([6, 1],[6, 3])
puts b[[3, 7]].team == 1 ? "team blue": "team red"
b.recklessly_make_move([3, 7],[7, 3])

#
# b[[5, 2]] = b[[5, 1]]
# b[[4, 4]] = b[[4, 6]]
# b[[6, 3]] = b[[6, 1]]
# b[[7, 3]] = b[[3, 7]]


b.draw

pawn = b[[0, 1]]
p pawn.possible_moves

# b.check?(1)
puts "check: #{b.check?(1)}"
puts "mate: #{b.checkmate?(1)}"
end

# "take pieces" -- we already do this,we just have to make note of when it happens (so we can imagine it in checkmate)

# in_check?

#make duplicate board etc. . . (make an imagine(board)function that returns "check = true or check = false")