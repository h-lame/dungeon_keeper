require 'test_helper'

class TrapInstallationsControllerTest < ActionController::TestCase
  setup do
    @trap_installation = trap_installations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trap_installations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should fetch a list of dungeons during new" do
    get :new
    assert_not_nil assigns(:dungeons)
  end

  test "should fetch a list of traps during new" do
    get :new
    assert_not_nil assigns(:traps)
  end

  test "should create trap installation" do
    assert_difference('TrapInstallation.count') do
      post :create, :trap_installation => @trap_installation.attributes
    end

    assert_redirected_to trap_installation_path(assigns(:trap_installation))
  end

  test "should not create trap installation if params are wrong" do
    assert_no_difference('TrapInstallation.count') do
      post :create, :dungeon => @trap_installation.attributes.except('dungeon_id')
    end

    assert_response :success
  end

  test "should leave the broken trap installation available to the view if params are wrong during create" do
    post :create, :dungeon => @trap_installation.attributes.except('dungeon_id')

    assert assigns(:trap_installation).dungeon.blank?
    refute_empty assigns(:trap_installation).errors
  end

  test "should fetch a list of dungeons during create if params are wrong" do
    post :create, :dungeon => @trap_installation.attributes.except('dungeon_id')
    assert_not_nil assigns(:dungeons)
  end

  test "should fetch a list of traps during create if params are wrong" do
    post :create, :dungeon => @trap_installation.attributes.except('dungeon_id')
    assert_not_nil assigns(:traps)
  end

  test "should show the requested trap installation" do
    get :show, :id => @trap_installation.to_param
    assert_response :success
    assert_equal @trap_installation, assigns(:trap_installation)
  end

  test "should get edit for the requested trap installation" do
    get :edit, :id => @trap_installation.to_param
    assert_response :success
    assert_equal @trap_installation, assigns(:trap_installation)
  end

  test "should fetch a list of dungeons during edit" do
    get :edit, :id => @trap_installation.to_param
    assert_not_nil assigns(:dungeons)
  end

  test "should fetch a list of traps during edit" do
    get :edit, :id => @trap_installation.to_param
    assert_not_nil assigns(:traps)
  end

  test "should update trap_installation" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes
    assert_redirected_to trap_installation_path(assigns(:trap_installation))
  end

  test "should not update trap installation if params are wrong" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('level' => "-1")
    assert_response :success
    assert_equal 1, @trap_installation.reload.level
  end

  test "should leave the broken trap installation available to the view if params are wrong during update" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('level' => "-1")
    assert_equal -1, assigns(:trap_installation).level
    refute_empty assigns(:trap_installation).errors
  end

  test "should fetch a list of dungeons during update if params are wrong" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('level' => "-1")
    assert_not_nil assigns(:dungeons)
  end

  test "should fetch a list of traps during update if params are wrong" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('level' => "-1")
    assert_not_nil assigns(:traps)
  end

  test "should destroy trap installation" do
    assert_difference('TrapInstallation.count', -1) do
      delete :destroy, :id => @trap_installation.to_param
    end

    assert_redirected_to trap_installations_path
  end
end
