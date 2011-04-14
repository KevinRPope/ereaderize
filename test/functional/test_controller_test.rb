require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get test_grab" do
    get :test_grab
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
