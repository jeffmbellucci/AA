class WordChain

	def self.adjacent_strings(string)
		adjacent_strings = []
		(0..string.length).each do |i|
			("a".."z").each do |new_letter|
				new_string = string.dup
				next if new_letter == string[i]
				new_string[i] = new_letter
				adjacent_strings << new_string
			end
		end
		adjacent_strings
	end
	
	def self.adjacent_words(word, dictionary)
		adjacent_strings(word).select { |string| dictionary.has_key?(string) }		
	end
	
	def self.adjacent?(word1, word2) 
		return false if word1.length != word2.length
		difference = 0
		(0..word1.length).each do |i|
			difference += 1 if word1[i] != word2[i]
		end
		difference == 1
	end
	
	def self.path_from_parents(start, stop, parents_hash)
		path = [stop]
		word = stop
		while word!= start
			word = parents_hash[word]
			path.unshift(word)			
		end
		path
	end
	
	def initialize(dictionary = 'dictionary.txt')
		@dictionary = dictionary(dictionary)
	end
	
	def make_chain(start, stop)
		dictionary = trimmed_dictionary(start.length)
		parents_hash = {start => nil}
		queue = [start]
		while queue.length > 0 
			current = queue.shift
			if current == stop
				return WordChain.path_from_parents(start, stop, parents_hash)
			end
			adjacent_words = WordChain.adjacent_words(current, dictionary)
			.delete_if{ |word| parents_hash.keys.include?(word)}
			.each do |word|
				queue << word
				parents_hash[word] = current 
			end
		end
		nil
	end
	
	private 

	def dictionary(dictionary_file)
		Hash[File.readlines(dictionary_file).map{ |word| [word.chomp, true] }]
	end
	
	
	def trimmed_dictionary(num)
		@dictionary.clone.delete_if{ |word| word.length != num }
	end

	
end

#p w = WordChain.new.make_chain("ruby", "duck")