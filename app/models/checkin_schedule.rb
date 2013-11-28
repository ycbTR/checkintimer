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
    queued_checkins = CheckinSchedule.where(:time => (Time.now - 1.minute)..(Time.now)).where("#{Time.now.strftime('%A').downcase}".to_sym => true)
    queued_checkins.each do |qc|
      user = qc.user
      next if !qc.can_checkin? || !user.can_checkin?
      begin
        qc.user.add_checkin(qc)
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
