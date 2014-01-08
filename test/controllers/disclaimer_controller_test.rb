require 'test_helper'

class DisclaimerControllerTest < ActionController::TestCase
  test "should get disclaimer" do
    get :disclaimer
    assert_response :success
  end

end
