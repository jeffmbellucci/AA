def merge_sort(arry)
  return arry if arry.length == 1

  if arry.length > 1
    middle = arry.length / 2
    arry1 = merge_sort(arry[0...middle])
    arry2 = merge_sort(arry[middle..-1])
  end
  merge(arry1, arry2)
end

def merge(arry1, arry2)
  merged = []
  until arry1.empty? || arry2.empty?
    if arry1[0] <= arry2[0]
      merged << arry1.shift
    else
      merged << arry2.shift
    end
  end
  merged += arry1 + arry2
  merged
end

p merge_sort([5,3,99,85,2,1,7,0,4,9,3])