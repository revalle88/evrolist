require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  test "should get pay" do
    get :pay
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

  test "should get success" do
    get :success
    assert_response :success
  end

  test "should get fails" do
    get :fails
    assert_response :success
  end

end
