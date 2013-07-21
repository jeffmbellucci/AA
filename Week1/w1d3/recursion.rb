def range(first, last)
  if first == last
    return [first]
  else
    [first] + range(first+1, last)
  end
end

def recursive_sum(arry)
  if arry.length == 1
    return arry[0]
  else
    return recursive_sum(arry[0...-1]) + arry[-1]
  end
end

def iterative_sum(arry)
  arry.inject { |accum, el| accum + el }
end

def exponent_a(base, exponent)
  return 1 if exponent == 0
  return base * exponent_a(base, exponent - 1)
end

def exponent_b(base, exponent)
  return 1 if exponent == 0
  if exponent % 2 == 0
    value =  exponent_b(base, exponent / 2)
    return value * value
  else
    value = exponent_b(base, (exponent - 1 ) / 2)
    base * (value * value)
  end
end

def deep_dup(arr)
  new_array = arr.map do |element|
    if element.is_a?(Array)
      deep_dup(element)
    else
      element
    end
  end
end

p range(1, 5)
p iterative_sum([1,2,3,4])

p exponent_a(2, 8)
p exponent_b(2, 8)
robot_parts = [["nuts", "bolts", "washers"], ["capacitors", "resistors", "inductors"]]
flat_array = [1,2,3]
duped_flat_array = deep_dup(flat_array)
duped_robot_parts = deep_dup(robot_parts)

puts
puts flat_array.object_id
puts duped_flat_array.object_id
puts
puts robot_parts.object_id
puts duped_robot_parts.object_id



