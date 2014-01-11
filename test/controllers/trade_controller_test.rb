require 'test_helper'

class TradeControllerTest < ActionController::TestCase
  test "should get index" do
    session[:bcmaster] = {
      apikey: "YACSECCW-SXC6EV2I-CF679EYB-PQ3NKI93-PENNC1UM",
      secret: "7876863e49c7ba7ac9dba285e9e6313e4b601aecfaab03b6c9704efa56f8f6de" }
    get :index
    assert_response :success
  end
  test "should get index and flash error" do
    session[:bcmaster] = {
      apikey: "apikey",
      secret: "secret" }
    get :index
    assert flash[:error]
    assert_response :success
  end
  test "should redirect to main" do
    get :index
    assert_redirected_to main_index_url
  end
end
