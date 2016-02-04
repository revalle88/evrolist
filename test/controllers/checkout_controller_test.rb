require 'test_helper'

class CheckoutControllerTest < ActionController::TestCase
  test "should get checkout_form" do
    get :checkout_form
    assert_response :success
  end

end
