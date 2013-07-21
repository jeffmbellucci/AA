def cipher(input,shift_i)
  output = ""
  table = ("a".."z").to_a
  input.each_char do |ltr|

    if table.include?(ltr)
      code = (table.find_index(ltr) + shift_i) % 26
      output << table[code]
    else
      output << ltr
    end
  end
  output
end

p cipher("hello, John", 10)
p cipher("hello", 100)
p cipher("hello", -19)
p cipher("a", 1)