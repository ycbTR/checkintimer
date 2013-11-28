class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :gender
  # attr_accessible :title, :body

  has_many :authentications
  has_many :checkins
  has_many :checkin_schedules

  def access_token
    self.authentications.where(:provider => "foursquare").first.oauth_token rescue ""
  end

  def can_checkin?
    self.checkins.where(:created_at => (Date.today.beginning_of_month)..(Date.today.end_of_month)).count <= 30
  end

  def add_checkin(checkin_schedule)
    begin
      response = self.client.add_checkin(:venueId => checkin_schedule.venue_id,
                                         :broadcast => checkin_schedule.broadcast,
                                         :shout => checkin_schedule.shout
      )
      self.checkins.create(:venue_id => checkin_schedule.venue_id,
                           :venue_name => response.venue.name,
                           :broadcast => checkin_schedule.broadcast, :shout => checkin_schedule.shout,
                           :checkin_schedule_id => checkin_schedule.id)
      puts "Created checkin"
    rescue
      #Airbrake.notifiy
      false
    end
  end

  def client
    @client ||= Foursquare2::Client.new(:oauth_token => self.access_token)
  end

  def client_user
    client.user("self")
  end

  def badges
    client.user_badges('self').badges
  end

  def leaderboard
    client.leaderboard.leaderboard.items
  end

  def venues
    @venue_history ||= client.user_venue_history
    @venue_history.items.collect { |i| i.venue.id }
  end

  def venues_for_select
    @venue_history ||= client.user_venue_history
    @venue_history.items.collect { |i| [i.venue.name, i.venue.id] }
  end

end
