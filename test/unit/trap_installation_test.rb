require 'test_helper'

class TrapInstallationTest < ActiveSupport::TestCase
  should validate_presence_of(:trap)
  should validate_presence_of(:dungeon)

  should validate_presence_of(:level)
  should "require that the trap installation level is more than 0" do
    ti = TrapInstallation.new
    ti.level = 0
    ti.valid?
    refute_empty ti.errors['level']
  end

  should "require that the trap installation level is not on a level that the dungeon doesn't have" do
    ti = TrapInstallation.new(:dungeon => Dungeon.create(:name => "The Great Stygian Abyss", :levels => 8))
    ti.level = 9
    ti.valid?
    refute_empty ti.errors['level']
  end

  TrapInstallation::SIZES.each do |valid_size|
    should allow_value(valid_size).for(:size)
  end
  should "disallow the size if it's not one of the prescribed sizes of a trap installation" do
    ti = TrapInstallation.new
    [nil, '', 'this is very unlikely to be a valid size for a trap installation'].each do |invalid_size|
      ti.size = invalid_size
      ti.valid?
      refute_empty ti.errors['size']
    end
  end

  context "the maximum possible level for installation" do
    should "be 1 if there there is no dungeon" do
      ti = TrapInstallation.new
      ti.dungeon = nil
      assert_equal 1, ti.maximum_possible_level_for_installation
    end

    should "be the maximum level of the dungeon" do
      ti = TrapInstallation.new
      ti.dungeon = Dungeon.new(:levels => 12)
      assert_equal 12, ti.maximum_possible_level_for_installation
    end
  end

  context "the damage caused" do
    should "be the base damage caused of the trap * the level the trap is installed on for a normal sized trap installation" do
      ti = TrapInstallation.new(:size => 'normal', :level => 2)
      ti.trap = Trap.new(:base_damage_caused => 20)
      assert_equal 40, ti.damage_caused
    end

    should "be 1/2 of the base damage caused of the trap * the level the trap is installed on for a small sized trap installation" do
      ti = TrapInstallation.new(:size => 'small', :level => 5)
      ti.trap = Trap.new(:base_damage_caused => 20)
      assert_equal 50, ti.damage_caused
    end

    should "be twice the base damage caused of the trap * the level the trap is installed on for a big sized trap installation" do
      ti = TrapInstallation.new(:size => 'big', :level => 3)
      ti.trap = Trap.new(:base_damage_caused => 20)
      assert_equal 120, ti.damage_caused
    end

    should "be the square of the base damage caused of the trap * the level the trap is installed on for a slightly ridiculous sized trap installation" do
      ti = TrapInstallation.new(:size => 'slightly ridiculous', :level => 3)
      ti.trap = Trap.new(:base_damage_caused => 20)
      assert_equal 3_600, ti.damage_caused
    end

    should "be 0 if the trap installation is fake" do
      [{:level => 1, :size => 'normal', :trap => Trap.new(:base_damage_caused => 20)},
       {:level => 8, :size => 'big', :trap => Trap.new(:base_damage_caused => 100)},
       {:level => 100, :size => 'small', :trap => Trap.new(:base_damage_caused => 1_000)}].each do |installation_details|
        ti = TrapInstallation.new(installation_details)
        ti.fake = true
        assert_equal 0, ti.damage_caused
      end
    end
  end

  context "the 'of' scope" do
    should "return trap installations that are installations of the supplied trap" do
      t1 = Trap.create(:name => 'laser tripwire mine', :base_damage_caused => 60)
      t2 = Trap.create(:name => 'springy branch with a nail in it', :base_damage_caused => 14)

      d = Dungeon.create(:name => 'Hythloth', :levels => 9)

      ti1 = TrapInstallation.create(:trap => t1, :dungeon => d, :level => 1, :size => 'small')
      ti2 = TrapInstallation.create(:trap => t1, :dungeon => d, :level => 2, :size => 'small')
      ti3 = TrapInstallation.create(:trap => t2, :dungeon => d, :level => 3, :size => 'normal')

      installations = TrapInstallation.of(t1)
      assert_equal 2, installations.size
      assert installations.include?(ti1)
      assert installations.include?(ti2)
      refute installations.include?(ti3)
    end
  end

  context "the 'in' scope" do
    should "return trap installations that have been installed in the supplied dungeon" do
      t = Trap.create(:name => 'laser tripwire mine', :base_damage_caused => 60)

      d1 = Dungeon.create(:name => 'Hythloth', :levels => 9)
      d2 = Dungeon.create(:name => 'Malice', :levels => 4)

      ti1 = TrapInstallation.create(:trap => t, :dungeon => d1, :level => 1, :size => 'small')
      ti2 = TrapInstallation.create(:trap => t, :dungeon => d2, :level => 2, :size => 'small')
      ti3 = TrapInstallation.create(:trap => t, :dungeon => d1, :level => 3, :size => 'normal')

      installations = TrapInstallation.in(d1)
      assert_equal 2, installations.size
      assert installations.include?(ti1)
      assert installations.include?(ti3)
      refute installations.include?(ti2)

    end
  end
end
