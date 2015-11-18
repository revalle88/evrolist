require 'test_helper'

class FavouritesControllerTest < ActionController::TestCase
  test "should get addToFavourites" do
    get :addToFavourites
    assert_response :success
  end

  test "should get showFavourites" do
    get :showFavourites
    assert_response :success
  end

end
