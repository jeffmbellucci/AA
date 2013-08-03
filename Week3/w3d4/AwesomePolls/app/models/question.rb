class Question < ActiveRecord::Base
  attr_accessible :poll_id, :body
  validates :poll_id, :presence => true
  validates :body, :presence => true
  
  

  has_many(:responses,
            :class_name => "Response",
            :foreign_key => :question_id,
            :primary_key => :id,
            :dependent => :destroy
  )
  has_many(:user_responses,
            :through => :responses,
            :source => :votes,
            :dependent => :destroy
  )
            
  belongs_to(:poll,
              :class_name => "Poll",
              :foreign_key => :poll_id,
              :primary_key => :id
  )

  def results
    response_counts = Hash.new{ 0 }
    self.user_responses.includes(:response).each do |ballot|
      response_counts[ballot.response.response] += 1
    end
    response_counts
  end

  def results_without_each
    responses_votes = self.responses.select("responses.id, responses.response, COUNT(*) AS votes_recieved")
    .joins(:votes)
    .group("responses.id")
    
    Hash[responses_votes.map {|response| [response.response, response.votes_recieved]}]
  end
  
  
  def results_without_returning_response_objects
    response_votes = self.responses.select("responses.id, responses.response, COUNT(*) AS votes_recieved")
    .joins(:votes)
    .group("responses.id")
  end

end
