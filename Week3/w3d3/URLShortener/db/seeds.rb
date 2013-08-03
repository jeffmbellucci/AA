# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 
# #
# users = User.create([ { :alias => 'DucKiller', :email => 'ihd@hotmail.com'}, { :alias => 'thatSignal', :email => 'signal@sig.com'}, { :alias => 'coder', :email => 'coder@aa.com' } ])
# #
# shorts = ShortUrl.create([ { :short_url => "www.a.com", :user_id => 1, :long_url_id => 1},  { :short_url => "www.b.com", :user_id => 1, :long_url_id => 2} ,  { :short_url => "www.c.com", :user_id => 1, :long_url_id => 1}])
# #
# longs = LongUrl.create([{:url => 'http://google.com'}, {:url => 'http://reddit.com'}])
# 
# comments = Comment.create([{:user_id => 1, :short_url_id => 3, :body => "OMG this is the worst website ever"}, {:user_id => 2, :short_url_id => 3, :body => "I found the edge of the internet!"}])

tags = Tag.create([{:tag => 'good'}, {:tag => 'bad'}, {:tag => 'ugly'}, {:tag =>'nsfw'}, {:tag =>'cute'}])

taggedurls = TagUrl.create([{:tag_id => 1, :short_url_id => 3},{:tag_id => 4, :short_url_id =>3}])