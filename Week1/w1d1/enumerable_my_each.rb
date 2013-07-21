class Array
  def my_each
    self.length.times do |i|
      self[i] = yield self[i]
    end
    self
  end
end

p [1, 2, 3].my_each {|a| a+1}