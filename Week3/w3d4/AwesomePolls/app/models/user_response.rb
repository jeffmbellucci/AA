class UserResponse < ActiveRecord::Base
   attr_accessible :user_id, :response_id
   validates :user_id, :presence => true
   validates :response_id, :presence => true
   validate :question_already_answered?

   # belongs_to :user
   # belongs_to :response
   # belongs_to :question

   belongs_to(:user,
              :class_name => "User",
              :foreign_key => :user_id,
              :primary_key => :id
  )

  belongs_to(:response,
             :class_name => "Response",
             :foreign_key => :response_id,
             :primary_key => :id
  )
   has_one(:question,
          :through => :response,
          :source => :question)

 def question_already_answered?
   responses = self.question.responses.includes(:votes)
   responses.each do |response|
     response.votes.each do |vote|
       errors[:user_id] << "User can't vote twice!!!" if vote.user_id == self.user_id
     end
   end
 end

end
