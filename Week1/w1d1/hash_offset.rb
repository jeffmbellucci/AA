def hash_offset(hash_input)
  # output = {}
  v = hash_input.values
  k = hash_input.keys
  k.map! {|x| x.next}
  Hash[k.zip(v)]
end

wrong_hash = { :a => "banana", :b => "cabbage", :c => "dental_floss", :d => "eel_sushi" }
p hash_offset(wrong_hash)