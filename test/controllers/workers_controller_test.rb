require "test_helper"

class WorkersControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get workers_dashboard_url
    assert_response :success
  end
end
