class Array
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
    self
  end

  def my_map(&arg)
    new_array = []
    self.my_each do |el|
      new_array << arg.call(el)
    end
    new_array
  end

  def my_select(&arg)
    new_array = []
    self.my_each do |el|
      new_array << el if arg.call(el)
    end
    new_array
  end

  def my_inject(&arg)
    accumulator = self[0]
    self.my_each do |el|
      accumulator = arg.call(accumulator, el)
    end
    accumulator
  end

  def my_sort!(&arg)
    sorted = false
    until sorted
     sorted = true
     self.count.times do |index|
       # last element has no next element
       next if (index + 1) == self.count

       if arg.call(self[index] , self[index + 1]) == 1
         self[index], self[index + 1] = self[index + 1], self[index]
         sorted = false
       end
     end
    end

    self
  end

end

def args_in_block(*args)
  if block_given?
    yield(*args)
  else
    puts 'NO BLOCK GIVEN!'
  end
end

a = [1, 2, 3, 4]
p a.my_select { |el| el == 2 || el == 4 }

p a.my_inject{|acc, i| i*acc }
b = [5, 7, 2, 4, 6, 9, 9, 1]
p b.my_sort! { |num1, num2| num2 <=> num1 }
p b
p args_in_block(1,3,5,9) #{ |a, b, c| a + b + c }
