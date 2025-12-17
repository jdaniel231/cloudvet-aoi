require 'test_helper'

module Api
  class V1ControllerTest < ActionDispatch::IntegrationTest
    test 'should get weights' do
      get api_v1_weights_url
      assert_response :success
    end
  end
end
