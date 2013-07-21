class SmallPlayer
  def initialize
    @candidates = ["cat" , "cats", "hat", "bat"]
    @board = ["c", nil, nil]
  end

  def update_candidates
    p @candidates
    @candidates.select!{ |word| word.length == @board.size }
    @board.each_with_index do |letter, index|
      next if letter.nil?
      @candidates.select!{ |word| word[index] == letter }
    end
    p @candidates
  end
end

a = SmallPlayer.new

a.update_candidates