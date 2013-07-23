require './board.rb'
require './player.rb'

class Minesweeper

  attr_accessor :game_board

  def initialize(sidelength = 9, mines = 10)
    @game_board = Board.new(sidelength, mines)
    @player = Player.new(self)

  end

  def play
    @game_board.display

    until done?
      @player.make_move
      @game_board.display
    end
    closing_comments
  end

  def closing_comments
    if @game_board.lost?
      puts "You died.  Good thing this is only a game"
    else
      puts "You crossed the mine field!  Good Job #{@player.name}!"
    end
    #ask if they want to play again
  end

  def done?
    @game_board.won? || @game_board.lost?
  end

  def valid_position?(coords)
    @game_board.valid_position?(coords)
  end

end




game = Minesweeper.new(9, 2)
game.play

#test_tile = board.board[1][1]
#test_tile2 = board.board[0][0]
#test_tile2.bomb = true
#board.set_bombcounts
#puts board.tiles.each {|tile| puts tile.display}
#board.display
#test_tile.reveal
#board.display
#puts board.get_tile_position(test_tile)
#puts board.neighbors(test_tile)
