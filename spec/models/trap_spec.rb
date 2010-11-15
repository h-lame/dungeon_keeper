require 'spec_helper'

describe Trap do
  fixtures :all

  it "should require a name" do
    t = Trap.new
    t.name = nil
    t.valid?
    t.errors['name'].should_not be_empty
  end

  it "should require that the name is no more than 200 characters" do
    t = Trap.new
    t.name = 'a' * 201
    t.valid?
    t.errors['name'].should_not be_empty
  end

  it "should allow the name to be exactly 200 characters" do
    t = Trap.new
    t.name = 'a' * 200
    t.valid?
    t.errors['name'].should be_empty
  end

  it "should not allow traps with duplicate names" do
    t = Trap.create!(:name => 'Spike pit', :base_damage_caused => 30)
    t2 = Trap.new(:name => 'Spike pit')
    t2.valid?
    t2.errors['name'].should_not be_empty
  end

  it "should require the base damage caused by the trap" do
    t = Trap.new
    t.base_damage_caused = nil
    t.valid?
    t.errors['base_damage_caused'].should_not be_empty
  end

  it "should require the base damage caused by the trap to be more than 0" do
    t = Trap.new
    t.base_damage_caused = -1
    t.valid?
    t.errors['base_damage_caused'].should_not be_empty
  end

  it "should require the base damage caused by the trap to be no more than 100" do
    t = Trap.new
    t.base_damage_caused = -1
    t.valid?
    t.errors['base_damage_caused'].should_not be_empty
  end

  it "should allow the base damage caused by the trap to be exactly 100" do
    t = Trap.new
    t.base_damage_caused = -1
    t.valid?
    t.errors['base_damage_caused'].should_not be_empty
  end

  it "should not list a dungeon twice if this trap has been installed there more than once" do
    t = Trap.create(:name => 'Fire Pit', :base_damage_caused => 80)
    t.trap_installations.create(:dungeon => dungeons(:one), :level => 1, :size => 'normal')
    t.trap_installations.create(:dungeon => dungeons(:one), :level => 7, :size => 'slightly ridiculous')

    t.dungeons.size.should == 1
    t.dungeons.should include(dungeons(:one))
  end
end
