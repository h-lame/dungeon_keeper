require 'test_helper'

class EvilWizardsControllerTest < ActionController::TestCase
  setup do
    @evil_wizard = evil_wizards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evil_wizards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should fetch a list of dungeons during new" do
    get :new
    assert_not_nil assigns(:dungeons)
  end

  test "should create evil_wizard" do
    @evil_wizard.destroy
    assert_difference('EvilWizard.count') do
      post :create, :evil_wizard => @evil_wizard.attributes
    end

    assert_redirected_to evil_wizard_path(assigns(:evil_wizard))
  end

  test "should show evil_wizard" do
    get :show, :id => @evil_wizard.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @evil_wizard.to_param
    assert_response :success
  end

  test "should fetch a list of dungeons during edit" do
    get :edit, :id => @evil_wizard.to_param
    assert_not_nil assigns(:dungeons)
  end

  test "should update evil_wizard" do
    put :update, :id => @evil_wizard.to_param, :evil_wizard => @evil_wizard.attributes
    assert_redirected_to evil_wizard_path(assigns(:evil_wizard))
  end

  test "should destroy evil_wizard" do
    assert_difference('EvilWizard.count', -1) do
      delete :destroy, :id => @evil_wizard.to_param
    end

    assert_redirected_to evil_wizards_path
  end
end
