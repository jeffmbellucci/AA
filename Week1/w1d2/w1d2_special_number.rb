def get_special_number()
  num = 250
  until num % 7 == 0
    num += 1
  end
  puts num
end

def factors()
  factors = {}
  (1..100).each do |num|
    factor_set = []
    (1..num).each do |factor|
      factor_set << factor if num % factor == 0
    end
    factors[num] = factor_set
  end
  factors
end

def bubble_sort!(array)
  changed = true
  while changed
    changed = false
    (0...array.length-1).each do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        changed = true
      end
    end
  end
  array
end

def bubble_sort(array)
  bubble_sort!(array.clone)
end

if __FILE__ == $PROGRAM_NAME
  puts bubble_sort!([4, 6, 8, 2, 9, 10, 310, 0])
end