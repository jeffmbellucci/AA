require './tiles.rb'

class Board
  attr_accessor :board

  def initialize(sidelength, mines)
    @sidelength = sidelength
    @mines = mines
    self.build
  end

  def neighbors(tile)
    neighbors = []
    relatives = [
      [-1, 1], [0, 1], [1, 1],
      [-1, 0],         [1, 0],
      [-1, -1], [0, -1], [1, -1]
    ]

    tile_x, tile_y = get_tile_position(tile)
    relatives.each do |x, y|
      new_xy = [tile_x + x, tile_y + y]
      neighbors << get_tile(new_xy) if valid_position?(new_xy)
    end

    neighbors
  end

  def valid_position?(pos)
    pos[0] >= 0 && pos[0] < @sidelength && pos[1] >= 0 && pos[1] < @sidelength
  end

  def get_tile(pos)
    @board[pos[1]][pos[0]] #returns tile
  end

  def get_tile_position(tile)
    board.each_with_index do |row, index|
      row.each_with_index do |col, index2|
        if tile == board[index][index2]
          return [index, index2]
        end
      end
    end

    nil
  end

  def build
    self.build_blank
    self.set_mines
    self.set_bombcounts
  end

  def build_blank
    @board = []
    @sidelength.times do
      row = []
      @sidelength.times do
        row << Tile.new(self)
      end
      @board << row
    end
    @board
  end

  def set_mines
    mine_spots = self.tiles.sample(@mines)
    mine_spots.each do |tile|
      tile.bomb = true
    end
  end

  def display
    self.tiles.each_with_index do |tile, index|
      print tile.display
      if index % @sidelength == @sidelength - 1
        puts
      end
    end
    puts
  end

  def tiles
    @board.flatten
  end

  def set_bombcounts
    self.tiles.each do |tile|
      tile.set_bombcount
    end
  end

  def flag(pos)
    get_tile(pos).toggle_flag
  end

  def step_on(pos)
    tile = get_tile(pos)

    if tile.bomb == true
      tile.exploded = true
    else
      tile.reveal
    end

  end

  def won?
   return false if self.lost?
   self.tiles.all? { |tile| tile.revealed == true || tile.bomb == true }
  end

  def lost?
    self.tiles.any? { |tile|  tile.exploded == true }
  end

end
