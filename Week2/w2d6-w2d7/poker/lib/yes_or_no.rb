module YesOrNo
	def yes_or_no?(string)
		string = string.dup.chomp.downcase.strip
		['yes', 'no', 'y', 'n'].include?(string)
	end	
	
	def yes?(string)
		string = string.dup.chomp.downcase.strip
		return true if string == 'yes' || string == 'y'
		false
	end
	
	def no?(string)
		string = string.dup.chomp.downcase.strip
		return true if string == 'no' || string == 'n'
		false
	end
	
	def verify(value)
		have_answer = false
		until have_answer
			puts "I have #{value}.  Is that correct?"
			answer = gets.chomp
			have_answer = yes_or_no?(answer)
		end
		return yes?(answer)
	end
end