class Checkin < ActiveRecord::Base
  attr_accessible :broadcast, :lat, :long, :shout, :user_id, :venue_id, :venue_name
  belongs_to :user
end
