require 'test_helper'

class TrapScopedTrapInstallationsControllerTest < ActionController::TestCase
  tests TrapInstallationsController
  setup do
    @trap = traps(:one)
    @trap_installation = trap_installations(:one)
  end

  test "should get index" do
    get :index, :trap_id => @trap.to_param
    assert_response :success
    assert_not_nil assigns(:trap_installations)
  end

  test "should fetch only the trap installations for the supplied trap" do
    get :index, :trap_id => @trap.to_param

    assert assigns(:trap_installations).include?(trap_installations(:one))
    refute assigns(:trap_installations).include?(trap_installations(:two))
  end

  test "should get new" do
    get :new, :trap_id => @trap.to_param
    assert_response :success
  end

  test "should prepare the trap installation to be scoped to the supplied trap" do
    get :new, :trap_id => @trap.to_param

    assert_equal @trap, assigns(:trap_installation).trap
  end

  test "should fetch a list of dungeons during new" do
    get :new, :trap_id => @trap.to_param
    assert_not_nil assigns(:dungeons)
  end

  test "should not fetch a list of traps during new" do
    get :new, :trap_id => @trap.to_param
    assert_nil assigns(:traps)
  end

  test "should create trap installation and redirect to show page scoped to supplied trap" do
    assert_difference('TrapInstallation.count') do
      post :create, :trap_installation => @trap_installation.attributes, :trap_id => @trap.to_param
    end

    assert_redirected_to trap_trap_installation_path(@trap, assigns(:trap_installation))
  end

  test "should create trap installation scoped to supplied trap even when no trap_id supplied in trap_installation params" do
    post :create, :trap_installation => @trap_installation.attributes.except('trap_id'), :trap_id => @trap.to_param

    assert_equal @trap, assigns(:trap_installation).trap
  end

  test "should create trap installation scoped to supplied trap even when if an alternative trap_id is supplied in trap_installation params" do
    post :create, :trap_installation => @trap_installation.attributes.merge('trap_id' => traps(:two).id), :trap_id => @trap.to_param

    assert_equal @trap, assigns(:trap_installation).trap
  end

  test "should not create trap installation if params are wrong" do
    assert_no_difference('TrapInstallation.count') do
      post :create, :trap_installation => @trap_installation.attributes.except('dungeon_id'), :trap_id => @trap.to_param
    end

    assert_response :success
  end

  test "should leave the broken trap installation available to the view if params are wrong during create" do
    post :create, :trap_installation => @trap_installation.attributes.except('dungeon_id'), :trap_id => @trap.to_param

    assert assigns(:trap_installation).dungeon.blank?
    refute_empty assigns(:trap_installation).errors
  end

  test "should fetch a list of dungeons during create if params are wrong" do
    post :create, :trap_installation => @trap_installation.attributes.except('dungeon_id'), :trap_id => @trap.to_param
    assert_not_nil assigns(:dungeons)
  end

  test "should not fetch a list of traps during create if params are wrong" do
    post :create, :trap_installation => @trap_installation.attributes.except('dungeon_id'), :trap_id => @trap.to_param
    assert_nil assigns(:traps)
  end

  test "should show the requested trap installation" do
    get :show, :id => @trap_installation.to_param, :trap_id => @trap.to_param
    assert_response :success
    assert_equal @trap_installation, assigns(:trap_installation)
  end

  test "should 404 if the requested trap installation isn't of the supplied trap" do
    assert_raises(ActiveRecord::RecordNotFound) do
      get :show, :id => trap_installations(:two).to_param, :trap_id => @trap.to_param
    end
    # we'd prefer to do
    # assert_response :missing
    # without the assert_raises block, but it doesn't work
  end

  test "should get edit for the requested trap installation" do
    get :edit, :id => @trap_installation.to_param, :trap_id => @trap.to_param
    assert_response :success
    assert_equal @trap_installation, assigns(:trap_installation)
  end

  test "should 404 on edit if the requested trap installation isn't of the supplied trap" do
    assert_raises(ActiveRecord::RecordNotFound) do
      get :edit, :id => trap_installations(:two).to_param, :trap_id => @trap.to_param
    end
  end

  test "should fetch a list of dungeons during edit" do
    get :edit, :id => @trap_installation.to_param, :trap_id => @trap.to_param
    assert_not_nil assigns(:dungeons)
  end

  test "should not fetch a list of traps during edit" do
    get :edit, :id => @trap_installation.to_param, :trap_id => @trap.to_param
    assert_nil assigns(:traps)
  end

  test "should update trap_installation" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes, :trap_id => @trap.to_param
    assert_redirected_to trap_trap_installation_path(@trap, assigns(:trap_installation))
  end

  test "should ignore any attempts to change the trap during an update" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('trap_id' => traps(:two).id), :trap_id => @trap.to_param
    assert_equal @trap, assigns(:trap_installation).trap
    assert_equal @trap, @trap_installation.reload.trap
  end

  test "should 404 if the requested trap_installation is not of the supplied trap" do
    assert_raises(ActiveRecord::RecordNotFound) do
      put :update, :id => trap_installations(:two).to_param, :trap_installation => @trap_installation.attributes, :trap_id => @trap.to_param
    end
  end

  test "should not update trap installation if params are wrong" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('level' => "-1"), :trap_id => @trap.to_param
    assert_response :success
    assert_equal 1, @trap_installation.reload.level
  end

  test "should leave the broken trap installation available to the view if params are wrong during update" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('level' => "-1"), :trap_id => @trap.to_param
    assert_equal -1, assigns(:trap_installation).level
    refute_empty assigns(:trap_installation).errors
  end

  test "should fetch a list of dungeons during update if params are wrong" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('level' => "-1"), :trap_id => @trap.to_param
    assert_not_nil assigns(:dungeons)
  end

  test "should not fetch a list of traps during update if params are wrong" do
    put :update, :id => @trap_installation.to_param, :trap_installation => @trap_installation.attributes.merge('level' => "-1"), :trap_id => @trap.to_param
    assert_nil assigns(:traps)
  end

  test "should destroy trap installation" do
    assert_difference('TrapInstallation.count', -1) do
      delete :destroy, :id => @trap_installation.to_param, :trap_id => @trap.to_param
    end

    assert_redirected_to trap_trap_installations_path(@trap)
  end

  test "should 404 and not destroy the trap installation if it's not of the supplied trap" do
    assert_no_difference('TrapInstallation.count', -1) do
      assert_raises(ActiveRecord::RecordNotFound) do
        delete :destroy, :id => trap_installations(:two).to_param, :trap_id => @trap.to_param
      end
    end
  end
end
