require 'spec_helper'

describe DungeonsHelper do
  context "show_evil_wizard_for_dungeon" do
    it "should return a link to the evil wizard for the dungeon" do
      d = Dungeon.create!(:name => 'Despair' , :levels => 4)
      e = d.create_evil_wizard(:name => 'David Blaine', :magic_school => 'stage', :experience_points => 450)

      helper.show_evil_wizard_for_dungeon(d).should have_selector('a', :href => evil_wizard_path(e))
    end

    it "should return a link to adding a new evil wizard if the dungeon doesn't have an evil wizard in it" do
      d = Dungeon.create!(:name => 'Despair' , :levels => 4)
      d.evil_wizard = nil

      helper.show_evil_wizard_for_dungeon(d).should have_selector('a', :href => new_evil_wizard_path)
    end
  end
end
