require 'test_helper'

class MyxmlControllerTest < ActionController::TestCase
  test "should get parseXMLcats" do
    get :parseXMLcats
    assert_response :success
  end

  test "should get loadCategories" do
    get :loadCategories
    assert_response :success
  end

end
