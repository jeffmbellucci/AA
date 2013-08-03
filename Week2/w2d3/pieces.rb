require 'colorize'

def add_vectors(step, pos)
  [pos[0] + step[0], pos[1] + step[1]]
end


module Slideable
  def possible_moves
    possible_moves = []
    directions.each do |step|
      candidate = self.position.dup
      8.times do
        candidate = add_vectors(step, candidate)
        break unless self.board.on_board?(candidate)
        occupied = self.board.occupied?(candidate)
        break if (occupied && self.board[candidate].team == self.team)
        possible_moves << candidate
        break if occupied
      end
    end
    possible_moves
  end
end

module Steppable
  def possible_moves
    possible_moves = []
    directions.each do |step|
      candidate = add_vectors(step, self.position)
      next unless self.board.on_board?(candidate)
      next if (self.board.occupied?(candidate) && self.board[candidate].team == self.team)
      possible_moves << candidate
    end
    possible_moves
  end
end

class Piece
  attr_accessor :board
  attr_reader :team, :directions
  def initialize(team, board)
    @team = team
    @board = board
  end

  def draw
      return representation.red if team == "red"  #change to :black and :white
      return representation.blue if team == "blue"
      representation
  end

  def possible_move?(pos)
    possible_moves.include?(pos)
  end

  def position
    self.board.get_square_of_piece(self)
  end

  def checking?
    possible_moves.any? { |square| self.board[square].is_a?(King) }
  end

  def representation
    raise NotImplementedError.new("Subclasses of Piece should implement 'representation' method for use by Board.")
  end

  def possible_moves
    raise NotImplementedError.new("Subclasses of Piece should implement 'possible_moves' method for use by Board.")
  end
end


class King < Piece
  def initialize(team, board)
    super(team, board)
  end

  def representation
    "  \xE2\x99\x94  " # white chess king
  end

  private

  def directions
    [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]
  end

  include Steppable
end

class Queen < Piece
  def initialize(team, board)
    super(team, board)
  end

  def representation
     "  \xE2\x99\x95  " # white chess queen
  end

  private

  def directions
    [[-1,1], [1,1], [1, -1], [-1,-1], [0,1], [1,0], [0, -1], [-1,0]]
  end

  include Slideable

end

class Rook < Piece
  def initialize(team, board)
    super(team, board)
  end

  def representation
    "  \xE2\x99\x96  " #white chess rook
  end

  private

  def directions
    [[0,1], [1,0], [0, -1], [-1,0]]
  end

  include Slideable

end

class Bishop < Piece
  def initialize(team, board)
    super(team, board)
  end

  def representation
     "  \xE2\x99\x97  " #white chess bishop
  end

  private

  def directions
    [[-1,1], [1,1], [1, -1], [-1,-1]]
  end

  include Slideable

end

class Knight < Piece
  def initialize(team, board)
    super(team, board)
  end

  def representation
     "  \xE2\x99\x98  " #white chess knight
  end

  private

  def directions
    [[-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [-1, -2], [1, -2]]
  end

  include Steppable

end

class Pawn < Piece
  #todo -- deal with leveling up
  def initialize(team, board)
    super(team, board)
  end

  def initial_move?
    #define this -- say false for now
    true
  end

  def representation
    "  \xE2\x99\x99  " #white chess pawn
  end

  # def possible_moves
  #   possible_moves = []
  #   directions.each do |step|
  #     candidate = add_vectors(step, self.position)
  #     next unless self.board.on_board?(candidate)
  #     next unless valid_step?(step, position) || valid_attack?(step, position)
  #     possible_moves << candidate
  #   end
  #
  #   possible_moves
  # end

  def possible_moves
    possible_step_moves + possible_attack_moves
  end

  private

  def directions
    directions = [[0, 1], [0, 2], [-1, 1], [1, 1]]
    if team == 0
      return directions.map { |x, y| [x, -1*y] }
    end
    directions
  end

  def possible_step_moves
     step_moves = (team == 0 ? [[0, -1], [0, -2]] :[[0, 1], [0, 2]]) if initial_move?
     step_moves = (team == 0 ? [[0, -1]] :[[0, 1]]) if !initial_move?
     step_moves.map { |step| add_vectors(step, self.position) }
       .select { |psm| self.board.on_board?(psm) && !self.board.occupied?(psm) }
  end

  def possible_attack_moves
    attack_moves = (team == 0 ? [[-1, -1], [1, -1]] : [[-1, 1], [1, 1]])
    attack_moves.map{ |attack| add_vectors(attack, self.position) }
    .select { |pam| self.board.occupied?(pam) && !self.board[pam].team == self.team }
  end

  def valid_attack?(step, pos)
      attacks = (team == 0 ? [[-1, -1], [1, -1]] : [[-1, 1], [1, 1]])
      candidate = add_vectors(step, pos)
      occupied = self.board.occupied?(candidate)
      return false if !attacks.include?(step)
      return false if !occupied
      return false if self.board[candidate].team == self.team
      true
  end

end
