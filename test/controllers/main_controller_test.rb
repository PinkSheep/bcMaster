require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  test "failing login should redirect to main" do
    post :login
    assert_redirected_to main_index_path
  end
  test "should redirect to main" do
    get :logout
    assert_redirected_to main_index_path
  end
end
