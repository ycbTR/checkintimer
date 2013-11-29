# encoding: UTF-8
class CheckinSchedule < ActiveRecord::Base
  attr_accessible :broadcast, :monday, :thursday, :tuesday, :friday, :wednesday, :saturday, :sunday, :post_to_facebook,
                  :post_to_twitter, :private, :shout, :time, :user_id,
                  :venue_id, :lat, :long, :venue_name, :state
  belongs_to :user
  has_many :checkins

  state_machine :initial => "scheduled" do
    event :pause do
      transition :to => "paused"
    end
    event :resume do
      transition :to => "scheduled"
    end
  end

  def label_class
    case state
      when "scheduled"
        "label-info"
      when "paused"
        "label-danger"
      else
        "label-info"
    end
  end

  def days
    _days = []
    _days << "Pazar" if sunday
    _days << "Pazartesi" if monday
    _days << "Salı" if tuesday
    _days << "Çarşamba" if wednesday
    _days << "Perşembe" if thursday
    _days << "Cuma" if friday
    _days << "Cumartesi" if saturday
    _days
  end

  def self.perform
    puts "Starting perform #{Time.now}"
    _time = Time.now.in_time_zone("Turkey")
    time = Time.new("2000", "01", "01", _time.hour, _time.min, _time.sec)
    queued_checkins = CheckinSchedule.where("time > ? AND time <= ?", (time - 1.minute).to_s(:db), time.to_s(:db)).where("#{Time.now.strftime('%A').downcase}".to_sym => true)
    queued_checkins.each do |qc|
      user = qc.user
      next if !qc.can_checkin? || !user.can_checkin?
      puts "Starting performing #{qc.to_yaml}"
      begin
        qc.user.add_checkin(qc)
          puts "Added checkin"
      rescue
        #TODO Airbrake.notify
        next
      end
    end
  end

  def can_checkin?
    true
  end


  def broadcast
    _broadcast = []
    _broadcast << "twitter" if post_to_twitter
    _broadcast << "facebook" if post_to_facebook
    _broadcast << "private" if private
    _broadcast << "public" if !private
    _broadcast.join(',')
  end
end
