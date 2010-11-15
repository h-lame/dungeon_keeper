require 'test_helper'

class DungeonsHelperTest < ActionView::TestCase
  test "show_evil_wizard_for_dungeon should return a link to the evil wizard for the dungeon" do
    d = Factory.create(:dungeon_with_evil_wizard)

    render :text => show_evil_wizard_for_dungeon(d)
    assert_select 'a[href=?]', evil_wizard_path(d.evil_wizard)
  end

  test "show_evil_wizard_for_dungeon should return a link to adding a new evil wizard if the dungeon doesn't have an evil wizard in it" do
    d = Factory.create(:dungeon)
    render :text => show_evil_wizard_for_dungeon(d)
    assert_select 'a[href=?]', new_evil_wizard_path
  end
end
