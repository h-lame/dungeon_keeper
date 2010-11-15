require 'test_helper'

class TrapsHelperTest < ActionView::TestCase
  test "dungeons_a_trap_is_installed_in should return a link to each dungeon the trap is installed in" do
    t = Factory.create(:trap)
    d1 = Factory.create(:dungeon)
    d2 = Factory.create(:dungeon)
    Factory.create(:trap_installation, :dungeon => d1, :trap => t)
    Factory.create(:trap_installation, :dungeon => d2, :trap => t)

    render :text => dungeons_a_trap_is_installed_in(t)
    assert_select 'a[href=?]', dungeon_path(d1)
    assert_select 'a[href=?]', dungeon_path(d2)
  end

  test "dungeons_a_trap_is_installed_in should return a link to adding a new trap installation if the trap hasn't been installed in any dungeons" do
    t = Factory.create(:trap)
    render :text => dungeons_a_trap_is_installed_in(t)
    assert_select 'a[href=?]', new_trap_trap_installation_path(t)
  end
end
