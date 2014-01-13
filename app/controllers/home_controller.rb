class HomeController < ApplicationController
  layout "coming_soon"

  def index

  end
  
  def ping
    ::CheckinSchedule.perform
    render :text => "ok"
  end
  
end
