def shuffler
  puts "Welcome to shuffler. You write 'em, we mess 'em up."
  puts "Please enter a filename to shuffle"
  filename = gets.chomp
  shuffled_lines = File.readlines(filename).shuffle
  new_filename = filename.gsub(".txt", "-shuffled.txt")
  f = File.open(new_filename, "w")
  shuffled_lines.each { |line| f.puts line }
  f.close
end

shuffler