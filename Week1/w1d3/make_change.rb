def make_change(amount, coins = [25, 10, 5, 1]) #assumes coins in descending order
  change = []
  multiple_coins = amount / coins[0]
  (multiple_coins).times { |coin|  change << coins[0] }
  change += make_change(amount % coins[0], coins[1..-1]) unless coins.length == 1
  change
end

p make_change(29)
p make_change(23)
p make_change(1)

#This doesn't work:
# p make_change(29, [22, 6, 4, 3])

# def make_change(amount, coins = [25, 10, 5, 1]) #assumes coins in descending order
#   change = []
#   coins.each do |coin|
#     until amount / coin == 0
#       change << coin
#       amount -= coin
#     end
#   end
#   change
# end
