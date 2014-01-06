require 'test_helper'

class TradeControllerTest < ActionController::TestCase
  test "should get trade" do
    get :trade
    assert_response :success
  end

end
