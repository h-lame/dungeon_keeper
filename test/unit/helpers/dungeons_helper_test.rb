require 'test_helper'

class DungeonsHelperTest < ActionView::TestCase
  context "show_evil_wizard_for_dungeon" do
    should "return a link to the evil wizard for the dungeon" do
      d = Dungeon.create!(:name => 'Despair' , :levels => 4)
      e = d.create_evil_wizard(:name => 'David Blaine', :magic_school => 'stage', :experience_points => 450)

      render :text => show_evil_wizard_for_dungeon(d)
      assert_select 'a[href=?]', evil_wizard_path(e)
    end

    should "return a link to adding a new evil wizard if the dungeon doesn't have an evil wizard in it" do
      d = Dungeon.create!(:name => 'Despair' , :levels => 4)
      d.evil_wizard = nil
      render :text => show_evil_wizard_for_dungeon(d)
      assert_select 'a[href=?]', new_evil_wizard_path
    end
  end
end
