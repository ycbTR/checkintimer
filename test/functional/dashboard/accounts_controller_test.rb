require 'test_helper'

class Dashboard::AccountsControllerTest < ActionController::TestCase
  setup do
    @dashboard_account = dashboard_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dashboard_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dashboard_account" do
    assert_difference('Dashboard::Account.count') do
      post :create, dashboard_account: { show: @dashboard_account.show }
    end

    assert_redirected_to dashboard_account_path(assigns(:dashboard_account))
  end

  test "should show dashboard_account" do
    get :show, id: @dashboard_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dashboard_account
    assert_response :success
  end

  test "should update dashboard_account" do
    put :update, id: @dashboard_account, dashboard_account: { show: @dashboard_account.show }
    assert_redirected_to dashboard_account_path(assigns(:dashboard_account))
  end

  test "should destroy dashboard_account" do
    assert_difference('Dashboard::Account.count', -1) do
      delete :destroy, id: @dashboard_account
    end

    assert_redirected_to dashboard_accounts_path
  end
end
