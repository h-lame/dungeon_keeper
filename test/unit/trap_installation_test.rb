require 'test_helper'

class TrapInstallationTest < ActiveSupport::TestCase
  test "should require that the trap installation has a trap that is being installed" do
    ti = Factory.build(:trap_installation)
    ti.trap = nil
    ti.valid?
    refute_empty ti.errors['trap']
  end

  test "should require that the trap installation is being installed in a dungeon" do
    ti = Factory.build(:trap_installation)
    ti.dungeon = nil
    ti.valid?
    refute_empty ti.errors['dungeon']
  end

  test "should require that the trap installation knows what level of the dungeon it is being installed on" do
    ti = Factory.build(:trap_installation)
    ti.level = nil
    ti.valid?
    refute_empty ti.errors['level']
  end

  test "should require that the trap installation level is more than 0" do
    ti = Factory.build(:trap_installation)
    ti.level = 0
    ti.valid?
    refute_empty ti.errors['level']
  end

  test "should require that the trap installation level is not on a level that the dungeon doesn't have" do
    ti = Factory.build(:trap_installation, :dungeon => Factory.create(:dungeon, :levels => 8))
    ti.level = 9
    ti.valid?
    refute_empty ti.errors['level']
  end

  test "should allow the size if it's one of the prescribed sizes of a trap installation" do
    ti = Factory.build(:trap_installation)
    TrapInstallation::SIZES.each do |valid_size|
      ti.size = valid_size
      ti.valid?
      assert_empty ti.errors['size']
    end
  end

  test "should disallow the size if it's not one of the prescribed sizes of a trap installation" do
    ti = Factory.build(:trap_installation)
    [nil, '', 'this is very unlikely to be a valid size for a trap installation'].each do |invalid_size|
      ti.size = invalid_size
      ti.valid?
      refute_empty ti.errors['size']
    end
  end

  test "the maximum possible level for installation should be 1 if there there is no dungeon" do
    ti = Factory.build(:trap_installation)
    ti.dungeon = nil
    assert_equal 1, ti.maximum_possible_level_for_installation
  end

  test "the maximum possible level for installation should be the maximum level of the dungeon" do
    ti = Factory.build(:trap_installation)
    ti.dungeon = Factory.build(:dungeon, :levels => 12)
    assert_equal 12, ti.maximum_possible_level_for_installation
  end

  test "the damage caused for a normal sized trap installation should be the base damage caused of the trap * the level the trap is installed on" do
    ti = Factory.build(:trap_installation, :size => 'normal', :level => 2, :trap => Factory.build(:trap, :base_damage_caused => 20))
    assert_equal 40, ti.damage_caused
  end

  test "the damage caused for a small sized trap installation should be 1/2 of the base damage caused of the trap * the level the trap is installed on" do
    ti = Factory.build(:trap_installation, :size => 'small', :level => 5, :trap => Factory.build(:trap, :base_damage_caused => 20))
    assert_equal 50, ti.damage_caused
  end

  test "the damage caused for a big sized trap installation should be twice the base damage caused of the trap * the level the trap is installed on" do
    ti = Factory.build(:trap_installation, :size => 'big', :level => 3, :trap => Factory.build(:trap, :base_damage_caused => 20))
    assert_equal 120, ti.damage_caused
  end

  test "the damage caused for a slightly ridiculous sized trap installation should be the square of the base damage caused of the trap * the level the trap is installed on" do
    ti = Factory.build(:trap_installation, :size => 'slightly ridiculous', :level => 3, :trap => Factory.build(:trap, :base_damage_caused => 20))
    assert_equal 3_600, ti.damage_caused
  end

  test "regardless of level or size of the trap installation, or the base damage caused by the trap, a fake trap installation should cause no damage" do
    [{:level => 1, :size => 'normal', :trap => Factory.build(:trap, :base_damage_caused => 20)},
     {:level => 8, :size => 'big', :trap => Factory.build(:trap, :base_damage_caused => 100)},
     {:level => 100, :size => 'small', :trap => Factory.build(:trap, :base_damage_caused => 1_000)}].each do |installation_details|
      ti = Factory.build(:trap_installation, installation_details)
      ti.fake = true
      assert_equal 0, ti.damage_caused
    end
  end

  test "the 'of' scope should return trap installations that are installations of the supplied trap" do
    t1 = Factory.create(:trap)
    t2 = Factory.create(:trap)

    ti1 = Factory.create(:trap_installation, :trap => t1)
    ti2 = Factory.create(:trap_installation, :trap => t1) 
    ti3 = Factory.create(:trap_installation, :trap => t2) 

    installations = TrapInstallation.of(t1)
    assert_equal 2, installations.size
    assert installations.include?(ti1)
    assert installations.include?(ti2)
    refute installations.include?(ti3)
  end

  test "the 'in' scope should return trap installations that have been installed in the supplied dungeon" do
    d1 = Factory.create(:dungeon)
    d2 = Factory.create(:dungeon)

    ti1 = Factory.create(:trap_installation, :dungeon => d1)
    ti2 = Factory.create(:trap_installation, :dungeon => d2)
    ti3 = Factory.create(:trap_installation, :dungeon => d1)

    installations = TrapInstallation.in(d1)
    assert_equal 2, installations.size
    assert installations.include?(ti1)
    assert installations.include?(ti3)
    refute installations.include?(ti2)
  end
end
