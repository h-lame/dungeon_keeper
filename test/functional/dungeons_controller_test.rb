require 'test_helper'

class DungeonsControllerTest < ActionController::TestCase
  setup do
    @dungeon = dungeons(:one)
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

  test "should show dungeon" do
    get :show, :id => @dungeon.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @dungeon.to_param
    assert_response :success
  end

  test "should update dungeon" do
    put :update, :id => @dungeon.to_param, :dungeon => @dungeon.attributes
    assert_redirected_to dungeon_path(assigns(:dungeon))
  end

  test "should destroy dungeon" do
    assert_difference('Dungeon.count', -1) do
      delete :destroy, :id => @dungeon.to_param
    end

    assert_redirected_to dungeons_path
  end
end
