class Hanoi
  def initialize(name, discs = 5)
    @towers = 3
    @discs = discs
    @name = name
    @rods = [[], [], []]
    @rods[0] = ( 0...(@discs) ).to_a
  end

  def move(start, stop)
      a = @rods[start].shift
      @rods[stop].unshift(a)
  end

  def valid_move?(start, stop)
    start.between?(-1, @towers) &&
    stop.between?(-1, @towers)  &&
    !@rods[start].empty?        &&
    (@rods[stop].empty? || @rods[start][0] < @rods[stop][0])
  end

  def display_arrays()
    puts
    puts "Tower 0: #{@rods[0]}"
    puts "Tower 1: #{@rods[1]}"
    puts "Tower 2: #{@rods[2]}"
    puts
  end

  def won?
    @rods[0].empty? && @rods[1].empty? && @rods[2] == ( 0...(@discs) ).to_a
  end

  def play_game
    until won?
      puts "Your Towers:"
      display_arrays()
      puts "Enter the source tower (or 'quit' to quit)"
      input = gets.chomp
      break if input == 'quit'
      source = input.to_i
      puts "Enter the destination tower (or 'quit' to quit)"
      input = gets.chomp
      break if input == 'quit'
      destination = input.to_i

      if valid_move?(source, destination)
        move(source, destination)
      else
        puts "That was not a valid move, please try again /n"
      end
    end
    puts "You've Won!!! Good Job #{@name}!!"
  end

end

a = Hanoi.new("Matt" , 3).play_game