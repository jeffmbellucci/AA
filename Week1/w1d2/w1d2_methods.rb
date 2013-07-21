def rps(move)
  choices = ["Rock", "Scissors", "Paper"]
  computer_wins = [[0, 1], [1, 2], [2, 0]]

  computer_move = choices.find_index(choices.sample)
  person_move = choices.find_index(move.capitalize)
  puts "You picked #{choices[person_move]}"
  puts "Computer picks #{choices[computer_move]}"

  if computer_move == person_move
    puts "It's a tie!"
  elsif computer_wins.include?([computer_move, person_move])
    puts "You lost, you loser!"
  else
    puts "You won, congratulations!"
  end
end

rps("Rock")