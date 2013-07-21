class Array
  def subsets
    sub_array = []
    return [[]] if self.empty
    return subsets(self[0..-2]) + subsets(self[0..-2]).each{|elt| elt << self[-1]}
  end
end


# Write a method, subsets, that will return all subsets of an array.
#
# subsets([]) # => [[]]
# subsets([1]) # => [[], [1]]
# subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# # can also implement as an instance method