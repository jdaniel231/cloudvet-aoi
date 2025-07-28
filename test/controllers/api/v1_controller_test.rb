require "test_helper"

class Api::V1ControllerTest < ActionDispatch::IntegrationTest
  test "should get weights" do
    get api_v1_weights_url
    assert_response :success
  end
end
