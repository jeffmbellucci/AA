class Visit < ActiveRecord::Base
  attr_accessible :short_url_id, :user_id, :visit_time
  
  belongs_to(
    :short_url,
    :primary_key => :id,
    :foreign_key => :short_url_id
  )
  
  belongs_to(
    :user,
    :primary_key => :id,
    :foreign_key => :user_id
  )
  

end
