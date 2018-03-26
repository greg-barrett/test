require 'test_helper'

class StaticpagesControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get staticpages_landing_url
    assert_response :success
  end

end
