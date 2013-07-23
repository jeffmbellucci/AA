class Tile

  attr_accessor :bomb, :flagged, :bombcount, :revealed, :exploded

  def initialize(board)
    @board = board
    @bomb = false
    @flagged = false
    @bombcount = nil
    @revealed = false
    @exploded = false
  end

  def reveal
    #TODO: double check that bombcount has been counted
    return if @revealed || @bomb
    @revealed = true
    if @bombcount == 0
      @board.neighbors(self).each do |neighbor|
        neighbor.reveal
      end
    end
  end

  def toggle_flag
    @flagged = !@flagged
  end

  def display
    if @exploded
      return " X "
    elsif @flagged
      return " F "
    elsif @revealed
      return " #{@bombcount.to_s} " if @bombcount > 0
      return "   "
    else #not revealed or flagged
      return " * "
    end
  end

  def set_bombcount
    @bombcount = 0
    neighbors = @board.neighbors(self)
    neighbors.each do |tile|
      @bombcount += 1 if tile.bomb == true
    end
  end

end # END TILE
