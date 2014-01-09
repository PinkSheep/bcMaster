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
    assert_redirected_to main_index_path
  end  
  test "invalid login should redirect to main" do
    post :login, {id: "login-form", apikey: "key",secret: "secret"}
    assert flash[:error]
    assert_not_equal "apikey or password missing", flash[:error]
    assert_redirected_to main_index_path
  end
  test "should redirect to main" do
    get :logout
    assert flash[:notice]
    assert_redirected_to main_index_path
  end
end
