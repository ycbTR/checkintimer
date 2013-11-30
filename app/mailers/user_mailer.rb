class UserMailer < ActionMailer::Base
  default :from => "CheckinTimer.com <support@checkintimer.com>"

  def auto_checkin_performed(checkin_schedule)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")

    @user = checkin_schedule.user
    @checkin_schedule = checkin_schedule
    mail_params = {:to => @user.email, :subject => "CheckinTimer ile otomatik checkin yaptiniz"}
    mail(mail_params)
  end

  def auto_checkin_failed(checkin_schedule)
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")

    @user = checkin_schedule.user
    @checkin_schedule = checkin_schedule
    mail_params = {:to => @user.email, :subject => "CheckinTimer ile otomatik checkin basarisiz oldu"}
    mail(mail_params)
  end


end