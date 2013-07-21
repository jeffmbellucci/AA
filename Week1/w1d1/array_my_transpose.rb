class Array
  def my_transpose
    number_of_rows = self.size
    number_of_columns = self[0].size
    cols = []
    number_of_rows.times do
      arr = []
      number_of_columns.times {arr << nil}
        cols << arr
      end
      self.each_with_index do |row, rowindex|
      row.each_with_index do |elt, colindex|
        cols[colindex][rowindex] = elt
      end
    end
    cols
  end
end


a = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

p a.my_transpose