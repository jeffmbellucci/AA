require './pieces'
require 'colorize'
require 'debugger'
class Board
  BOARD_SIZE = 8

  attr_accessor :board

  def initialize(board = nil)
    @board = board.nil? ? build_board : board
  end

  def []=(pos, piece)
    col, row = pos[0], pos[1]
    @board[row][col] = piece
  end

  def [](pos)
    col, row = pos[0], pos[1]
    # p "col #{col}"
    # p "row #{row}"
    return @board[row][col]
  end

  def other_team(team)
    team == "blue" ? "red" : "blue"
  end

  def check?(team) #change to any
    pieces(other_team(team)).any? { |piece| piece.checking?}
  end

  def checkmate?(team)
    return false if !check?(team)
    pieces(team).each do |piece|
     # debugger
      return false if piece.possible_moves.any? { |new_pos| valid_move?(piece.position, new_pos) }
    end
    true
  end

  def draw
    puts
    @board.reverse.each_with_index do |row, y|
      print " #{BOARD_SIZE - y} "
      end_of_row = "   "
      row.each_with_index do |square, x|
        print board_color("     ", x,y) if square.nil?
        print board_color(square.draw, x,y) unless square.nil?
        end_of_row << board_color("     ", x,y)
      end
      puts
      puts end_of_row

    end
    puts "     A    B    C    D    E    F    G    H  "
    puts
  end

  def get_square_of_piece(target)  #change square to location
    @board.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        return [x, y] if piece == target
      end
    end
    nil
  end

  def make_move(old_pos, new_pos)
    if valid_move?(old_pos, new_pos)
      recklessly_make_move(old_pos, new_pos)
    else
      false
    end
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  def on_board?(pos)
    pos[0].between?(0, (BOARD_SIZE - 1)) && pos[1].between?(0, (BOARD_SIZE - 1 ))
  end

  def pieces(team = nil)
    pieces = []
    @board.each do |row|
      row.each do |piece|
        next if piece.nil?
        pieces << piece if (team.nil? || piece.team == team)
      end
    end

    pieces
  end

  def positions_and_pieces
    positions_and_pieces = []
    @board.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        positions_and_pieces << [[col_index, row_index], piece] unless piece.nil?
      end
    end
    positions_and_pieces
  end

  def valid_move?(old_pos, new_pos)
    occupied?(old_pos) &&
    self[old_pos].possible_move?(new_pos) &&
    !puts_king_in_danger?(old_pos, new_pos)
  end


  def recklessly_make_move(old_pos, new_pos)
      piece = self[old_pos]
      self[old_pos] = nil
      self[new_pos] = piece
      return true
  end

  protected

  private

  def board_color(string, x,y)
    return string.on_white if (x + y) % 2 == 0
    string
  end

  def build_board
    [kings_row("blue"), pawns_row("blue"), nil_row, nil_row, nil_row, nil_row, pawns_row("red"), kings_row("red")]
  end

  def deep_dup
    grid = Array.new(8){ nil_row }
    duped_board = Board.new(grid)
    positions_and_pieces.each do |pos, piece|
      duped_piece = piece.dup
      duped_piece.board = duped_board
      duped_board[pos] = duped_piece
    end
    duped_board
  end

  def kings_row(team)
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].map { |clazz| clazz.new(team, self) }
  end

  def nil_row
    [nil]*8
  end

  def pawns_row(team)
    Array.new(8){ Pawn.new(team, self)}
  end

  def puts_king_in_danger?(old_pos, new_pos)
    team = self[old_pos].team
    imaginary_board = deep_dup
    imaginary_board.recklessly_make_move(old_pos, new_pos)
    imaginary_board.check?(team)

  end

end

