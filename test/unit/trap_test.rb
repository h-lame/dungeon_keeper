require 'test_helper'

class TrapTest < ActiveSupport::TestCase
  test "should require a name" do
    t = Factory.build(:trap)
    t.name = nil
    t.valid?
    refute_empty t.errors['name']
  end

  test "should require that the name is no more than 200 characters" do
    t = Factory.build(:trap)
    t.name = 'a' * 201
    t.valid?
    refute_empty t.errors['name']
  end

  test "should allow the name to be exactly 200 characters" do
    t = Factory.build(:trap)
    t.name = 'a' * 200
    t.valid?
    assert_empty t.errors['name']
  end

  test "should not allow traps with duplicate names" do
    t = Factory.create(:trap)
    t2 = Factory.build(:trap, :name => t.name)
    t2.valid?
    refute_empty t2.errors['name']
  end

  test "should require the base damage caused by the trap" do
    t = Factory.build(:trap)
    t.base_damage_caused = nil
    t.valid?
    refute_empty t.errors['base_damage_caused']
  end

  test "should require the base damage caused by the trap to be more than 0" do
    t = Factory.build(:trap)
    t.base_damage_caused = -1
    t.valid?
    refute_empty t.errors['base_damage_caused']
  end

  test "should require the base damage caused by the trap to be no more than 100" do
    t = Factory.build(:trap)
    t.base_damage_caused = -1
    t.valid?
    refute_empty t.errors['base_damage_caused']
  end

  test "should allow the base damage caused by the trap to be exactly 100" do
    t = Factory.build(:trap)
    t.base_damage_caused = -1
    t.valid?
    refute_empty t.errors['base_damage_caused']
  end

  test "should not list a dungeon twice if this trap has been installed there more than once" do
    t = Factory.create(:trap)
    d = Factory.create(:dungeon)
    Factory.create(:trap_installation, :trap => t, :dungeon => d)
    Factory.create(:trap_installation, :trap => t, :dungeon => d)

    assert_equal 1, t.dungeons.size
    assert t.dungeons.include?(d)
  end
end
