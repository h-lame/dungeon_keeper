require 'spec_helper'

describe Dungeon do
  fixtures :all

  it "should require a name" do
    d = Dungeon.new
    d.name = nil
    d.valid?
    d.errors['name'].should_not be_empty
  end

  it "should require that the name is no more than 200 characters" do
    d = Dungeon.new
    d.name = 'a' * 201
    d.valid?
    d.errors['name'].should_not be_empty
  end

  it "should allow the name to be exactly 200 characters" do
    d = Dungeon.new
    d.name = 'a' * 200
    d.valid?
    d.errors['name'].should be_empty
  end

  it "should not allow dungeons with duplicate names" do
    d = Dungeon.create!(:name => 'The Great Stygian Abyss', :levels => 8)
    d2 = Dungeon.new(:name => 'The Great Stygian Abyss')
    d2.valid?
    d2.errors['name'].should_not be_empty
  end

  it "should require a count of the number of levels in the dungeon" do
    d = Dungeon.new
    d.levels = nil
    d.valid?
    d.errors['levels'].should_not be_empty
  end

  it "should require a the count of levels to be more than 0" do
    d = Dungeon.new
    d.levels = -1
    d.valid?
    d.errors['levels'].should_not be_empty
  end

  it "should not list a trap twice if it's been installed more than once" do
    d = Dungeon.create(:name => 'The Great Stygian Abyss', :levels => 8)

    d.trap_installations.create(:trap => traps(:one), :level => 1, :size => 'normal')
    d.trap_installations.create(:trap => traps(:one), :level => 7, :size => 'slightly ridiculous')


    d.traps.size.should == 1
    d.traps.should include(traps(:one))
  end

  it "the 'without_an_evil_wizard' scope should return dungeons that don't have an evil wizard" do
    d1 = Dungeon.create!(:name => 'Despair', :levels => 4)
    d2 = Dungeon.create!(:name => 'Destard', :levels => 6)

    d1.create_evil_wizard(:name => 'David Blaine', :magic_school => 'stage', :experience_points => 450)

    fetched = Dungeon.without_an_evil_wizard

    fetched.should include(d2)
    fetched.should_not include(d1)
  end

  it "when we save the dungeon the experience points for defeating the dungeon should be set automatically" do
    d = Dungeon.new(:name => 'Despair', :levels => 4)
    d.experience_points.should == 0
    assert d.save
    d.experience_points.should_not == 0
  end

  it "experience points for defeating the dungeon should be 2 to the power of the number of levels" do
    d = Dungeon.create(:name => 'Despair', :levels => 12)
    d.experience_points.should == 2^12
  end

  it "when we change the number of levels of a dungeon the experience points should also change accordingly when we save the dungeon" do
    d = Dungeon.create(:name => 'Despair', :levels => 4)
    old_xp = d.experience_points
    d.levels = 9
    d.save
    d.experience_points.should_not == old_xp
  end
end
