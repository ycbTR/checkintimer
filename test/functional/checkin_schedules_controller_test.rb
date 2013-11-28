require 'test_helper'

class CheckinSchedulesControllerTest < ActionController::TestCase
  setup do
    @checkin_schedule = checkin_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checkin_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checkin_schedule" do
    assert_difference('CheckinSchedule.count') do
      post :create, checkin_schedule: {  }
    end

    assert_redirected_to checkin_schedule_path(assigns(:checkin_schedule))
  end

  test "should show checkin_schedule" do
    get :show, id: @checkin_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @checkin_schedule
    assert_response :success
  end

  test "should update checkin_schedule" do
    put :update, id: @checkin_schedule, checkin_schedule: {  }
    assert_redirected_to checkin_schedule_path(assigns(:checkin_schedule))
  end

  test "should destroy checkin_schedule" do
    assert_difference('CheckinSchedule.count', -1) do
      delete :destroy, id: @checkin_schedule
    end

    assert_redirected_to checkin_schedules_path
  end
end
