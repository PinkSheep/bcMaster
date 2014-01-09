require 'test_helper'

class TradeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, {id: 9999}, {bcmaster: "test"}
    assert_response :success
  end
  test "should redirect to main" do
    get :index
    assert_redirected_to main_index_url
  end
end
