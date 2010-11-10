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

  test "should create evil wizard" do
    @evil_wizard.destroy
    assert_difference('EvilWizard.count') do
      post :create, :evil_wizard => @evil_wizard.attributes
    end

    assert_redirected_to evil_wizard_path(assigns(:evil_wizard))
  end

  test "should not create evil wizard if params are wrong" do
    assert_no_difference('EvilWizard.count') do
      post :create, :dungeon => @evil_wizard.attributes.except('name')
    end

    assert_response :success
  end

  test "should leave the broken evil wizard available to the view if params are wrong during create" do
    post :create, :dungeon => @evil_wizard.attributes.except('name')

    assert assigns(:evil_wizard).name.blank?
    refute_empty assigns(:evil_wizard).errors
  end

  test "should fetch a list of dungeons during create if params are wrong" do
    post :create, :dungeon => @evil_wizard.attributes.except('name')
    assert_not_nil assigns(:dungeons)
  end

  test "should show the requested evil wizard" do
    get :show, :id => @evil_wizard.to_param
    assert_response :success
    assert_equal @evil_wizard, assigns(:evil_wizard)
  end

  test "should get edit for the requested evil wizard" do
    get :edit, :id => @evil_wizard.to_param
    assert_response :success
    assert_equal @evil_wizard, assigns(:evil_wizard)
  end

  test "should fetch a list of dungeons during edit" do
    get :edit, :id => @evil_wizard.to_param
    assert_not_nil assigns(:dungeons)
  end

  test "should update evil_wizard" do
    put :update, :id => @evil_wizard.to_param, :evil_wizard => @evil_wizard.attributes
    assert_redirected_to evil_wizard_path(assigns(:evil_wizard))
  end

  test "should not update evil wizard if params are wrong" do
    put :update, :id => @evil_wizard.to_param, :evil_wizard => @evil_wizard.attributes.merge('experience_points' => "2000")
    assert_response :success
    assert_equal 1, @evil_wizard.reload.experience_points
  end

  test "should leave the broken evil wizard available to the view if params are wrong during update" do
    put :update, :id => @evil_wizard.to_param, :evil_wizard => @evil_wizard.attributes.merge('experience_points' => "2000")
    assert_equal 2000, assigns(:evil_wizard).experience_points
    refute_empty assigns(:evil_wizard).errors
  end

  test "should fetch a list of dungeons during update if params are wrong" do
    put :update, :id => @evil_wizard.to_param, :evil_wizard => @evil_wizard.attributes.merge('experience_points' => "2000")
    assert_not_nil assigns(:dungeons)
  end

  test "should destroy evil wizard" do
    assert_difference('EvilWizard.count', -1) do
      delete :destroy, :id => @evil_wizard.to_param
    end

    assert_redirected_to evil_wizards_path
  end
end
