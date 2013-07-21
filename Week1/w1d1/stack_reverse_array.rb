str = "string"
str_arr = str.split("")
new_str =[]
str_arr.length.times do |i|
  new_str << str_arr.pop
end
p new_str.join("")
