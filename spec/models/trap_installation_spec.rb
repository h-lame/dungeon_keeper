require 'spec_helper'

describe TrapInstallation do
  fixtures :all

  it "should require that the trap installation has a trap that is being installed" do
    ti = TrapInstallation.new
    ti.trap = nil
    ti.valid?
    ti.errors['trap'].should_not be_empty
  end

  it "should require that the trap installation is being installed in a dungeon" do
    ti = TrapInstallation.new
    ti.dungeon = nil
    ti.valid?
    ti.errors['dungeon'].should_not be_empty
  end

  it "should require that the trap installation knows what level of the dungeon it is being installed on" do
    ti = TrapInstallation.new
    ti.level = nil
    ti.valid?
    ti.errors['level'].should_not be_empty
  end

  it "should require that the trap installation level is more than 0" do
    ti = TrapInstallation.new
    ti.level = 0
    ti.valid?
    ti.errors['level'].should_not be_empty
  end

  it "should require that the trap installation level is not on a level that the dungeon doesn't have" do
    ti = TrapInstallation.new(:dungeon => Dungeon.create(:name => "The Great Stygian Abyss", :levels => 8))
    ti.level = 9
    ti.valid?
    ti.errors['level'].should_not be_empty
  end

  it "should allow the size if it's one of the prescribed sizes of a trap installation" do
    ti = TrapInstallation.new
    TrapInstallation::SIZES.each do |valid_size|
      ti.size = valid_size
      ti.valid?
      ti.errors['size'].should be_empty
    end
  end

  it "should disallow the size if it's not one of the prescribed sizes of a trap installation" do
    ti = TrapInstallation.new
    [nil, '', 'this is very unlikely to be a valid size for a trap installation'].each do |invalid_size|
      ti.size = invalid_size
      ti.valid?
      ti.errors['size'].should_not be_empty
    end
  end

  it "the maximum possible level for installation should be 1 if there there is no dungeon" do
    ti = TrapInstallation.new
    ti.dungeon = nil
    ti.maximum_possible_level_for_installation.should == 1
  end

  it "the maximum possible level for installation should be the maximum level of the dungeon" do
    ti = TrapInstallation.new
    ti.dungeon = Dungeon.new(:levels => 12)
    ti.maximum_possible_level_for_installation.should == 12
  end

  it "the damage caused for a normal sized trap installation should be the base damage caused of the trap * the level the trap is installed on" do
    ti = TrapInstallation.new(:size => 'normal', :level => 2)
    ti.trap = Trap.new(:base_damage_caused => 20)
    ti.damage_caused.should == 40
  end

  it "the damage caused for a small sized trap installation should be 1/2 of the base damage caused of the trap * the level the trap is installed on" do
    ti = TrapInstallation.new(:size => 'small', :level => 5)
    ti.trap = Trap.new(:base_damage_caused => 20)
    ti.damage_caused.should == 50
  end

  it "the damage caused for a big sized trap installation should be twice the base damage caused of the trap * the level the trap is installed on" do
    ti = TrapInstallation.new(:size => 'big', :level => 3)
    ti.trap = Trap.new(:base_damage_caused => 20)
    ti.damage_caused.should == 120
  end

  it "the damage caused for a slightly ridiculous sized trap installation should be the square of the base damage caused of the trap * the level the trap is installed on" do
    ti = TrapInstallation.new(:size => 'slightly ridiculous', :level => 3)
    ti.trap = Trap.new(:base_damage_caused => 20)
    ti.damage_caused.should == 3_600
  end

  it "regardless of level or size of the trap installation, or the base damage caused by the trap, a fake trap installation should cause no damage" do
    [{:level => 1, :size => 'normal', :trap => Trap.new(:base_damage_caused => 20)},
     {:level => 8, :size => 'big', :trap => Trap.new(:base_damage_caused => 100)},
     {:level => 100, :size => 'small', :trap => Trap.new(:base_damage_caused => 1_000)}].each do |installation_details|
      ti = TrapInstallation.new(installation_details)
      ti.fake = true
      ti.damage_caused.should == 0
    end
  end

  it "the 'of' scope should return trap installations that are installations of the supplied trap" do
    t1 = Trap.create(:name => 'laser tripwire mine', :base_damage_caused => 60)
    t2 = Trap.create(:name => 'springy branch with a nail in it', :base_damage_caused => 14)

    d = Dungeon.create(:name => 'Hythloth', :levels => 9)

    ti1 = TrapInstallation.create(:trap => t1, :dungeon => d, :level => 1, :size => 'small')
    ti2 = TrapInstallation.create(:trap => t1, :dungeon => d, :level => 2, :size => 'small')
    ti3 = TrapInstallation.create(:trap => t2, :dungeon => d, :level => 3, :size => 'normal')

    installations = TrapInstallation.of(t1)

    installations.size.should == 2
    installations.should include(ti1)
    installations.should include(ti2)
    installations.should_not include(ti3)
  end

  it "the 'in' scope should return trap installations that have been installed in the supplied dungeon" do
    t = Trap.create(:name => 'laser tripwire mine', :base_damage_caused => 60)

    d1 = Dungeon.create(:name => 'Hythloth', :levels => 9)
    d2 = Dungeon.create(:name => 'Malice', :levels => 4)

    ti1 = TrapInstallation.create(:trap => t, :dungeon => d1, :level => 1, :size => 'small')
    ti2 = TrapInstallation.create(:trap => t, :dungeon => d2, :level => 2, :size => 'small')
    ti3 = TrapInstallation.create(:trap => t, :dungeon => d1, :level => 3, :size => 'normal')

    installations = TrapInstallation.in(d1)
    installations.size.should == 2
    installations.should include(ti1)
    installations.should include(ti3)
    installations.should_not include(ti2)

  end
end
