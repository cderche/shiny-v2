require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get payments_add_url
    assert_response :success
  end

end
