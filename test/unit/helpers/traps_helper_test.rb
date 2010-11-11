require 'test_helper'

class TrapsHelperTest < ActionView::TestCase
  test "dungeons_a_trap_is_installed_in should return a link to each dungeon the trap is installed in" do
    t = Trap.create!(:name => 'Spiky falling block', :base_damage_caused => 20)
    d1 = Dungeon.create!(:name => 'Despair' , :levels => 4)
    d2 = Dungeon.create!(:name => 'Destard' , :levels => 4)
    t.trap_installations.create(:dungeon => d1, :level => 1, :size => 'small')
    t.trap_installations.create(:dungeon => d2, :level => 1, :size => 'small')

    render :text => dungeons_a_trap_is_installed_in(t)
    assert_select 'a[href=?]', dungeon_path(d1)
    assert_select 'a[href=?]', dungeon_path(d2)
  end

  test "dungeons_a_trap_is_installed_in should return a link to adding a new trap installation if the trap hasn't been installed in any dungeons" do
    t = Trap.create!(:name => 'Spiky falling block', :base_damage_caused => 20)
    t.trap_installations.clear
    render :text => dungeons_a_trap_is_installed_in(t)
    assert_select 'a[href=?]', new_trap_trap_installation_path(t)
  end
end
