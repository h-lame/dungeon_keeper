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
end
