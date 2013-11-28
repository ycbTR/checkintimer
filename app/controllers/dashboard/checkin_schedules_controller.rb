# encoding: UTF-8

class Dashboard::CheckinSchedulesController < Dashboard::BaseController
  # GET /checkin_schedules
  # GET /checkin_schedules.json
  def index
    @checkin_schedules = CheckinSchedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkin_schedules }
    end
  end

  # GET /checkin_schedules/1
  # GET /checkin_schedules/1.json
  def show
    @checkin_schedule = CheckinSchedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checkin_schedule }
    end
  end

  # GET /checkin_schedules/new
  # GET /checkin_schedules/new.json
  def new
    @checkin_schedule = current_user.checkin_schedules.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @checkin_schedule }
    end
  end

  # GET /checkin_schedules/1/edit
  def edit
    @checkin_schedule = current_user.checkin_schedules.where(id: params[:id]).first
  end

  # POST /checkin_schedules
  # POST /checkin_schedules.json
  def create
    @checkin_schedule = current_user.checkin_schedules.new(params[:checkin_schedule])

    respond_to do |format|
      if @checkin_schedule.save
        format.html { redirect_to dashboard_checkin_schedules_path, notice: 'Program başarıyla oluşturuldu.' }
        format.json { render json: @checkin_schedule, status: :created, location: @checkin_schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @checkin_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checkin_schedules/1
  # PUT /checkin_schedules/1.json
  def update
    @checkin_schedule = current_user.checkin_schedules.where(id: params[:id]).first

    respond_to do |format|
      if @checkin_schedule.update_attributes(params[:checkin_schedule])
        format.html { redirect_to dashboard_checkin_schedules_path, notice: 'Program başarıyla güncellendi.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkin_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkin_schedules/1
  # DELETE /checkin_schedules/1.json
  def destroy
    @checkin_schedule = current_user.checkin_schedules.where(id: params[:id]).first
    @checkin_schedule.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_checkin_schedules_path }
      format.json { head :no_content }
    end
  end
end
