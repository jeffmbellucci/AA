class NotAMatrixError < ArgumentError
end

class Array

  def my_uniq
    seen = []
    delete_indices = []
    self.each_with_index do |elt, index|
      delete_indices << index if seen.include?(elt)
      seen << elt
    end
    delete_indices.reverse.each do |index|
      self.delete_at(index)
    end
    self
  end

  def two_sum
    pairs = []
    self.each_with_index do |elt, i|
      ((i+1)...self.count).each do |j|
        pairs << [i, j] if self[i] + self[j] == 0
      end
    end
    pairs
  end

  def my_transpose
    raise NotAMatrixError.new("this is not a matrix") if misshapen?
    transposition = Array.new(self.length) { Array.new }
    self.each_with_index do |row, r|
      row.each_with_index do |elt, c|
        transposition[c] << elt
      end
    end
    transposition
  end

  def misshapen?
    return false if self.empty?
    return false if self.all?{|row| row.size == self[0].size}
    true
  end


  def stock_picker
    raise ArgumentError unless self.length > 1
    output = []
    most = nil

    self.each_with_index do |price, buy_day|
      ((buy_day+1)...self.length).each do |sell_day|
        earnings = self[sell_day] - self[buy_day]
        most, output = earnings, [buy_day, sell_day] if most.nil?
        if  earnings > most
          most = earnings
          output = [buy_day, sell_day]
        end
      end
    end

    output
  end

end