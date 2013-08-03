require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super("aa_questions.db")

    self.results_as_hash = true
    self.type_translation = true
  end
end # end class QuestionDatabase


require './user.rb'
require './question.rb'
require './reply.rb'
require './question_follower.rb'
require './question_like.rb'

#a = Question_follower.followed_questions_for_user_id(1)
#b = Question_follower.followers_for_question_id(2)
#p b

# p QuestionFollower.most_followed_questions(-1)
# p Question.most_followed(2)
# p QuestionLike.likers_for_question_id(1)
# p User.find_by_id(2).average_karma

# User.new({"id" => nil, "fname" =>'sarah', "lname" =>'silly'}).s

