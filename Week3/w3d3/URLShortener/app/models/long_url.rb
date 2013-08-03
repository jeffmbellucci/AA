class LongUrl < ActiveRecord::Base
  attr_accessible :url

  has_many(
    :short_urls,
    :class_name => "ShortUrl",
    :foreign_key => :long_url_id,
    :primary_key => :id

  )

  has_many(
    :comments,
    :through => :short_urls
  )

  def self.get_comments(url)
    LongUrl.find_by_url(url).comments
  end




end
