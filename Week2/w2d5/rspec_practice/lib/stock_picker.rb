def stock_picker(days)
  output = []
  most = nil
  days.each_with_index do |price, buy_day|
    (buy_day...days.length).times do |sell_day|
      earnings = days[sell_day] - days[buy_day]
      most = earnings if most.nil?
      if  earnings > most
        most = earnings
        output = [buy_day, sell_day]
      end
    end
  end
  output
end