class User < ActiveRecord::Base
  attr_accessible :alias, :email



  has_many(
    :short_urls,
    :class_name => "ShortUrl",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  has_many(
    :comments,
    :class_name => "Comment",
    :foreign_key => :user_id,
    :primary_key => :id
  )




end