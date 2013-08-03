class Poll < ActiveRecord::Base
  attr_accessible :author_id, :title
  validates :author_id, :presence => true
  validates :title, :presence => true

  has_many(:questions,
            :foreign_key => :poll_id,
            :class_name => "Question",
            :primary_key => :id,
            :dependent => :destroy
  )

  belongs_to(:author,
              :class_name => "User",
              :foreign_key => :author_id,
              :primary_key => :id
  )

end
