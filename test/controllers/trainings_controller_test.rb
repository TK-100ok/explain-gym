require "test_helper"

class TrainingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get trainings_url
    assert_response :success
  end
end
