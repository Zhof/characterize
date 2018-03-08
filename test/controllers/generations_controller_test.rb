require 'test_helper'

class GenerationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get generations_new_url
    assert_response :success
  end

end
