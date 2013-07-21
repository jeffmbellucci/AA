
class Hangman
  def initialize(opts = {})
    defaults = {
      player1: HumanPlayer.new,
      player2: ComputerPlayer.new,
      guesses: 3
    }
    opts = defaults.merge(opts)

    @Guesser = opts[:player1]
    @Judge = opts[:player2]
    @guesses = opts[:guesses]

    @blank = " _"
  end

  def display_board
    guesser_display_board
    judge_display_board
  end

  def new_board(length)
    board = []
    length.times {board << nil }
    board
  end

  def over?
    won? || @guesses == 0
  end

  def play

    @board = new_board(@Judge.word_length)

    until over?

      display_board

      letter = @Guesser.guess_letter.downcase
      if letter == nil
        puts "I give up. Next time, pick a less obscure word. "
        break
      end
      if @Judge.correct_guess?(letter)
        update_board(@Judge.board_update(letter))
      else
          @guesses -= 1
      end

    end
    closing_remarks
  end

  def update_board(board_update)
    board_update.each_with_index do |spot, index|
      @board[index] = spot unless spot.nil?
    end
  end

  def won?
    !@board.include?(nil)
  end

  private

  def closing_remarks
    puts "The Guesser Won" if won?
    puts "The Guesser Lost" if !won?
  end

  def guesser_display_board
    @Guesser.see_board(@board)
    puts "Secret word:" + @board.map{ |spot| spot.nil? ? @blank : spot }.join("")
  end

  def judge_display_board
    @Judge.see_board(@board)
  end

end


class ComputerPlayer

  def initialize
    @dictionary = load_dictionary
    @secret_word = new_secret_word
    @guessed_letters = []
    @candidates = @dictionary.dup
  end

  def board_update(letter)
    @secret_word.map { |el| letter == el ? el : nil }
  end

  def correct_guess?(letter)
    @secret_word.include?(letter)
  end

  def guess_letter
    update_candidates
    letter_hash = candidates_frequency_analysis
    @guessed_letters.each { |letter| letter_hash.delete(letter) }
    guess = letter_hash.max_by{|k, v| v }
    if guess.empty?
      return nil
    end
    @guessed_letters << guess[0]
    guess[0]
  end

  def see_board(board)
    @board = board
  end

  def word_length
    @secret_word.count
  end

  private

  def candidates_frequency_analysis
    letter_counts = Hash.new{0}
    @candidates.each do |word|
      word.chars { |letter| letter_counts[letter] += 1 }
    end
    letter_counts
  end

  def load_dictionary
    File.readlines("dictionary.txt").map(&:chomp)
  end

  def new_secret_word
    @dictionary.sample.split('')
  end

  def update_candidates
    @candidates.select!{ |word| word.length == @board.size }
    @board.each_with_index do |letter, index|
      next if letter.nil?
      @candidates.select!{ |word| word[index] == letter }
    end
  end

end

class HumanPlayer

  def board_update(letter)
    board_update = []
    spots = get_positions(letter)

    @word_length.times do |index|
      spots.include?(index) ? board_update << letter : board_update << nil
    end

    board_update
  end

  def correct_guess?(letter)
    puts "Computer guess \"#{letter}\": Correct? (Y/N)"
    STDIN.gets.chomp.downcase == "y" ? true : false
  end

  def get_positions(letter)
    need_positions = true
    while need_positions
      puts "Enter comma-seperated positions (0 through #{@word_length - 1})
      of #{letter}"
      spots = STDIN.gets.chomp.gsub(' ','').split(',').map(&:to_i)
      need_positions = !valid?(spots)
    end

    spots
  end

  def guess_letter
    puts "Guess a letter! "
    STDIN.gets.chomp[0]
  end

  def see_board(board)
    @board = board
  end

  def valid?(spots)
    spots.each do |spot|
      return false if @board[spot] != nil
      return false if spot >= @board.count
    end
    true
  end

  def word_length
    puts "How long is your secret word? "
    @word_length = STDIN.gets.chomp.to_i
  end

end

game = Hangman.new(player1: ComputerPlayer.new, player2: HumanPlayer.new)

game.play