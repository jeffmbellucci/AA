def substrings(string)
  substrings_set = []
  (0...string.length).each do |start|
    (start...string.length).each do |stop|
      substrings_set << string[start..stop]
    end
  end
  substrings_set
end

def subwords(string)
  all_substrings = substrings(string)
  dictionary = get_dictionary
  all_substrings.select { |substring| dictionary.include?(substring) }
end

def get_dictionary
  dictionary = []
  File.foreach('2of12inf.txt') do |line|
    dictionary << line.chomp.gsub("%", "")
  end
  dictionary
end



if __FILE__ == $PROGRAM_NAME
  p subwords("cat in the hat")
end

