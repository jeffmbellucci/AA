def num_to_s(num, base)
  extent = Math.log(num,base).floor
  output = ""
  (extent + 1).times do |i|
    output << make_string_from_elt((num / (base ** (extent - i))) % base)
  end
  output
end

def make_string_from_elt(elt)

  strings = {
    0 => "0",
    1 => "1",
    2 => "2",
    3 => "3",
    4 => "4",
    5 => "5",
    6 => "6",
    7 => "7",
    8 => "8",
    9 => "9",
    10 => "A",
    11 => "B",
    12 => "C",
    13 => "D",
    14 => "E",
    15 => "F"
  }

  return strings[elt]

end


p num_to_s(255, 16)