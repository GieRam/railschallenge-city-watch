require "test_helper"

class EmergencyControllerTest < ActionController::TestCase
  def test_create
    get :create
    assert_response :success
  end

end
