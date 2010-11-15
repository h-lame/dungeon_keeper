require 'test_helper'

class TrapsControllerTest < ActionController::TestCase
  setup do
    @trap = Factory.create(:trap)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:traps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trap" do
    @trap.destroy
    assert_difference('Trap.count') do
      post :create, :trap => @trap.attributes
    end

    assert_redirected_to trap_path(assigns(:trap))
  end

  test "should not create trap if params are wrong" do
    assert_no_difference('Trap.count') do
      post :create, :trap => @trap.attributes.except('name')
    end

    assert_response :success
  end

  test "should leave the broken trap available to the view if params are wrong during create" do
    post :create, :trap => @trap.attributes.except('name')

    assert assigns(:trap).name.blank?
    refute_empty assigns(:trap).errors
  end

  test "should show the requested trap" do
    get :show, :id => @trap.to_param
    assert_response :success
    assert_equal @trap, assigns(:trap)
  end

  test "should get edit for the requested trap" do
    get :edit, :id => @trap.to_param
    assert_response :success
    assert_equal @trap, assigns(:trap)
  end

  test "should update trap" do
    put :update, :id => @trap.to_param, :trap => @trap.attributes.merge('base_damage_caused' => "60")
    assert_redirected_to trap_path(assigns(:trap))
    assert_equal 60, @trap.reload.base_damage_caused
  end

  test "should not update trap if params are wrong" do
    put :update, :id => @trap.to_param, :trap => @trap.attributes.merge('base_damage_caused' => "-1")
    assert_response :success
    assert_equal 20, @trap.reload.base_damage_caused
  end

  test "should leave the broken trap available to the view if params are wrong during update" do
    put :update, :id => @trap.to_param, :trap => @trap.attributes.merge('base_damage_caused' => "-1")
    assert_equal -1, assigns(:trap).base_damage_caused
    refute_empty assigns(:trap).errors
  end

  test "should destroy trap" do
    assert_difference('Trap.count', -1) do
      delete :destroy, :id => @trap.to_param
    end

    assert_redirected_to traps_path
  end
end
