def bsearch(array, target)
  #Assume sorted array
  return nil if array.empty?

  middle = array.length / 2
  case target <=> array[middle]
  when 0 then return middle
  when -1 then return bsearch(array[0...middle], target)
  when 1
    next_bsearch = bsearch(array[(middle + 1)..-1], target)
    return (next_bsearch.nil? ? nil : (middle + 1 + next_bsearch))
  end

end

a = [2, 3, 5, 10]
b = 10
p bsearch(a, b)