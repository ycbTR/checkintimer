# encoding: UTF-8

class Dashboard::BaseController < ApplicationController
  layout "dashboard"
  before_filter :authenticate_user!

  def index

  end

  def leaderboard
    @leaderboard = current_user.leaderboard
  end
  def badges
    @leaderboard = current_user.leaderboard
  end

end
