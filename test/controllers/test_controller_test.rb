require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get createorder" do
    get :createorder
    assert_response :success
  end

end
