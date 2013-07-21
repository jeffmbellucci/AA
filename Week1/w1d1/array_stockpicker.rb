def stockpicker(prices)
  output = [0, 1]
  max = prices[1] - prices[0]
  prices.length.times do |i|
    ((i + 1)...prices.length).each do |j|
      if prices[j] - prices[i] > max
        max = prices[j] - prices[i]
        output = [i, j]
      end
    end
  end
  output
end

a = [0, 50, -6, 0, 45, 100, -67]
p stockpicker(a)