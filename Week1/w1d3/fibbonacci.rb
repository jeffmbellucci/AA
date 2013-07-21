# def fib_recursive(num_requested)
#   fib_array = []
#   (0...num_requested).each do |num|
#     fib_array << fib_recursive_single(num)
#   end
#   fib_array
# end
#
# def fib_recursive_single(num)
#   return 0 if num == 0
#   return 1 if num == 1
#   return fib_recursive_single(num - 1) + fib_recursive_single(num - 2)
# end

def fib_recursive(num)
  return [] if num == 0
  return [0] if num == 1
  return [0, 1] if num == 2

  smaller_fibs = fib_recursive(num - 1)
  return smaller_fibs << (smaller_fibs[-2] + smaller_fibs[-1])
end



def fib_iterative(num_requested)
  return [0] if num_requested == 1
  fib_arr = [0,1]
  while fib_arr.length < num_requested
    fib_arr << (fib_arr[-2] + fib_arr[-1])
  end
  return fib_arr
end

p fib_recursive(0)
p fib_recursive(1)
p fib_recursive(2)
p fib_recursive(10)