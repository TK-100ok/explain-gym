require "test_helper"

class TrainingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trainings_url
    assert_response :success
  end
end
