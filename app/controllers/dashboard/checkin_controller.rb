# encoding: UTF-8

class Dashboard::CheckinController < Dashboard::BaseController


  def index
    @checkins = current_user.checkins.order("created_at DESC")
  end

  def now
    if request.post?
      insta_checkin = OpenStruct.new(:venue_id => params[:venue_id], :broadcast => broadcast, :shout => params[:shout])
      if params[:venue_id]
        begin
          venue = @@client.venue(venue_id)
          insta_checkin.lat = venue.location.lat
          insta_checkin.long = venue.location.long
        rescue
        end
      end
      if current_user.add_checkin(insta_checkin)
        flash[:success] = "Başarıyla Check-in yaptınız"
        redirect_to dashboard_checkins_path
      else
        flash[:error] = "Maalesef Check-in yapamadık. Değerlerinizi kontrol edip tekrar deneyin."
        render 'now'
      end
    end
  end

  def schedules
    @schedules = current_user.checkin_schedules
  end

  def schedule
    if request.get?
      @schedule = current_user.checkin_schedules.new
    else
      @schedule = current_user.checkin_schedules.new(params[:checkin_schedule])
      if @schedule.save
        flash[:success] = "Başarıyla program oluşturdunuz."
        redirect_to dashboard_checkin_schedules_path and return
      else
        flash[:error] = "Birşeyler ters gitt. Değerlerinizi kontrol edip tekrar deneyin"
        render 'schedule'
      end
    end
  end

  def edit
    @schedule = current_user.checkin_schedules.find(params[:id])
    if !request.get?
      if @schedule.update_attributes(params[:checkin_schedule])
        flash[:success] = "Başarıyla program güncellendi."
        redirect_to dashboard_checkin_schedules_path and return
      else
        flash[:error] = "Birşeyler ters gitt. Değerlerinizi kontrol edip tekrar deneyin"
        render 'edit'
      end
    end
  end


  private

  def broadcast
    _broadcast = []
    _broadcast << "twitter" if params["post_to_twitter"]
    _broadcast << "facebook" if params["post_to_facebook"]
    _broadcast << "private" if params["private"]
    _broadcast << "public" if !params["private"]
    _broadcast.join(',')
  end


end