def super_print(string, options = {})
  defaults = {
    times: 1,
    upcase: false,
    reverse: false,
  }

  options = defaults.merge(options)
  new_string = string
  new_string = new_string.upcase if options[:upcase]
  new_string = new_string.reverse if options[:reverse]

  options[:times].times { puts new_string }
end

super_print("abc", :times => 3, :upcase => true, :reverse => true)