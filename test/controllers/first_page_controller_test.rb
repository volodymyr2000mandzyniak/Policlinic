require "test_helper"

class FirstPageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get first_page_index_url
    assert_response :success
  end
end
