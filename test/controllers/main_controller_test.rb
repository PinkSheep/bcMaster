require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  test "missing login should redirect to main" do
    post :login
    assert flash[:error]
    assert_equal "apikey or password missing", flash[:error]
    assert_redirected_to root_path
  end
  test "invalid login should redirect to main" do
    post :login, {id: "login-form", apikey: "key",secret: "secret"}
    assert flash[:error]
    assert_not_equal "apikey or password missing", flash[:error]
    assert_redirected_to root_path
  end
  test "valid login should redirect to trade" do
    post :login, {
      id: "login-form",
      apikey: "YACSECCW-SXC6EV2I-CF679EYB-PQ3NKI93-PENNC1UM",
      secret: "7876863e49c7ba7ac9dba285e9e6313e4b601aecfaab03b6c9704efa56f8f6de" }
    assert_redirected_to open_orders_path
    get :index
    assert :success
  end
  test "should redirect to main" do
    get :logout
    assert flash[:notice]
    assert_redirected_to root_path
  end
end
