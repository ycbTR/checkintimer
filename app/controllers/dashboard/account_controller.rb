class Dashboard::AccountController < Dashboard::BaseController


  def show
    @dashboard_account = Dashboard::Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dashboard_account }
    end
  end


end
