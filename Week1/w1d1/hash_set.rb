

def set_add_el(set, elt)
  set[elt] = true
end # => {:x => true} # This should automatically work if the first method worked

def set_remove_el(set, elt)
  set.delete elt
end # => {}

def set_list_els(set)
  set.keys
end# => [:x, :y]

def set_member?(set, elt)
  set.has_key? elt
end # => true

def set_union(set1, set2)
  set1.merge set2
end # => {:x => true, :y => true}

def set_intersection(set1, set2)
  output = {}
  set1.each_key do |k|
    output[k] = true if set2.has_key? k
  end
  output
end # I'm not going to tell you how the last two work

def set_minus(set1, set2)
  output = set1
  set2.each_key do |k|
    output.delete k
  end
  output
end # Return all elements of the first array that are not in the second array, not vice versa


p set_add_el({}, :x) # => make this return {:x => true}
p set_add_el({:x => true}, :x) # => {:x => true} # This should automatically work if the first method worked
p set_remove_el({:x => true}, :x) # => {}
p set_list_els({:x => true, :y => true}) # => [:x, :y]
p set_member?({:x => true}, :x) # => true
p set_union({:x => true}, {:y => true}) # => {:x => true, :y => true}
p set_intersection({:x => true, :y => true}, {:y => true, :z => true})# I'm not going to tell you how the last two work
p set_minus({:x => true, :y => true}, {:y => true, :z => true}) # Return all elements of the first array that are not in the second array, not vice versa