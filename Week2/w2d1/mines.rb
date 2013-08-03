require './board.rb'
require './player.rb'
require 'yaml'

class Minesweeper

  attr_accessor :board

  def initialize
  	@playing = false
  	@name = ""
  	main_menu
  end
  
  def main_menu#TODO add validation
	draw_menu
	input = gets.chomp.downcase
	case input
	when 'n'
		start_game
	when 'r'
		start_game if @playing == false
		play if @playing == true
	when 's'
		@playing = false
		save
		puts "Game Saved"
	when 'l'
		load
	when 'q'
		puts "Goodbye"
	end
  end
  

  
  def valid_position?(coords)
    @board.valid_position?(coords)
  end
  
  private
  
  def start_game(sidelength = 9, mines = 10)
  	@name = get_name
	@board = Board.new(sidelength, mines)
    @player = Player.new(self)
    @playing = true
    play
  end
  
  def get_name #TODO: Validate
  	puts "Please name this game"
  	gets.chomp
  end
  
  def play
    until done?
      @player.make_move
    end
    @board.display # @player.make_move takes care of this in the play loop
    closing_comments
  end
  
    def save #TODO:validation
  	name = self.name.gsub(' ', '_')
	file = File.new("#{name}.yaml", "w")
  	file.write(YAML.dump(self))
  	file.close
  end
  
#  def directory_exists?
#   	File.directory?(saved_games)
#  end
  
  def load #TODO: validation
  	puts "What game do you want to load?"
  	saved_game = gets.chomp.gsub(' ', '_')
  	saved_game = "#{saved_game}.yaml"
  	load_game(saved_game)
  end
  
  def load_game(saved_game)
  	game = YAML.load(File.read(saved_game))
  	game.main_menu
  end
  
  def draw_menu
  	puts "#{self.name}"
    puts "         Main Menu          "
  	puts "----------------------------"
  	puts "n . . . . . . . . .new game "
  	puts "r . . . . . . . . . .resume "
  	puts "s . . . . . . . . . . .save "
  	puts "l . . . . . load saved game "
  	puts "q . . . . . . . . . . .quit "
  end

  def closing_comments
    if @board.lost?
      puts "You died.  Good thing this is only a game"
    else
      puts "You crossed the mine field!  Good Job #{@player.name}!"
    end
    #ask if they want to play again
  end

  def done?
    @board.won? || @board.lost?
  end

end




game = Minesweeper.new()

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
