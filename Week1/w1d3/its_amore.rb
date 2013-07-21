def its_amore(nym)
  return [0] if nym == 1
  erin = [0, 1]
  if nym > 2
    erin += its_amore(nym-1)[2..-1]
    erin += [erin[-2] + erin[-1]]
  end

  erin
end
