require 'test_helper'

class MonstersControllerTest < ActionController::TestCase
  test "the new action" do
    get :new
    assert response.success?
    assert assigns(:monster).new_record?
  end
end