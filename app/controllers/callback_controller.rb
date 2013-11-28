class CallbackController < ApplicationController
  before_filter :set_foursquare

  def foursquare
    if params[:code].blank?
      redirect_to @foursquare.authorize_url(foursquare_callback_url(:host => "127.0.0.1")) and return
    elsif params[:code].present?
      @access_token = @foursquare.access_token(params["code"], (foursquare_callback_url :host => request.host))
      user = User.join(:authentications).where("#{Authentication.table_name}.oauth_token = ?", @access_token).where("#{Authentication.table_name}.provider = ?", "foursquare").first
      if user.blank?
        client = Foursquare2::Client.new(:oauth_token => @access_token)
        client_user = client.user("self")
        user = User.new(:email => client_user["contact"]['email'])
        temp_pass = SecureRandom.hex(6)
        user.password ||= temp_pass
        user.password ||= temp_pass
        user.firstname = client_user["firstName"]
        user.lastname = client_user["lastName"]
        user.gender = client_user["gender"]
        auth = user.authentications.new
        auth.profile_picture_url = client_user['photo']
        auth.uid = client_user['id']
        auth.provider = "foursquare"
        auth.oauth_token = @access_token
        user.save
      end
      sign_in(user)
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def foursquare_push

  end

  private
  def set_foursquare
    if Rails.env.development?
      @foursquare = Foursquare::Base.new("VV5WNYL1RZ5RRRUWZBP3AQ3BJGAFV0QEAHQSWRRQKH2AUFNR", "H3VZQBOMCQNF0NQF4ZENRKZ120U2V2YFP5KTPXGC5TV5QAIM")
      @client = Foursquare2::Client.new(:client_id => 'VV5WNYL1RZ5RRRUWZBP3AQ3BJGAFV0QEAHQSWRRQKH2AUFNR', :client_secret => 'H3VZQBOMCQNF0NQF4ZENRKZ120U2V2YFP5KTPXGC5TV5QAIM')

    else
      @foursquare = Foursquare::Base.new("23QOXLMBGFO25M3GUG4TZF5P4TXZIPR5RUYDNMWAAGYPTC0W", "BDXTLQQWPCCLWLUQT41FFSI2V3LPM4TJK2DI2QTXSCPBI33P")
      @client = Foursquare2::Client.new(:client_id => '23QOXLMBGFO25M3GUG4TZF5P4TXZIPR5RUYDNMWAAGYPTC0W', :client_secret => 'BDXTLQQWPCCLWLUQT41FFSI2V3LPM4TJK2DI2QTXSCPBI33P')
    end
  end
end