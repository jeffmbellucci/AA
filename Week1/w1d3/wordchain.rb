#Given two words of equal length as command-line arguments,
#build a chain of words connecting the first to the second.
#Each word in the chain must be in the dictionary and every step
# along the chain changes exactly one letter from the previous word.

class WordChains
  def initialize

  end

  def adjacent_words(word, dictionary)
  	adjacent_words = []
  	word.length.times do |index|
  		new_word = word.dup
  		"a".upto("z").each do |letter|
			new_word[index] = letter
			adjacent_words << new_word if adjacent?(new_word, word)
  		end
  	end
	adjacent_words
  end

  def load_dictionary(dictionary = 'dictionary.txt')
    File.readlines(dictionary).map { |entry| entry.chomp }
  end

  def adjacent?(str1, str2)
    diff_count = 0
    arr1 = str1.split('')
    arr2 = str2.split('')

    arr1.each_with_index do |el, index|
      diff_count += 1 unless el == arr2[index]
    end
    diff_count == 1
  end
	
  def path_from_parents(start, stop, parents)
  	path = [stop]
  	current = stop  	
  	until current == start
  		current = parents[current]
  		path << current  		
  	end
  	path.reverse
  end
  
  def find_chain(start, stop, dictionary)
  	found = false 
  	no_path = false
	dictionary = dictionary.select{ |entry| entry.length == start.length }
    visited_words = [start]
    new_words = [start]
    current_words = [start]
    parents = {}
    
    loop do
    	new_words =[]
    	if current_words.length == 0
    		no_path == true
    		return nil
    	end
		current_words.each do |word|
			if  word == stop 
				return path_from_parents(start, stop, parents)
			end
			
			adjacent_words = adjacent_words(word, dictionary).select{ |w| !visited_words.include?(w) }
		
			adjacent_words.each { |w| parents[w] = word }
			new_words += adjacent_words
		end
		visited_words += new_words
		dictionary = dictionary.select{ |w| !visited_words.include?(w) }
		current_words = new_words
	end
  end
  
end

b = WordChains.new
c = b.load_dictionary
p b.find_chain('duck', 'sulk' , c )







