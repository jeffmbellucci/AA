# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create([{name: "Jeff", email: "jeffmbellucci@gmail.com"}, {name: "Anteater", email: "foo@bar.com"},  {name: "Ant", email: "bar@foo.com"}] )

Poll.create([ {author_id: 1, title: "Favorite Colors"}])
#
Question.create([{poll_id: 1, body: "What is your favorite color?"}, {poll_id: 1, body: "Why?"}])

Response.create([{question_id: 1, response: "blue"}, {question_id: 1, response: "green"}, {question_id: 1, response: "red"}, {question_id: 1, response: "yellow"}, {question_id: 1, response: "orange"}, {question_id: 2, response: "Because it is pretty"}, {question_id: 2, response: "Because my best friend likes this color"}, {question_id: 2, response: "I don't know"}])

UserResponse.create([{user_id: 2, response_id: 5}, {user_id: 2, response_id: 6},  {user_id: 3, response_id: 1}, {user_id: 3, response_id: 8}])

UserResponse.new({user_id: 2, response_id: 8})