class Tweet < ActiveRecord::Base
  attr_accessible :t_id, :text, :time, :user_id

  belongs_to :user

end
