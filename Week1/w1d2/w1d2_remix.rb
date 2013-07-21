def remix(drinks)
  alcohols = []
  mixers = []

  drinks.each do |drink|
    alcohols << drink.first
    mixers << drink.last
  end

  #alcohols.shuffle!
  alcohols.rotate!((1...alcohols.length).to_a.sample)

  new_drinks = []

  alcohols.length.times do |n|
    new_drinks << [alcohols[n], mixers[n]]
  end
  new_drinks
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"],
  ["vodka", "cranberry juice"],
  ["beer", "lemonade"]
])

