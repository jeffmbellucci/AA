def number_guessing_game(max = 100)
  secret_number = (1..max).to_a.sample
  won = false
  guesses = 0

  puts "Guess a number between 1 and #{max}."
  until won
    guess = gets.chomp.to_i
    guesses += 1
    if secret_number == guess
      won = true
      puts "You Win! You guessed the secret number in #{guesses} guesses!"
    else
      hint = high_low(secret_number, guess)
      puts "No, that is too #{hint}."
      puts "Try again.  So far you've taken #{guesses} guesses"
      puts
    end
  end
end

def high_low(secret_number, guess)
  secret_number > guess ? "low" : "high"
end


number_guessing_game()