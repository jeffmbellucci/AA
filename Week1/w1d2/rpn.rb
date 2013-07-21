#!/usr/bin/env ruby

class RPNcalculator
  def initialize
    @stack = []
    @operations_hash = {
      "+" => :plus,
      "-" => :minus,
      "*" => :multiply,
      "/" => :divide
    }
  end

  def push(number)
    @stack << number
  end

  def value
    @stack[-1]
  end

  def plus
    @stack << (@stack.pop + @stack.pop)
  end

  def minus
    @stack << (0 - @stack.pop + @stack.pop)
  end

  def multiply
    @stack << (@stack.pop * @stack.pop)
  end

  def divide
    @stack << (1 / @stack.pop * @stack.pop)
  end

  def calculate_file(filename)
    equation_array = parse_equation(File.read(filename))
    equation_array.each do |command|
      do_command(command)
    end
    value
  end

  def do_command(command)
    if @operations_hash.keys.include?(command)
      send(@operations_hash[command])
    else
      self.push(command.to_i)
    end
  end

  def parse_equation(string)
    equation_array = string.split(/\s/)
  end

  def user_interface
    puts "Welcome to the RPN calculator! Type 'exit' to quit."
    puts "Please enter your first command, if you dare..."
    command = STDIN.gets.chomp
    while command != "exit"
      do_command(command)
      puts "Result is #{value}"
      puts "Enter next command."
      command = STDIN.gets.chomp
    end
  end
end

if $PROGRAM_NAME == __FILE__
  rpn = RPNcalculator.new
  if ARGV[0] == "interface"
    rpn.user_interface
  elsif ARGV[0]
    rpn.calculate_file(ARGV[0]) if ARGV[0]
    puts rpn.value
  end
end
