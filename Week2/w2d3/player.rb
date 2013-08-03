class Player
  def initialize(name, board)
    @name = name.nil? ? get_name : name
    @board = board
  end

  def move
    get_move
  end


  private

  def make_move(old_pos, new_pos)
    @board.make_move(old_pos, new_pos)#make_move returns false if the move is invalid (true otherwise)
  end

  def get_move
    done = false
    until done
      puts "#{@name}, make your move"
      positions = gets.chomp.gsub(/\s/, "").split("to")
      old_pos, new_pos = positions.map{ |positions| positions.split("") }
      done = make_move(convert_to_ugly(old_pos), convert_to_ugly(new_pos))
    end
    #TODO: timer
  end

  def convert_to_ugly(pos)
    conversion = {"a" => 0, "b" => 1, "c" => 2, "d" => 3,  "e" => 4, "f" => 5, "g" =>6, "h" => 7}
    p [[conversion[pos[0]], (pos[1].to_i - 1)]]
   [[conversion[pos[0]], (pos[1].to_i - 1)]]
  end

end

