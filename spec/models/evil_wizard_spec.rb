require 'spec_helper'

describe EvilWizard do
  fixtures :all

  it "should require a name" do
    e = EvilWizard.new
    e.name = nil
    e.valid?
    e.errors['name'].should_not be_empty
  end

  it "should require that the name is no more than 200 characters" do
    e = EvilWizard.new
    e.name = 'a' * 201
    e.valid?
    e.errors['name'].should_not be_empty
  end

  it "should allow the name to be exactly 200 characters" do
    e = EvilWizard.new
    e.name = 'a' * 200
    e.valid?
    e.errors['name'].should be_empty
  end

  it "should not allow evil wizards with duplicate names" do
    e = EvilWizard.create!(:name => 'Batlin', :experience_points => 800, :magic_school => 'fire', :dungeon => Dungeon.create(:name => 'The Great Stygian Abyss', :levels => 8))
    e2 = EvilWizard.new(:name => 'Batlin')
    e2.valid?
    e2.errors['name'].should_not be_empty
  end

  it "should require the number of experience points to be received when defeating the wizard" do
    e = EvilWizard.new
    e.experience_points = nil
    e.valid?
    e.errors['experience_points'].should_not be_empty
  end

  it "should require the number of experience points to be received when defeating the wizard to be more than 0" do
    e = EvilWizard.new
    e.experience_points = -1
    e.valid?
    e.errors['experience_points'].should_not be_empty
  end

  it "should require the number of experience points to be received when defeating the wizard to be no more than 1000" do
    e = EvilWizard.new
    e.experience_points = 1001
    e.valid?
    e.errors['experience_points'].should_not be_empty
  end

  it "should allow the number of experience points to be received when defeating the wizard to be exactly 1000" do
    e = EvilWizard.new
    e.experience_points = 1000
    e.valid?
    e.errors['experience_points'].should be_empty
  end

  it "should require that the wizard belongs to a dungeon" do
    e = EvilWizard.new
    e.dungeon = nil
    e.valid?
    e.errors['dungeon'].should_not be_empty
  end

  it "should require that the wizard has a school of magic" do
    e = EvilWizard.new
    e.magic_school = nil
    e.valid?
    e.errors['magic_school'].should_not be_empty
  end

  it "should allow the wizard's school of magic to be one of the pre-defined ones" do
    e = EvilWizard.new
    EvilWizard::MAGIC_SCHOOLS.each do |valid_magic_school|
      e.magic_school = valid_magic_school
      e.valid?
      e.errors['magic_school'].should be_empty
    end
  end

  it "should disallow the wizard's school of magic if it's not one of the pre-defined ones" do
    e = EvilWizard.new
    e.magic_school = 'not likely to be a valid school of magic'
    e.valid?
    e.errors['magic_school'].should_not be_empty
  end
end
