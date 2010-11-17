require 'test_helper'

class DungeonsControllerTest < ActionController::TestCase
  setup do
    @dungeon = Factory.create(:dungeon)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dungeons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dungeon" do
    @dungeon.destroy
    assert_difference('Dungeon.count') do
      post :create, :dungeon => @dungeon.attributes
    end

    assert_redirected_to dungeon_path(assigns(:dungeon))
  end

  test "should not create dungeon if params are wrong" do
    Dungeon.any_instance.stubs(:save).returns(false)
    assert_no_difference('Dungeon.count') do
      post :create, :dungeon => @dungeon.attributes
    end

    assert_response :success
  end

  test "should leave the broken dungeon available to the view if params are wrong during create" do
    Dungeon.any_instance.stubs(:save).returns(false)
    post :create, :dungeon => @dungeon.attributes

    assert assigns(:dungeon).new_record?
  end

  test "should show the requested dungeon" do
    get :show, :id => @dungeon.to_param
    assert_response :success
    assert_equal @dungeon, assigns(:dungeon)
  end

  test "should get edit for the requested dungeon" do
    get :edit, :id => @dungeon.to_param
    assert_response :success
    assert_equal @dungeon, assigns(:dungeon)
  end

  test "should update dungeon" do
    put :update, :id => @dungeon.to_param, :dungeon => @dungeon.attributes.merge('levels' => "200")
    assert_redirected_to dungeon_path(assigns(:dungeon))
    assert_equal 200, @dungeon.reload.levels
  end

  test "should not update dungeon if params are wrong" do
    Dungeon.any_instance.stubs(:save).returns(false)
    put :update, :id => @dungeon.to_param, :dungeon => @dungeon.attributes.merge('levels' => "200")
    assert_response :success
    assert_equal 8, @dungeon.reload.levels
  end

  test "should leave the broken dungeon available to the view if params are wrong during update" do
    Dungeon.any_instance.stubs(:save).returns(false)
    put :update, :id => @dungeon.to_param, :dungeon => @dungeon.attributes.merge('levels' => "200")
    assert_equal 200, assigns(:dungeon).levels
  end

  test "should destroy dungeon" do
    assert_difference('Dungeon.count', -1) do
      delete :destroy, :id => @dungeon.to_param
    end

    assert_redirected_to dungeons_path
  end
end
