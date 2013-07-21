class Array
  def subsets
    sub_array = []
    return [[]] if self.empty?
    return self[0..-2].subsets + self[0..-2].subsets.each{|elt| elt << self[-1]}
  end
end

p ["a", "b", "c", "d"].subsets
p [].subsets
p [[]].subsets
p ["a"].subsets