require 'securerandom'

class UrlShortener
  # 0. make user sign in
  # 1. get url from user
  # 2. turn it into a short url
  # 3. save everything in the database
  # 4. when they type in URLShortner.expand


  def self.login(email)
    UrlShortener.new(User.find_by_email(email))
  end

 
  def initialize(user)
    @current_user = user
    puts "Welcome, #{@current_user.alias}!"
  end
  
  def shorten(long_url) 
    ShortUrl.shorten(long_url)
  end

  def expand(short_url)
    ShortUrl.expand(short_url, @current_user)
  end



end