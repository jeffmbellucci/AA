class Array
  def two_sum
    output = []
    self.length.times do |i|
      ((i + 1)...self.length).each do |j|
        if self[i] + self[j] == 0
          output << [i, j]
        end
      end
    end
    output
  end
end

p [-1, 0, 2, -2, 1].two_sum