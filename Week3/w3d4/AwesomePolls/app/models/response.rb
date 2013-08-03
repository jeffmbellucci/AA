class Response < ActiveRecord::Base
  attr_accessible :question_id, :response
  validates :question_id, :presence => true
  validates :response, :presence => true

  belongs_to(:question,
              :class_name => "Question",
              :foreign_key => :question_id,
              :primary_key => :id
  )
  has_many(:votes,
            :class_name => "UserResponse",
            :foreign_key => :response_id,
            :primary_key => :id,
            :dependent => :destroy
  )
end
