require 'test_helper'

class TradeControllerTest < ActionController::TestCase
  test "should get trade" do
    get :index
    assert_response :success
  end

end
