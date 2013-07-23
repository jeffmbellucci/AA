
class Player
  attr_reader :name

  def initialize(game, name = "goose")
    @game = game
    @name = name
  end

  def make_move
    coordinates = get_coords
    action = get_action
    if action == "r"
      step_on(coordinates)
    else
      flag(coordinates)
    end
  end

  def get_action
    #TODO: validate
    puts "#{@name}, (f)lag or (r)eveal ?"
    action = gets.chomp
  end

  def get_coords
    have_coords = false

    until have_coords
      puts "#{@name}, please select a tile (x, y)"
      coords = gets.chomp.split(",").map { |coordinate| coordinate.strip.to_i }
      have_coords = @game.valid_position?(coords)
    end

    coords
  end

  def step_on(pos)
    @game.game_board.step_on(pos) ##making..
  end

  def flag(pos)
    @game.game_board.flag(pos) ## making..
  end

end