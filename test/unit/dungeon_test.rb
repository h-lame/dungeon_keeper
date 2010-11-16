require 'test_helper'

class DungeonTest < ActiveSupport::TestCase
  test "should require a name" do
    d = Dungeon.new
    d.name = nil
    d.valid?
    refute_empty d.errors['name']
  end

  test "should require that the name is no more than 200 characters" do
    d = Dungeon.new
    d.name = 'a' * 201
    d.valid?
    refute_empty d.errors['name']
  end

  test "should allow the name to be exactly 200 characters" do
    d = Dungeon.new
    d.name = 'a' * 200
    d.valid?
    assert_empty d.errors['name']
  end

  test "should not allow dungeons with duplicate names" do
    d = Dungeon.create!(:name => 'The Great Stygian Abyss', :levels => 8)
    d2 = Dungeon.new(:name => 'The Great Stygian Abyss')
    d2.valid?
    refute_empty d2.errors['name']
  end

  test "should require a count of the number of levels in the dungeon" do
    d = Dungeon.new
    d.levels = nil
    d.valid?
    refute_empty d.errors['levels']
  end

  test "should require a the count of levels to be more than 0" do
    d = Dungeon.new
    d.levels = -1
    d.valid?
    refute_empty d.errors['levels']
  end

  test "should not list a trap twice if it's been installed more than once" do
    d = Dungeon.create(:name => 'The Great Stygian Abyss', :levels => 8)
    d.trap_installations.create(:trap => traps(:one), :level => 1, :size => 'normal')
    d.trap_installations.create(:trap => traps(:one), :level => 7, :size => 'slightly ridiculous')

    assert_equal 1, d.traps.size
    assert d.traps.include?(traps(:one))
  end

  test "the 'without_an_evil_wizard' scope should return dungeons that don't have an evil wizard" do
    d1 = Dungeon.create!(:name => 'Despair', :levels => 4)
    d2 = Dungeon.create!(:name => 'Destard', :levels => 6)

    d1.create_evil_wizard(:name => 'David Blaine', :magic_school => 'stage', :experience_points => 450)

    fetched = Dungeon.without_an_evil_wizard

    assert fetched.include?(d2)
    refute fetched.include?(d1)
  end

  test "when we save the dungeon the experience points for defeating the dungeon should be set automatically" do
    d = Dungeon.new(:name => 'Despair', :levels => 4)
    assert_equal 0, d.experience_points
    assert d.save
    refute_equal 0, d.experience_points
  end

  test "experience points for defeating the dungeon should be 2 to the power of the number of levels" do
    d = Dungeon.create(:name => 'Despair', :levels => 12)
    assert_equal 2**12, d.experience_points
  end

  test "when we change the number of levels of a dungeon the experience points should also change accordingly when we save the dungeon" do
    d = Dungeon.create(:name => 'Despair', :levels => 4)
    old_xp = d.experience_points
    d.levels = 9
    d.save
    refute_equal old_xp, d.experience_points
  end
end
