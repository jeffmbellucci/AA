
class Player
  attr_reader :name

  def initialize(game)
    @game = game
    @name = get_name
  end

  def make_move
  	@game.board.display
    coords = get_coords
    @game.pause if coords == 'pause'
    action = get_action
    @game.pause if action == 'pause'
    if action == "r"
      step_on(coords)
    else
      flag(coords)
    end
  end
  
  def get_name #built out like this in case we want validation in the future
    have_name = false
    until have_name
      puts "Player, What is your name?"
      name = gets.chomp.capitalize
      have_name = true
    end

    name
  end

  def get_action
    have_action = false
    until have_action
      puts "#{@name}, please enter an action (r)eveal, (f)lag"
      action = gets.chomp.downcase
      if pause?(action) 
      	@game.main_menu 
      	return 'pause' 
      end
      have_action = true if ['r', 'f'].include?(action)
    end
    action
  end

  def pause?(input)
  	input.downcase == "p"
  end
  
  def get_coords
    have_coords = false

    until have_coords
      puts "#{@name}, please select a tile (x, y)"
      input = gets.chomp
      if pause?(input) 
      	@game.main_menu 
      	return 'pause' 
      end
      coords = input.split(",").map { |coordinate| coordinate.strip.to_i }
      #TODO: fix that this returns 0,0 for coords that are not numbers.
      have_coords = @game.valid_position?(coords)
    end

    coords
  end

  def step_on(pos)
    @game.board.step_on(pos)
  end

  def flag(pos)
    @game.board.flag(pos)
  end

end