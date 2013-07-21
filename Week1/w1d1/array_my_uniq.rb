class Array
  def my_uniq
    include_ary = []
    self.each do |member|
      include_ary << member unless include_ary.include?(member)
    end
    include_ary
  end
end

sample_ary = [5, 5, 6, 7, 9, 7, 10, 5, 11]
p sample_ary
p sample_ary.my_uniq