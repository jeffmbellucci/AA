def concatenate(str_ary)
  str_ary.inject("") {|result, s| result << s}
end

p concatenate(["Yay ", "for ", "strings!"])