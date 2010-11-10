require 'test_helper'

class TrapTest < ActiveSupport::TestCase
  test "should require a name" do
    t = Trap.new
    t.name = nil
    t.valid?
    refute_empty t.errors['name']
  end

  test "should require that the name is no more than 200 characters" do
    t = Trap.new
    t.name = 'a' * 201
    t.valid?
    refute_empty t.errors['name']
  end

  test "should allow the name to be exactly 200 characters" do
    t = Trap.new
    t.name = 'a' * 200
    t.valid?
    assert_empty t.errors['name']
  end

  test "should not allow traps with duplicate names" do
    t = Trap.create!(:name => 'Spike pit', :base_damage_caused => 30)
    t2 = Trap.new(:name => 'Spike pit')
    t2.valid?
    refute_empty t2.errors['name']
  end

  test "should require the base damage caused by the trap" do
    t = Trap.new
    t.base_damage_caused = nil
    t.valid?
    refute_empty t.errors['base_damage_caused']
  end

  test "should require the base damage caused by the trap to be more than 0" do
    t = Trap.new
    t.base_damage_caused = -1
    t.valid?
    refute_empty t.errors['base_damage_caused']
  end

  test "should require the base damage caused by the trap to be no more than 100" do
    t = Trap.new
    t.base_damage_caused = -1
    t.valid?
    refute_empty t.errors['base_damage_caused']
  end

  test "should allow the base damage caused by the trap to be exactly 100" do
    t = Trap.new
    t.base_damage_caused = -1
    t.valid?
    refute_empty t.errors['base_damage_caused']
  end
end
