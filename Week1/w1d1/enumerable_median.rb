def median(arr)
  a = arr.sort
  mid_index = (a.length - 1) / 2.0
  #puts mid_index
  m1 = a[mid_index.floor]
  m2 = a[mid_index.ceil]
  #puts m1
  #puts m2
  ((m1 + m2) / 2.0)
 # (arr.sort[(arr.length / 2.0).floor] + arr.sort[(arr.length / 2.0).ceil] )/ 2.0
end

p median([1, 2, 1, 2])
p median([1,2,3,4,5])



