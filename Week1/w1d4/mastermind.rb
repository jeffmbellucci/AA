class MasterMind
  def initialize(colors = ['R', 'G', 'B', 'Y', 'O', 'P'], guesses_left = 5)
    @colors = colors
    @computer_choice = computer_choice
    puts @computer_choice
    @guesses_left = guesses_left
  end

  def computer_choice
    computer_choice = []
    4.times { computer_choice << @colors.sample }
    computer_choice
  end

  def same_pegs?
    @computer_choice == @user_choice
  end

  def user_choice
    puts "Please select four pegs.
      Your choices are: #{@colors.join(", ")}"
    @user_choice = STDIN.gets.chomp.split('')
  end

  def give_hints
    exact_matches = 0
    @computer_choice.each_with_index do |choice, index|
      exact_matches += 1 if choice == @user_choice[index]
    end

    near_matches = (@user_choice.select { |el| @computer_choice.include?(el) })
    .length - exact_matches

    puts "You have #{exact_matches} exact matches
    and #{near_matches} near matches.  "
    puts "You have #{@guesses_left} guesses left.  "
  end

  def choice_valid?
    @user_choice.length == 4 &&
    @user_choice.select{ |elt| @colors.include?(elt) }
  end

  def play
    while @guesses_left > 0
      user_choice
      next unless choice_valid?
      if same_pegs?
        puts "You've Won! Good Job!"
        return
      end
      @guesses_left -= 1
      give_hints
    end
    puts "Sorry, you are out of guesses"
  end

end

game = MasterMind.new
game.play
