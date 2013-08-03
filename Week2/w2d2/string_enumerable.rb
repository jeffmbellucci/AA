#my own enumerable module that uses each_char instead of each . . . this one is for strings

module StringEnumerable
	def each(&blk)
		each_char(&blk)
	end
	
	def any?(&blk)
		self.each { |elt| return true if blk.call(elt) }
		false
	end
	
	def all?(&blk)
		self.each { |elt| return false unless blk.call(elt) }
		true
	end
	
	def include?(target)
		self.each { |elt| return true if elt == target }
		false
	end
	
	def exclude?(target)
		!include?(target)
	end
	
	def map(&blk)
		collection = String.new
		self.each { |elt| collection << blk.call(elt) }
		collection
	end
	
	def inject(acc = nil, &blk)
		initialized = false
		self.each do |elt|
			if !initialized
				initialized = true
				if !acc 
					acc = elt
					next
				end
			end
		acc = blk.call(acc, elt)
		end
		acc
	end
end

class String
	include StringEnumerable
	
end

"abc".each{ |a| puts a }
puts "abc".any?{ |a| a == "z" }
puts "abc".all?{ |a| a == "b" }
puts "abc".map { |a| a + "b" }
puts "abc".include?("b")
puts "abc".exclude?("b")
puts "abc".inject("") { |acc, a| acc + ("z" + a) }