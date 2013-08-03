class User < ActiveRecord::Base
  attr_accessible :email, :name
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true

  has_many(:polls,
            :class_name => "Poll",
            :foreign_key => :author_id,
            :primary_key => :id,
            :dependent => :destroy
  )
  has_many(:user_responses,
            :class_name => "UserResponse",
            :foreign_key => :user_id,
            :primary_key => :id,
            :dependent => :destroy
  )



  def polls_taken
    #self.user_responses.join("responses ON re

  end
  def respond_to(question)
    response_id = self.response(question)
    UserResponse.new(self.id, response_id)
  end

  def response(question) #talks to the user
     puts question.body
     question.responses.each  do |response|
       puts "#{response.id}. response.body"
     end
     gets.chomp.to_i  #todo: validation
  end

  def take_poll(poll)
    #make sure this isn't n+1
    raise "You can't take your own Polls" if poll.author_id = self.id
    poll.questions.includes(:responses)
    poll.questions.each do |question|
      respond_to(question)
    end

  end
end
