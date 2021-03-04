require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get aboutUs" do
    get home_aboutUs_url
    assert_response :success
  end
end
