require "test_helper"

class ContractorsControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get contractors_dashboard_url
    assert_response :success
  end
end
