require 'launchy'

class ShortUrl < ActiveRecord::Base
  attr_accessible :long_url_id, :short_url, :user_id

  belongs_to(
    :user,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  belongs_to(
    :long_url,
    :class_name => "LongUrl",
    :foreign_key => :long_url_id,
    :primary_key => :id
  )


  has_many(
    :comments,
    :class_name => "Comment",
    :foreign_key => :short_url_id,
    :primary_key => :id
  )
  
  has_many(
    :visits, 
    :class_name => "Visit", 
    :foreign_key => :short_url_id, 
    :primary_key => :id
  )
  
  has_many(
    :visitors,
    :through => :visits,
    :source => :user
  
  )

  def self.shorten(long_url)
      SecureRandom.urlsafe_base64
  end

  def self.expand(short_url, user)
    short_url = ShortUrl.find_by_short_url(short_url)
    long_url_id = short_url.long_url.id
    url = LongUrl.find(long_url_id).url
    Visit.create([{:short_url_id => short_url.id, :user_id => user.id, :visit_time => Time.now}])
    comments = short_url.comments.map { |comment| comment.body }
    Launchy.open(url)
    puts comments
  end
  
  def unique_visits
   self.visits.select("COUNT(*) AS visitor_count").group("user_id").length
  end
  
#   def self.open(short_url, user)
#     
#   end

  # def self.comments(short_url, user) #this only gets the first shortened version's comments, not the correct shortened versions comments
#     ShortUrl.find_by_short_url(short_url).comments
#   end


end